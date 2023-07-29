import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ngcs/View_Models/login_screen_view_model.dart';

class RoundedTextField extends StatelessWidget {
  bool? obscure;
  bool showIcon = true;

  LoginViewModel loginViewModel = LoginViewModel();

  late final Icon? leading, trailing;
  late final String? hintText;
  late String? onempty;
  double? verticalPading, horizontalPadding;
  TextInputType? textInputType;
  TextEditingController? controller;

  RoundedTextField(
      {super.key,
      this.hintText,
      this.leading,
      this.textInputType,
      this.onempty,
      this.controller,
      this.obscure,
      this.trailing,
      this.verticalPading,
      this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    // late String suffexError;
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: textInputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return onempty;
        } else {
          return null;
        }
      },
      cursorColor: Colors.red,
      obscureText: obscure ?? false,
      onChanged: (value) {
        // print(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: verticalPading ?? 0, horizontal: horizontalPadding ?? 0),
        enabledBorder: const OutlineInputBorder(),
        hintText: hintText,
        // suffixIcon: _showSuffixIcon
        //     ?
        suffixIcon: trailing,
        // IconButton(
        //   icon: const Icon(Icons.clear),
        //   onPressed: () {
        //     controller!.clear();
        //   },
        // ),
        labelText: hintText,
        hintStyle: GoogleFonts.poppins(),
        hoverColor: Colors.red,
        prefixIcon: leading,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
