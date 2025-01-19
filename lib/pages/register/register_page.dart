import 'package:flutter/material.dart';
import 'package:chat_app/pages/login/logo_widget.dart';
import 'package:chat_app/pages/register/register_form_widget.dart';
import 'package:chat_app/pages/register/register_labels_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFF2F2F2),
        leading: IconButton(
          onPressed: () => Navigator.restorablePopAndPushNamed(context, 'login'),
          icon: const Icon(Icons.arrow_back, size: 30),
        ),
      ),
      backgroundColor: const Color(0XFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LogoWidget(title: 'Register'),
                RegisterFormWidget(),
                const RegisterLabelsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
