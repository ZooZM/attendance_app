import 'package:attendance_app/src/core/utils/service_locator.dart';
import 'package:attendance_app/src/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:attendance_app/src/presentation/pages/home_page.dart';
import 'package:attendance_app/src/presentation/widgets/custtom_button.dart';
import 'package:attendance_app/src/presentation/widgets/custtom_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      // context.read<LoginCubit>().login(
      //   _emailController.text,
      //   _passwordController.text,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "Sign in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Hi! Welcome back, You've been missed",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "example@gmail.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    // const SizedBox(height: 12),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: _requestPasswordReset,
                    //     child: const Text(
                    //       "Forgot Password?",
                    //       style: TextStyle(color: Color(0xff99A8C2)),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginFailure) {
                          if (state.error.toLowerCase().contains(
                            'verify your email',
                          )) {
                            // context.go(
                            //   AppRouter.kVerifyCodeScreen,
                            //   extra: _emailController.text,
                            // );
                          }
                          if (state.error.toLowerCase().contains(
                            'need verify',
                          )) {
                            // context.go(AppRouter.kTakeSelfie, extra: false);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        } else if (state is LoginSuccess) {
                          // context.go(AppRouter.kHomePage);
                        }
                      },
                      builder: (context, state) {
                        return CusttomButton(
                          text: 'Sign In',
                          onPressed: state is LoginLoading
                              ? null
                              : () {
                                  _signIn(context);
                                  // context.push(AppRouter.kTakeSelfie);
                                },
                          isLoading: state is LoginLoading,
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    CusttomFooter(
                      text: "Don’t have an account?",
                      buttonText: "Sign Up",
                      onPressed: () {
                        // context.push(AppRouter.kSignUp);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
