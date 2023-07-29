import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_ngcs/Data_Models/show_data_model.dart';
import 'package:new_ngcs/Screens/Dashboard_Screen.dart';
import 'package:new_ngcs/Screens/login_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../Constants/urduwritings.dart';
import '../PdfInvoice/showPdfPrinting.dart';
import '../Screens/Add_Builty_Screen.dart';

class ShowBuiltyViewModel extends ChangeNotifier {
  String? ceoName,
      comName,
      comNumber,
      managerName,
      comAddress,
      mangerNumber,
      otherbranch,
      managerNumber,
      logoUrl,
      taxNo,
      email;
  bool checkName = false;
  bool clicked = false;
  bool containData = false;
  late final currentUser;
  final formKey = GlobalKey<FormState>();
  int counter = 0;
  int today = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  late String currentDate;
  final dueDate = DateTime.now().add(Duration(days: 7));

  List<ShowDataModel> dataList = [];
  List<ShowDataModel> filteredData = [];

  late pw.Document pdfDocument;
  var data;
  late final ByteData bytes;
  late final Uint8List byteList;
  late final font, arabic, urdu;

  initialize(BuildContext context) async {
    currentDate = '$today/$month/$year';

    currentUser = FirebaseAuth.instance.currentUser!.uid;
    // final data = await FirebaseDatabase.instance.ref('Users');

    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$currentUser').get();
    if (snapshot.exists) {
      // print('Snapshot ${snapshot.value}');
      Map<dynamic, dynamic>? data = snapshot.value as Map?;
      List<dynamic> dataList = [];
      if (data != null) {
        data.forEach((key, value) async {
          // print('Values $value');
          dataList.add(value);
          taxNo = await data['Tax Number'];
          ceoName = await data['CEO Name'];
          comName = await data['Company Name'];
          managerName = await data['Company Manager Name'];
          comNumber = await data['Company Number'];
          managerNumber = await data['Manager Number'];
          otherbranch = await data['Other Branch'];
          comAddress = await data['Company Address'];
          logoUrl = await data['Photo Url'];
          email = await data['Email'];
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

    if (currentUser == null && currentUser.isEmpty) {
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
        checkName = false;
        // print('i m here');
        // print('R ' + subCollectionSnapshot.docs[0]['Receiver']);
        // print('S ' + subCollectionDocuments[0]['Receiver']);
        for (int i = 0; i < subCollectionDocuments.length; i++) {
          dataList.add(ShowDataModel(
            receiver: subCollectionDocuments[i]['Receiver'],
            sender: subCollectionDocuments[i]['Sender'],
            fromCity: subCollectionDocuments[i]['fromCity'],
            toCity: subCollectionDocuments[i]['toCity'],
            driverName: subCollectionDocuments[i]['driverName'],
            truckNo: subCollectionDocuments[i]['truckNumber'],
            date: subCollectionDocuments[i]['date'],
            builtyNo: subCollectionDocuments[i]['builtyNo'],
            numbering: subCollectionDocuments[i]['Numbering'],
            details: subCollectionDocuments[i]['details'],
            weight: subCollectionDocuments[i]['weight'],
            total: subCollectionDocuments[i]['totalRent'],
            advance: subCollectionDocuments[i]['advanceRent'],
            condition: subCollectionDocuments[i]['condition'],
          ));
          update();
        }
      } else {
        // checkName = false;
        showdialouge(context);
        print('no data found');
      }
      filteredData = dataList;
      // data = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
      data = await rootBundle
          .load("assets/fonts/urdufonts/Gandhara Suls Regular.ttf");
      bytes = await rootBundle.load('assets/images/blackonwhitngcs.png');
      byteList = bytes.buffer.asUint8List();
      // font = await PdfGoogleFonts.notoKufiArabicRegular();
      // urdu = await PdfGoogleFonts.notoNastaliqUrduBold();
      // arabic = await PdfGoogleFonts.iBMPlexSansArabicBold();
    }
  }

  List<ShowDataModel> searchFilter(String value) {
    filteredData = dataList
        .where((element) =>
            element.builtyNo?.toLowerCase().contains(value.toLowerCase()) ==
            true)
        .toList();
    // filteredData = dataList
    //     .where((element) =>
    //         element.date?.toLowerCase().contains(value.toLowerCase()) == true)
    //     .toList();
    if (filteredData.isNotEmpty) {
      // containData = true;
      return filteredData;
    } else {
      // containData = false;
      return dataList;
    }
  }

  generatePdf(BuildContext context, int index) async {
    dynamic list = filteredData[index];
    String? numbering = list.numbering;
    String? weight = list.weight;
    String? advanceRent = list.advance;
    String? restRent = list.total;
    String? totalRent = list.total;
    String? condition = list.condition;
    String? mallDetails = list.details;
    String? date = list.date;
    String? fromCity = list.fromCity;
    String? toCity = list.toCity;
    String? driverName = list.driverName;
    String? truckNo = list.truckNo;
    String? builtyNo = list.builtyNo;
    String? sender = list.sender;
    String? receiver = list.receiver;

    var urduFont = pw.Font.ttf(data);
    // data = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    // final ByteData bytes = await rootBundle.load('assets/images/login.png');
    // final Uint8List byteList = bytes.buffer.asUint8List();
    // final font = await PdfGoogleFonts.notoNastaliqUrduRegular();
    pdfDocument = pw.Document();
    print('in document methode');
    pdfDocument.addPage(
      pw.Page(
        // theme: pw.ThemeData.withFont(base: urduFont),
        orientation: pw.PageOrientation.portrait,
        margin: const pw.EdgeInsets.all(20),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  // pw.MemoryImage(image),
                  // pw.Image(pw.MemoryImage(byteList)),
                  pw.Image(pw.MemoryImage(byteList),
                      fit: pw.BoxFit.fitWidth, height: 80, width: 80),
                  pw.Header(
                      level: 1,
                      child: pw.Text("$comName\n$companuNameUrdu",
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                              // fontStyle: urduFont,
                              color: PdfColors.red,
                              fontSize: 20))),
                  // pw.Text('This is the name of the company'),
                  pw.Text('Tax No.\n$taxNo',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(color: PdfColors.blue))
                ]),
            pw.SizedBox(
                height: 15,
                child: pw.Header(
                    level: 1,
                    child: pw.Text(
                      '',
                      style: const pw.TextStyle(color: PdfColors.red),
                    ))),
            pw.SizedBox(
                child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                  pw.Header(
                    level: 0,

                    text: comAddress!,
                    // title: comAddress!,
                    // textAlign: pw.TextAlign.center,
                    textStyle: pw.TextStyle(
                        color: PdfColors.black,
                        decoration: pw.TextDecoration.underline,
                        fontSize: 20,
                        lineSpacing: 5,
                        fontBold: pw.Font.ttf(data)),
                  )
                ])),
            pw.Partition(
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                  pw.Column(children: [
                    pw.SizedBox(width: 20),
                    pw.Text('CEO Name'),
                    pw.Text(ceoName!),
                    pw.Text(comNumber!)
                  ]),
                  pw.Container(
                      child: pw.Text(''),
                      height: 50,
                      width: 20,
                      color: PdfColors.blue),
                  pw.Column(children: [
                    pw.Text('Manager Name'),
                    pw.Text(managerName!),
                    pw.Text(managerNumber!),
                    pw.SizedBox(width: 20)
                  ]),
                ])),
            pw.Divider(thickness: 2),
            pw.Partition(
              child: pw.Column(children: [
                pw.Text('Second Office: $otherbranch'),
                pw.Text('Phone Numbers: --->>>'),
              ]),
            ),
            pw.SizedBox(height: 10),
            pw.Partition(
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Date: $date'),
                    pw.Text(
                      '$builtyNo :Builty No $builtyUrdu',
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(fontSize: 30),
                    ),
                  ]),
            ),
            pw.SizedBox(height: 5),
            pw.Partition(
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.RichText(
                        text: pw.TextSpan(
                            text: '$receiverUrdu ',
                            style: const pw.TextStyle(
                                color: PdfColors.red, fontFallback: []),
                            children: [
                          pw.TextSpan(
                              text: receiver!,
                              style: const pw.TextStyle(
                                  fontSize: 25, color: PdfColors.yellow))
                        ])),
                    // pw.Text('Receiver: $receiver'),
                    pw.Text(
                      '$sender :Sender',
                      // style: pw.TextStyle(fontSize: 12, font: font),
                    ),
                  ]),
            ),
            pw.SizedBox(height: 5),
            pw.Partition(
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Truck No: $truckNo'),
                    pw.Text('$driverName :Driver'),
                  ]),
            ),
            pw.Divider(thickness: 2),
            pw.SizedBox(height: 15),
            pw.Paragraph(
                text: 'Details Of Items',
                style: const pw.TextStyle(
                    decoration: pw.TextDecoration.underline, fontSize: 20)),
            pw.Column(mainAxisSize: pw.MainAxisSize.max, children: [
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(numbering!,
                          style: const pw.TextStyle(fontSize: 15)),
                      pw.Text(
                        numberingUrdu,
                        // style: pw.TextStyle(fontSize: 15, font: font),
                      ),
                    ]),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        mallDetails!,
                        // style: pw.TextStyle(fontSize: 15, font: font),
                      ),
                      pw.Text(detailsUrdu,
                          style: const pw.TextStyle(fontSize: 15))
                    ]),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('$weight KG',
                          style: const pw.TextStyle(fontSize: 15)),
                      pw.Text(weightUrdu,
                          style: const pw.TextStyle(fontSize: 15)),
                    ]),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(totalRent!,
                          style: const pw.TextStyle(fontSize: 15)),
                      pw.Text(totalRentUrdu,
                          style: const pw.TextStyle(fontSize: 15)),
                    ]),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(advanceRent!,
                          style: const pw.TextStyle(fontSize: 15)),
                      pw.Text(advanceRentUrdu,
                          style: const pw.TextStyle(fontSize: 15)),
                    ]),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(restRent!,
                          style: const pw.TextStyle(fontSize: 15)),
                      pw.Text(restRentUrdu,
                          style: const pw.TextStyle(fontSize: 15)),
                    ]),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(condition!,
                          style: const pw.TextStyle(fontSize: 15)),
                      pw.Text(
                        conditionUrdu,
                        textDirection: pw.TextDirection.rtl,
                        // style: pw.TextStyle(fontSize: 15, font: font)
                      ),
                    ]),
              ),
            ])
          ]);
        },
      ),
    );
    print('outside document');
    navigator(context);
  }

  navigator(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewPrintPdfScreen(pdfDocument)));
  }

  showdialouge(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Builty Data Found'),
          content: const Text('First add data then use this functions'),
          actions: <Widget>[
            TextButton(
              child: const Text('Add Builty'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const AddBuiltyScreen()),
                    (route) => false);
              },
            ),
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: () {
                // Perform delete operation
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyDashboardScreen()),
                    (route) => false);
              },
            ),
          ],
        );
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
