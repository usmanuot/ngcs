import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_ngcs/Screens/login_screen.dart';

class DashboardScreenViewModel extends ChangeNotifier {
  String name = '';
  bool checkName = false;
  late AlertDialog alert;
  late final currentUser;

  initialize(BuildContext context) async {
    currentUser = FirebaseAuth.instance.currentUser!.uid;
    // final data = await FirebaseDatabase.instance.ref('Users');

    if (currentUser == null && currentUser.isEmpty) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyLoginScreen()),
          (route) => false);
    } else {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('users/$currentUser').get();
      if (snapshot.exists) {
        // print('Snapshot ${snapshot.value}');
        Map<dynamic, dynamic>? data = snapshot.value as Map?;
        List<dynamic> dataList = [];
        if (data != null) {
          data.forEach((key, value) {
            // print('Values $value');
            dataList.add(value);
            name = data['CEO Name'];
            checkName = true;
            update();
            if (kDebugMode) {
              // print('Data $name');
            }
          });
        }
        if (kDebugMode) {
          // print('Data List: $dataList');
        }
        // Here, you can do whatever you want with the dataList.
      } else {
        if (kDebugMode) {
          print('No data available.');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyLoginScreen()),
              (route) => false);
        }
      }
    }
  }

  showLoaderDialog(BuildContext context, String text) {
    alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: Column(
                children: [
                  Text(text),
                ],
              )),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'))
      ],
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  logOutUser(BuildContext context) {
    final currentUser = FirebaseAuth.instance;
    currentUser.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyLoginScreen()),
        (route) => false);
  }

  update() {
    notifyListeners();
  }
}
