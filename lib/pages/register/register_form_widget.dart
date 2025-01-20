import 'package:chat_app/common/widgets/custom_elevated_btn.dart';
import 'package:chat_app/common/widgets/custom_input_widget.dart';
import 'package:flutter/material.dart';

class RegisterFormWidget extends StatelessWidget {
  RegisterFormWidget({super.key});
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInputWidget(
            prefIcon: Icons.perm_identity_rounded,
            hintText: 'Your full name please',
            inputType: TextInputType.text,
            controller: nameCtrl,
          ),
          const SizedBox(height: 10),
          CustomInputWidget(
            prefIcon: Icons.email_outlined,
            hintText: 'Enter a valid email',
            inputType: TextInputType.emailAddress,
            controller: emailCtrl,
          ),
          const SizedBox(height: 10),
          CustomInputWidget(
            prefIcon: Icons.password_rounded,
            hintText: 'Enter a secure password',
            inputType: TextInputType.text,
            controller: passwordCtrl,
          ),
          const SizedBox(height: 20),
          CustomElevatedBtn(
            text: 'Register Now!',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
