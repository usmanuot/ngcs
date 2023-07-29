import 'dart:io';

import 'package:new_ngcs/Screens/search_test.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Constants/urduwritings.dart';
import '../CustomWidgets/button.dart';
import '../CustomWidgets/list_view.dart';
import '../CustomWidgets/pic_upload_widget.dart';
import '../CustomWidgets/text_form_field.dart';
import '../PdfInvoice/mobile.dart';
import '../PdfInvoice/showPdfPrinting.dart';

class ShowPDF extends StatefulWidget {
  const ShowPDF({Key? key}) : super(key: key);

  @override
  State<ShowPDF> createState() => _ShowPDFState();
}

class _ShowPDFState extends State<ShowPDF> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Custom Widgets'),
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          // color: Colors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyWidget()));
                  },
                  child: const Text('Custom ListView')),
              SizedBox(height: 20),
              DecoratedButton(
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => MyWidget()));
                  },
                  buttonText: 'Custom Button',
                  borderColor: Colors.blue,
                  borderRadius: 8,

                  // icon: Icons.add,
                  textColor: Colors.green,
                  borderWidth: 2,
                  buttonColor: Colors.black),
              SizedBox(height: 20),
              CustomTextFormField(
                  controller: controller,
                  labelText: 'label tex',
                  hintText: 'Custom Text Field'),
              SizedBox(height: 20),
              // DecoratedListView(items: ["Usman", "Naseer", "Faizan", "Bilal"]),
              SizedBox(height: 20),
              PictureUploadWidget(),
              SizedBox(height: 20),
            ],
          ),
        ));
  }

  void _createPdf() async {
    final date = DateTime.now();
    var data = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    final ByteData bytes = await rootBundle.load('assets/phone.png');
    final Uint8List byteList =
        const AssetImage('assets/phone.png') as Uint8List;
    final font = await PdfGoogleFonts.notoNastaliqUrduRegular();
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(20),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  // pw.MemoryImage(image),
                  // pw.Image(pw.MemoryImage(byteList)),
                  pw.Header(
                      level: 1,
                      child: pw.Text("Company Name\n$companuNameUrdu",
                          style: const pw.TextStyle(
                              color: PdfColors.red, fontSize: 20))),
                  // pw.Text('This is the name of the company'),
                  pw.Text('Tax No.\n123456',
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
                      level: 3,
                      child: pw.Text(
                        'Address one',
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            decoration: pw.TextDecoration.underline,
                            fontSize: 20,
                            lineSpacing: 5,
                            fontBold: pw.Font.ttf(data)),
                      ))
                ])),
            pw.Partition(
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                  pw.Column(children: [
                    pw.SizedBox(width: 20),
                    pw.Text('CEO Name'),
                    pw.Text('Muhammad Usman'),
                    pw.Text('03411158081')
                  ]),
                  pw.Container(
                      child: pw.Text(''),
                      height: 50,
                      width: 20,
                      color: PdfColors.blue),
                  pw.Column(children: [
                    pw.Text('Manager Name'),
                    pw.Text('Hamid Ullah'),
                    pw.Text('03411158081'),
                    pw.SizedBox(width: 20)
                  ]),
                ])),
            pw.Divider(thickness: 2),
            pw.Partition(
              child: pw.Column(children: [
                pw.Text('Second Office: '),
                pw.Text('Phone Numbers: --->>>'),
              ]),
            ),
            pw.SizedBox(height: 10),
            pw.Partition(
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Date: $date'),
                    pw.Text('1001 $builtyUrdu',
                        style: pw.TextStyle(font: font)),
                  ]),
            ),
            pw.SizedBox(height: 5),
            pw.Partition(
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('$receiverUrdu Hamid Ullah'),
                    pw.Text('Muhammad Usman $senderUrdu',
                        style: pw.TextStyle(fontSize: 12, font: font)),
                  ]),
            ),
            pw.SizedBox(height: 5),
            pw.Partition(
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('$truckNoUrdu 1034'),
                    pw.Text('Muhammad Khan $driverNameUrdu'),
                  ]),
            ),
            pw.Divider(thickness: 2),
            pw.SizedBox(height: 15),
            pw.Paragraph(
                text: 'Details Of Items',
                style: const pw.TextStyle(
                    decoration: pw.TextDecoration.underline, fontSize: 20)),
            pw.Column(mainAxisSize: pw.MainAxisSize.max, children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('12', style: const pw.TextStyle(fontSize: 15)),
                    pw.Text(numberingUrdu,
                        style: pw.TextStyle(fontSize: 15, font: font)),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('12 Bags',
                        style: pw.TextStyle(fontSize: 15, font: font)),
                    pw.Text(detailsUrdu,
                        style: const pw.TextStyle(fontSize: 15))
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('12KG', style: const pw.TextStyle(fontSize: 15)),
                    pw.Text(weightUrdu,
                        style: const pw.TextStyle(fontSize: 15)),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('2400', style: const pw.TextStyle(fontSize: 15)),
                    pw.Text(totalRentUrdu,
                        style: const pw.TextStyle(fontSize: 15)),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('1200', style: const pw.TextStyle(fontSize: 15)),
                    pw.Text(advanceRentUrdu,
                        style: const pw.TextStyle(fontSize: 15)),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('1200', style: const pw.TextStyle(fontSize: 15)),
                    pw.Text(restRentUrdu,
                        style: const pw.TextStyle(fontSize: 15)),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('New', style: const pw.TextStyle(fontSize: 15)),
                    pw.Text(conditionUrdu,
                        style: const pw.TextStyle(fontSize: 15)),
                  ]),
            ])
          ]);
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}

