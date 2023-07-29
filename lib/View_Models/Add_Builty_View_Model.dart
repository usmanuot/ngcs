import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:new_ngcs/Screens/login_screen.dart';

class AddBuiltyViewModel extends ChangeNotifier {
  late final currentUser;
  final formKey = GlobalKey<FormState>();
  int counter = 0;
  String onempty = '';
  double restRent = 0;
  int today = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  int hour = DateTime.now().hour;
  int min = DateTime.now().minute;
  int sec = DateTime.now().second;

  late String currentDate, currentTime;

  final databaseReference = FirebaseDatabase.instance.ref('Builties');
  final firestorRef = FirebaseFirestore.instance.collection('Builties');

  TextEditingController receiverController = TextEditingController();
  TextEditingController senderController = TextEditingController();
  TextEditingController fromCityController = TextEditingController();
  TextEditingController toCityController = TextEditingController();
  TextEditingController driverNameController = TextEditingController();
  TextEditingController truckNumberController = TextEditingController();
  TextEditingController numberingController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController totalRentController = TextEditingController();
  TextEditingController advanceRentController = TextEditingController();
  TextEditingController restRentController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  String BuiltyNumber = '';
  Map<dynamic, dynamic>? dataList;

  String _selectedOption = 'Select';
  final List<String> _options = ['Old', 'New', 'Use'];

  String get selectedOption => _selectedOption;
  List<String> get options => _options;

  set selectedOption(String value) {
    _selectedOption = value;
    update();
  }

  // void setSelectedOption(String newValue) {
  //   _selectedOption = _options;
  //   notifyListeners();
  // }

  initialize(BuildContext context) async {
    currentDate = '$today/$month/$year ';
    currentTime = '$hour:$min:$sec';

    currentUser = FirebaseAuth.instance.currentUser!.uid;

    if (currentUser == null && currentUser.isNullOrBlank) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyLoginScreen()),
          (route) => false);
    } else {
      final CollectionReference mainCollection =
          FirebaseFirestore.instance.collection('Builties');
      final DocumentReference documentReference =
          mainCollection.doc(currentUser);
      final CollectionReference subCollectionReference =
          documentReference.collection(currentUser);
      QuerySnapshot subCollectionSnapshot = await subCollectionReference.get();
      List<DocumentSnapshot> subCollectionDocuments =
          subCollectionSnapshot.docs;
      if (subCollectionDocuments.isNotEmpty) {
        counter = subCollectionDocuments.length;
      }
      update();
    }
  }

  void getBuiltuNoData() async {}

  addRealtimeBuiltyData(BuildContext context) {
    if (formKey.currentState!.validate() && checkConditions(context) == true) {
      if (counter == 0) {
        counter = counter + 1;
        addRealtimeData(currentUser, counter.toString());
      }
      counter++;
      addRealtimeData(currentUser, counter.toString());
    }
  }

  saveAndEmpty() {
    senderController.clear();
    receiverController.clear();
    fromCityController.clear();
    toCityController.clear();
    driverNameController.clear();
    truckNumberController.clear();
    numberingController.clear();
    detailsController.clear();
    weightController.clear();
    advanceRentController.clear();
    totalRentController.clear();
    conditionController.clear();
  }

  bool checkConditions(BuildContext context) {
    if (restRentController.text.contains('')) {
      double total = double.parse(totalRentController.text);
      double advance = double.parse(advanceRentController.text);
      if (advance > total) {
        print('total must be greated then advance');
        onempty = 'Total must be greater then advance';
        showdialouge(context);
        update();
        return false;
      } else {
        restRent = total - advance;
        return true;
      }
      // int restRent = total - advance;
    }
    return true;
  }

  showdialouge(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check Total'),
          content: const Text('Total Rent Must be Greater then Advance Rent'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // generatePdf(BuildContext context) async{
  //   final pdfFile = await PdfInvoiceIpi.generate(invoice)
  // }

  addRealtimeData(String path, String counter) {
    Map<String, dynamic> userData = {
      "Sender": senderController.text,
      "Receiver": receiverController.text,
      "fromCity": fromCityController.text,
      "toCity": toCityController.text,
      "driverName": driverNameController.text,
      "truckNumber": truckNumberController.text,
      "date": currentDate.toString(),
      "builtyNo": counter.toString(),
      "Numbering": numberingController.text,
      "details": detailsController.text,
      "weight": weightController.text,
      "totalRent": totalRentController.text,
      "restRent": restRent,
      "advanceRent": advanceRentController.text,
      "condition": conditionController.text,
    };
    // databaseReference.child(path).child(counter).set(userData);

    firestorRef.doc('$currentUser').collection(currentUser).add(userData);
    // .doc('')
    // .set(userData);
    if (kDebugMode) {
      print('data added');
    }
    update();
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
