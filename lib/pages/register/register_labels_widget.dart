import 'package:flutter/material.dart';

class RegisterLabelsWidget extends StatelessWidget {
  const RegisterLabelsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '¿Ya tienes una?',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, 'login');
          },
          child: Text(
            '¡Ingresa que esperas!',
            style: TextStyle(
              color: Colors.blue.shade600,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
