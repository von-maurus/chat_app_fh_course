import 'package:flutter/material.dart';

class CustomElevatedBtn extends StatelessWidget {
  const CustomElevatedBtn({
    super.key,
    required this.text,
    this.height = 55,
    this.backgroundColor = Colors.blue,
    required this.onPressed,
    this.disable = false,
  });

  final double height;
  final String text;
  final Color backgroundColor;
  final Function()? onPressed;
  final bool disable;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(2),
        shape: const WidgetStatePropertyAll(StadiumBorder()),
        backgroundColor: WidgetStatePropertyAll(disable ? Colors.grey[400] : backgroundColor),
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Center(
          child: Text(text, style: TextStyle(color: disable ? Colors.black : Colors.white)),
        ),
      ),
    );
  }
}
