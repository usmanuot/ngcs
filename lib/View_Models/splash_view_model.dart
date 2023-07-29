import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../Screens/Dashboard_Screen.dart';

class SplashViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void getTimer(int duration, Future route) {
    Timer(Duration(seconds: duration), () {
      route;
    });
    notify();
  }

  notify() {
    notifyListeners();
  }

  Future<void> initialize(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return const MyDashboardScreen();
      }), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return const MyDashboardScreen();
      }), (route) => false);
    }
  }
}
