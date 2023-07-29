import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_ngcs/Screens/Dashboard_Screen.dart';
import 'package:new_ngcs/View_Models/dashboard_view_model.dart';
import 'package:new_ngcs/View_Models/registeration_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  // RegisterationScreeenViewModel registerationScreeenViewModel =
  //     RegisterationScreeenViewModel();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final credential;
  bool loader = false;

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    // print(emailController.text);
    // print(passwordController.text);
    try {
      loader = true;
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        loader = true;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MyDashboardScreen()),
          (route) => false,
        );
      });
    } on FirebaseAuthException catch (e) {
      loader = false;
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }
    update();
  }
  // FormData _user = FormData();
  //
  // FormData get user => _user;

  Dispose() {
    // emailController.dispose();
    // passwordController.dispose();
    // notifyListeners();
  }

  update() {
    notifyListeners();
  }
}
