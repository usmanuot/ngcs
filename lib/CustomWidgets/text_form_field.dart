import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function(String)? validator;

  CustomTextFormField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      // validator: validator,
      decoration: InputDecoration(
        label: Text(labelText),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        // disabledBorder:
        //     OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        // labelText: labelText,
        hintText: hintText,
        border: InputBorder.none,
      ),
    );
  }
}
