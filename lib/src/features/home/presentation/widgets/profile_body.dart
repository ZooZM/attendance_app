import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:attendance_app/src/features/home/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/delete_user_cubit/delete_user_cubit_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/update_user_cubit/update_user_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/widgets/update_or_delete_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  UserModel? user;
  String? _selectRole;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    final loginState = context.read<LoginCubit>().state;
    if (loginState is LoginSuccess) {
      user = loginState.user;
      _nameController.text = user!.name;
      _emailController.text = user!.email;
      _userNameController.text = user!.userName;
      _passwordController.text = user!.password;
      _confirmPasswordController.text = user!.password;
      _selectRole = user!.role;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  void _updateUser() {
    if (_formKey.currentState!.validate() &&
        _selectRole != null &&
        user != null) {
      final updatedUser = UserModel(
        id: user!.id,
        name: _nameController.text,
        email: _emailController.text,
        attendance: user!.attendance,
        userName: _userNameController.text,
        role: _selectRole!,
        password: _passwordController.text,
        createdAt: user!.createdAt,
      );
      context.read<UpdateUserCubit>().updateUser(updatedUser);
    }
  }

  void _deleteUser() async {
    await context.read<DeleteUserCubit>().deleteUser(user!.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateUserCubit, UpdateUserState>(
          listener: (context, state) {
            if (!mounted) return;
            if (state is UpdateUserSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User updated successfully")),
              );
            } else if (state is UpdateUserFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoginSuccess && user != null) {
            final isUpdating =
                context.watch<UpdateUserCubit>().state is UpdateUserLoading;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        labelText: "UserName",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter username"
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Enter name" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      validator: validateEmail,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Role',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      value: _selectRole,
                      items: ['Employee', 'Customer', 'Manager', 'admin']
                          .map(
                            (role) => DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ),
                          )
                          .toList(),
                      onChanged: (newValue) {
                        setState(() => _selectRole = newValue);
                      },
                      validator: (value) =>
                          value == null ? 'Please select a role' : null,
                    ),
                    const SizedBox(height: 24),
                    if (user != null)
                      UpdateOrDeleteUserWidget(
                        isLoadign: isUpdating,
                        onUpdate: _updateUser,
                        onDelete: _deleteUser,
                      ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No user data available'));
          }
        },
      ),
    );
  }
}
