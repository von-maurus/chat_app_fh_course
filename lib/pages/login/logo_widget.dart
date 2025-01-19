import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: Column(
          children: [
            const Image(image: AssetImage('assets/images/tag-logo.png')),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
