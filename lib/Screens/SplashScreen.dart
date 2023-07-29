import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ngcs/Screens/Dashboard_Screen.dart';
import 'package:new_ngcs/Screens/pdf_Screen.dart';
import 'package:new_ngcs/View_Models/login_screen_view_model.dart';
import 'package:new_ngcs/View_Models/splash_view_model.dart';
import 'package:stacked/stacked.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyLoginScreen()));
        // print('in login screen');
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyDashboardScreen()));
        // print('in dashboard screen');
      }
    });
    super.initState();
  }

  SplashViewModel splashViewModel = SplashViewModel();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
        viewModelBuilder: () => splashViewModel,
        onViewModelReady: (model) {
          // model.initialize(context);
        },
        builder: (context, model, child) {
          return SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  body: const Center(
                    child: Text('Splash Screen'),
                  )));
        });
  }
}
