import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ngcs/View_Models/login_screen_view_model.dart';

class BuiltTextField extends StatelessWidget {
  bool? obscure;
  bool showIcon = true;

  LoginViewModel loginViewModel = LoginViewModel();

  late final String? hintText1, hintText2, title1, title2;
  String onempty = 'Required';
  TextInputType? textInputType;
  TextEditingController? controller1, controller2;

  BuiltTextField({
    super.key,
    this.hintText1,
    this.hintText2,
    this.title1,
    this.title2,
    this.controller1,
    this.controller2,
  });

  @override
  Widget build(BuildContext context) {
    // late String suffexError;
    return Container(
      padding: const EdgeInsets.only(top: 3, bottom: 1),
      height: 60,
      child: Card(
        borderOnForeground: false,
        color: Colors.white,
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 5),
            Text(title1!, style: const TextStyle(fontSize: 12)),
            Expanded(
              child: SizedBox(
                height: 20,
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: textInputType,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return onempty;
                      } else {
                        return null;
                      }
                    },
                    controller: controller1,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 3),
                        hintStyle: const TextStyle(fontSize: 8),
                        hintText: hintText1)),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: SizedBox(
                height: 20,
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: textInputType,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return onempty;
                      } else {
                        return null;
                      }
                    },
                    controller: controller2,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 3),
                        hintStyle: const TextStyle(fontSize: 8),
                        hintText: hintText2)),
              ),
            ),
            Text(title2!, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 5)
          ],
        ),
      ),
    );
  }
}
