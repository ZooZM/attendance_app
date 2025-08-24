import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/delete_user_cubit/delete_user_cubit_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/fetch_single_user_cubit/fetch_single_user_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/fetch_users_cubit/fetch_users_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/update_user_cubit/update_user_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/widgets/update_or_delete_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserBody extends StatefulWidget {
  final String userId;
  const UpdateUserBody({super.key, required this.userId});

  @override
  State<UpdateUserBody> createState() => _UpdateUserBodyState();
}

class _UpdateUserBodyState extends State<UpdateUserBody> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  String? _selectRole;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<FetchSingleUserCubit>().fetchUser(widget.userId);
    });
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
        user != null &&
        _selectRole != null) {
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
    if (user != null) {
      await context.read<DeleteUserCubit>().deleteUser(user!.id);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserCubit, UpdateUserState>(
      listener: (context, state) {
        if (!mounted) return;
        if (state is UpdateUserSuccess) {
          context.read<FetchUsersCubit>().fetchUsers();
          Navigator.pop(context);
        } else if (state is UpdateUserFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<FetchSingleUserCubit, FetchSingleUserState>(
        builder: (context, state) {
          if (state is FetchSingleUserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchSingleUserFailure) {
            return Center(child: Text(state.message));
          } else if (state is FetchSingleUserSuccess) {
            if (user == null) {
              user = state.user;
              _nameController.text = user!.name;
              _emailController.text = user!.email;
              _userNameController.text = user!.userName;
              _selectRole = user!.role;
            }
          }

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
                    items: ['Employee', 'Customer', 'Manager']
                        .map(
                          (role) =>
                              DropdownMenuItem(value: role, child: Text(role)),
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
                      isLoadign: state is UpdateUserLoading,
                      onUpdate: _updateUser,
                      onDelete: _deleteUser,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
