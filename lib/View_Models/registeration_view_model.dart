// import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_ngcs/Screens/login_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../Data_Models/registeration_model.dart';

class RegisterationScreeenViewModel extends ChangeNotifier {
  late AlertDialog alert;
  File? fileName;
  var firebaseImageUrl;
  late final tempImage;
  bool loader = false;
  final user = FirebaseDatabase.instance.ref('Users');
  List<RegisterationModel> registerationDataList = [];
  late String downloadUrl;
  // bool showdialouge = false;
  final databaseReference = FirebaseDatabase.instance.reference();

  final firestorRef = FirebaseFirestore.instance.collection('Users');

  TextEditingController taxNumberController = TextEditingController();
  TextEditingController comNameController = TextEditingController();
  TextEditingController ceoNameController = TextEditingController();
  TextEditingController comNumberController = TextEditingController();
  TextEditingController comManagerNameController = TextEditingController();
  TextEditingController managerNumberController = TextEditingController();
  TextEditingController comAddressController = TextEditingController();
  TextEditingController otherAddressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var credential;
  late final currentUser;

  initialize(BuildContext context) {
    currentUser = FirebaseAuth.instance.currentUser;
  }

  showLoaderDialog(BuildContext context) {
    alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return loader == false ? alert : null as AlertDialog;
      },
    );
  }

  Future<void> signUpUserAndSaveRealtimeData(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      loader = true;
      try {
        credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        )
            .then((value) {
          update();
          print('then methode');
          final userId = FirebaseAuth.instance.currentUser!.uid;
          uploadImageToFirebase(context, tempImage, userId);
          addRealtimeData(userId);
          update();
          loader = false;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MyLoginScreen(
                      email: emailController.text.trim(),
                      password: passwordController.text)),
              (route) => false);
        });
      } on FirebaseAuthException catch (e) {
        loader = false;
        print('some error');
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
    } else {
      loader = false;
      update();
    }
    // }
  }

  addRealtimeData(String path) {
    Map<String, dynamic> userData = {
      "Tax Number": taxNumberController.text,
      "Photo Url": 'Photo: $firebaseImageUrl',
      "Company Name": comNameController.text,
      "Company Number": comNumberController.text,
      "CEO Name": ceoNameController.text,
      "Company Manager Name": comManagerNameController.text,
      "Manager Number": managerNumberController.text,
      "Company Address": comAddressController.text,
      "Other Branch": otherAddressController.text,
      "Email": emailController.text.trim(),
      "Password": passwordController.text,
    };
    databaseReference.child("Users").child(path).set(userData);
    print('Realtime Data added');
    firestorRef.doc(currentUser.ui).set(userData);
    print('FireStore Data Added');
    update();
  }

  pickImg(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      tempImage = File(photo.path);
      update();
      fileName = tempImage;
      print('Image url is: $tempImage');
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future uploadImageToFirebase(
      BuildContext context, File url, String userId) async {
    print('in upload methode');
    File file = url;
    String fileName = DateTime.now().microsecond.toString();
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('Images/$userId/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(file);
    var taskSnapshot = (await uploadTask.snapshotEvents.listen((event) {
      if (kDebugMode) {
        print('Uploading Task ${event.bytesTransferred / event.totalBytes}');
      }
    }));

    taskSnapshot.onDone(() {
      firebaseImageUrl = firebaseStorageRef.getDownloadURL();
    });

    print('Download URL: $firebaseImageUrl');
    print(firebaseImageUrl);
  }

  update() {
    notifyListeners();
  }
}
