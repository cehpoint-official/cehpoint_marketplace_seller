// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Color? hintTextColor;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const ReusableTextField({
    super.key,
    this.labelText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.hintTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(color: hintTextColor),
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
    );
  }
}
