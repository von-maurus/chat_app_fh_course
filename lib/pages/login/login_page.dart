import 'package:flutter/material.dart';
import 'package:chat_app/pages/login/labels_widget.dart';
import 'package:chat_app/pages/login/login_form_widget.dart';
import 'package:chat_app/pages/login/logo_widget.dart';
import 'package:chat_app/pages/login/tac_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoWidget(title: 'Messegner'),
                LoginFormWidget(),
                LabelsWidget(),
                TermsAndConditions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
