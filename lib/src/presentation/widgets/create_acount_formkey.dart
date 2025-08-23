import 'package:attendance_app/src/domain/usecases/craete_acount_use_case.dart';
import 'package:attendance_app/src/presentation/cubits/create_account_cubit/create_account_cubit.dart';
import 'package:attendance_app/src/presentation/widgets/custtom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAcountFormkey extends StatefulWidget {
  const CreateAcountFormkey({super.key});

  @override
  State<CreateAcountFormkey> createState() => _CreateAcountFormkeyState();
}

class _CreateAcountFormkeyState extends State<CreateAcountFormkey> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  String? _selectRole;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate() && _selectRole != null) {
      context.read<CreateAccountCubit>().createAccount(
        CreateAccountParams(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          userName: _userNameController.text,
          role: _selectRole!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 26,
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
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your username";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your name";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            validator: (value) {
              return validateEmail(value);
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please confirm your password";
              }
              if (value != _passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),

          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Role',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            value: _selectRole,
            items: ['Employee', 'Customer', 'Manager'].map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectRole = newValue;
              });
            },
            validator: (value) {
              if (_selectRole != null) {
                return null;
              }
              if (value == null || value.isEmpty) {
                return 'Please select your gender';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          BlocConsumer<CreateAccountCubit, CreateAccountState>(
            listener: (context, state) {
              if (state is CreateAccountSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Account created successfully')),
                );
                _formKey.currentState!.reset();
              } else if (state is CreateAccountFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            builder: (context, state) {
              return CusttomButton(
                text: 'Create Account',
                onPressed: () => _submitForm(context),
                isLoading: state is CreateAccountLoading,
              );
            },
          ),
        ],
      ),
    );
  }
}
