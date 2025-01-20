import 'package:chat_app/common/widgets/custom_elevated_btn.dart';
import 'package:chat_app/common/widgets/custom_input_widget.dart';
import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInputWidget(
            prefIcon: Icons.email_outlined,
            hintText: 'Enter a valid email',
            inputType: TextInputType.emailAddress,
            controller: emailCtrl,
          ),
          const SizedBox(height: 10),
          CustomInputWidget(
            prefIcon: Icons.password_rounded,
            hintText: 'Password',
            inputType: TextInputType.text,
            controller: passwordCtrl,
            isPassword: true,
          ),
          const SizedBox(height: 20),
          CustomElevatedBtn(
            text: 'Log in',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
