import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      controller: controller,
      obscureText: isObscureText,
      obscuringCharacter: '*',
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Please enter a valid value";
        } else {
          return null;
        }
      },
    );
  }
}
