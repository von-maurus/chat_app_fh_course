import 'package:flutter/material.dart';

class CustomInputWidget extends StatefulWidget {
  const CustomInputWidget({
    super.key,
    required this.prefIcon,
    required this.hintText,
    required this.inputType,
    required this.controller,
    this.isPassword = false,
  });

  final String hintText;
  final bool isPassword;
  final IconData prefIcon;
  final TextInputType inputType;
  final TextEditingController controller;

  @override
  State<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 5),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextField(
        maxLines: 1,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
        controller: widget.controller,
        autocorrect: false,
        keyboardType: widget.inputType,
        obscureText: widget.isPassword && _isObscured,
        decoration: InputDecoration(
          hintMaxLines: 1,
          hintText: widget.hintText,
          border: InputBorder.none,
          prefixIcon: Icon(widget.prefIcon),
          hintStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Colors.black.withOpacity(0.5),
          ),
          suffixIcon: Visibility(
            visible: widget.isPassword,
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
              icon: Icon(
                _isObscured ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
