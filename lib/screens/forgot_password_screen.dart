import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/widgets/custom_button.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = "/forgotPasswordScreen";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Image.asset(
              "assets/icon_image.png",
              height: 300,
            ),
            const Text(
              "Enter your email to reset your password",
              style: TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            Form(
              key: _key,
              child: CustomTextField(
                controller: emailController,
                hintText: "Enter your email",
                labelText: "Email",
                prefixIconData: Icons.email_outlined,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter a valid email";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Consumer<AuthProvider>(builder: (context, provider, child) {
              return provider.isLoadingForgetPassword
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          provider.forgotPassword(
                              context, emailController.text);
                        }
                      },
                      title: "Forgot Password",
                    );
            })
          ],
        ),
      ),
    );
  }
}