void _displayPdf(BuildContext context) async {
  final date = DateTime.now();
  var data = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
  final font = await PdfGoogleFonts.notoNastaliqUrduRegular();
  final doc = pw.Document();
  doc.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(20),
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(children: [
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                // pw.MemoryImage(image),
                // pw.Image(pw.MemoryImage(byteList)),
                pw.Header(
                    level: 1,
                    child: pw.Text("Company Name\n$companuNameUrdu",
                        style: const pw.TextStyle(
                            color: PdfColors.red, fontSize: 20))),
                // pw.Text('This is the name of the company'),
                pw.Text('Tax No.\n123456',
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
                    level: 3,
                    child: pw.Text(
                      'Address one',
                      style: pw.TextStyle(
                          color: PdfColors.black,
                          decoration: pw.TextDecoration.underline,
                          fontSize: 20,
                          lineSpacing: 5,
                          fontBold: pw.Font.ttf(data)),
                    ))
              ])),
          pw.Partition(
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                pw.Column(children: [
                  pw.SizedBox(width: 20),
                  pw.Text('CEO Name'),
                  pw.Text('Muhammad Usman'),
                  pw.Text('03411158081')
                ]),
                pw.Container(
                    child: pw.Text(''),
                    height: 50,
                    width: 20,
                    color: PdfColors.blue),
                pw.Column(children: [
                  pw.Text('Manager Name'),
                  pw.Text('Hamid Ullah'),
                  pw.Text('03411158081'),
                  pw.SizedBox(width: 20)
                ]),
              ])),
          pw.Divider(thickness: 2),
          pw.Partition(
            child: pw.Column(children: [
              pw.Text('Second Office: '),
              pw.Text('Phone Numbers: --->>>'),
            ]),
          ),
          pw.SizedBox(height: 10),
          pw.Partition(
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Date: $date'),
                  pw.Text('1001 $builtyUrdu', style: pw.TextStyle(font: font)),
                ]),
          ),
          pw.SizedBox(height: 5),
          pw.Partition(
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('$receiverUrdu Hamid Ullah'),
                  pw.Text('Muhammad Usman $senderUrdu',
                      style: pw.TextStyle(fontSize: 12, font: font)),
                ]),
          ),
          pw.SizedBox(height: 5),
          pw.Partition(
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('$truckNoUrdu 1034'),
                  pw.Text('Muhammad Khan $driverNameUrdu'),
                ]),
          ),
          pw.Divider(thickness: 2),
          pw.SizedBox(height: 15),
          pw.Paragraph(
              text: 'Details Of Items',
              style: const pw.TextStyle(
                  decoration: pw.TextDecoration.underline, fontSize: 20)),
          pw.Column(mainAxisSize: pw.MainAxisSize.max, children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('12', style: const pw.TextStyle(fontSize: 15)),
                  pw.Text(numberingUrdu,
                      style: pw.TextStyle(fontSize: 15, font: font)),
                ]),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('12 Bags',
                      style: pw.TextStyle(fontSize: 15, font: font)),
                  pw.Text(detailsUrdu, style: const pw.TextStyle(fontSize: 15))
                ]),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('12KG', style: const pw.TextStyle(fontSize: 15)),
                  pw.Text(weightUrdu, style: const pw.TextStyle(fontSize: 15)),
                ]),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('2400', style: const pw.TextStyle(fontSize: 15)),
                  pw.Text(totalRentUrdu,
                      style: const pw.TextStyle(fontSize: 15)),
                ]),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('1200', style: const pw.TextStyle(fontSize: 15)),
                  pw.Text(advanceRentUrdu,
                      style: const pw.TextStyle(fontSize: 15)),
                ]),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('1200', style: const pw.TextStyle(fontSize: 15)),
                  pw.Text(restRentUrdu,
                      style: const pw.TextStyle(fontSize: 15)),
                ]),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('New', style: const pw.TextStyle(fontSize: 15)),
                  pw.Text(conditionUrdu,
                      style: const pw.TextStyle(fontSize: 15)),
                ]),
          ])
        ]);
      },
    ),
  );

  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ViewPrintPdfScreen(doc)));
}
