import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final double height;
  final double fontSize;
  final Widget? suffixIcon;
  final bool isPassword;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.height = 50,
    this.fontSize = 14,
    this.suffixIcon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height, 
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: fontSize, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(
            horizontal: w * 0.04,
            vertical: h * 0.018,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(w * 0.02),
          ),
          suffixIcon: suffixIcon,
          errorStyle: TextStyle(
            fontSize: w * 0.03,
            height: 0.3, 
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
