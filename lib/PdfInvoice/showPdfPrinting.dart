import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

class ViewPrintPdfScreen extends StatelessWidget {
  final pw.Document doc;

  const ViewPrintPdfScreen(this.doc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Prview PDF'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_outlined)),
        ),
        body: PdfPreview(
          build: (format) => doc.save(),
          allowPrinting: true,
          canChangeOrientation: true,
          canChangePageFormat: true,
          // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.print))],
          allowSharing: true,
          initialPageFormat: PdfPageFormat.standard,
          pdfFileName: 'Builty_No.pdf',
        ));
  }
}
