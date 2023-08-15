import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/screens/forgot_password_screen.dart';
import 'package:doc_saver_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_text_field.dart';

class AuthenticationScreen extends StatefulWidget {
  static String routeName = "/authenticationScreen";
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(builder: (context, provider, _) {
        return Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: key,
              child: ListView(
                children: [
                  Image.asset(
                    "assets/icon_image.png",
                    height: 150,
                  ),
                  if (!provider.isLogin)
                    CustomTextField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter a username";
                        } else {
                          return null;
                        }
                      },
                      controller: usernameController,
                      hintText: 'Enter username',
                      labelText: 'Username',
                      prefixIconData: Icons.person,
                    ),
                  CustomTextField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    hintText: 'Enter your email',
                    labelText: 'Email',
                    prefixIconData: Icons.email,
                  ),
                  CustomTextField(
                    obscureText: provider.obscureText,
                    validator: (String? value) {
                      if (value!.isEmpty || value.length < 8) {
                        return "Please enter a password";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                    hintText: 'Enter password',
                    labelText: 'Password',
                    prefixIconData: Icons.key,
                    suffixIcon: IconButton(
                      onPressed: () {
                        provider.setObscureText();
                      },
                      icon: Icon(provider.obscureText
                          ? Icons.remove_red_eye
                          : Icons.visibility_off),
                    ),
                  ),
                  if (!provider.isLogin)
                    CustomTextField(
                      obscureText: provider.obscureText,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter a password";
                        } else if (value != passwordController.text) {
                          return "Password does not match";
                        } else {
                          return null;
                        }
                      },
                      controller: confirmPasswordController,
                      hintText: 'Re-enter password',
                      labelText: 'Confirm Password',
                      prefixIconData: Icons.lock,
                      suffixIcon: IconButton(
                        onPressed: () {
                          provider.setObscureText();
                        },
                        icon: Icon(provider.obscureText
                            ? Icons.remove_red_eye
                            : Icons.visibility_off),
                      ),
                    ),
                  CustomButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        if (provider.isLogin) {
                          provider.signIn(
                              email: emailController.text,
                              password: passwordController.text);
                        } else {
                          provider.signUp(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      }
                    },
                    title: provider.isLogin ? "Login" : "Register",
                  ),
                  TextButton(
                    onPressed: () {
                      provider.setIsLogin();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                      child: Text(
                        provider.isLogin
                            ? "Don't have an account? Register"
                            : "Already have an account? Login",
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ForgotPasswordScreen.routeName);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 120.0, right: 120.0),
                      child: Text(
                        "Forgot password",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
