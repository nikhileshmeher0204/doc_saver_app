import 'package:doc_saver_app/widgets/custom_button.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = "/forgotPasswordScreen";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
            CustomTextField(
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
            CustomButton(onPressed: () {}, title: "Forgot Password")
          ],
        ),
      ),
    );
  }
}
