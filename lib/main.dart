import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_ngcs/Screens/SplashScreen.dart';
import 'package:new_ngcs/View_Models/dashboard_view_model.dart';
import 'package:new_ngcs/View_Models/splash_view_model.dart';
import 'package:provider/provider.dart';
import '../View_Models/Add_Builty_View_Model.dart';
import 'View_Models/login_screen_view_model.dart';
import 'View_Models/show_builty_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ChangeNotifierProvider(create: (_) => SplashViewModel()),
      ChangeNotifierProvider(create: (_) => DashboardScreenViewModel()),
      ChangeNotifierProvider(create: (_) => AddBuiltyViewModel()),
      ChangeNotifierProvider(create: (_) => ShowBuiltyViewModel()),
    ],
    child: MyApp(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NGCS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
