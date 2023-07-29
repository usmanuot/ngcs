import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ShowAndPrintScrren extends StatefulWidget {
  String text;
  ShowAndPrintScrren({Key? key, required this.text}) : super(key: key);

  @override
  State<ShowAndPrintScrren> createState() => _ShowAndPrintScrrenState();
}

class _ShowAndPrintScrrenState extends State<ShowAndPrintScrren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Pdf print')),
        body: const Center(
          child: Text('This is pdf Page'),
        ));
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('assets/images/login.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Header(text: "About NGCS", level: 1),
                      pw.Image(pw.MemoryImage(byteList),
                          height: 100, width: 100, fit: pw.BoxFit.fitHeight)
                    ]),
                pw.Divider(borderStyle: pw.BorderStyle.dashed),
                pw.Paragraph(text: widget.text),
              ]);
        }));
    return pdf.save();
  }
}
