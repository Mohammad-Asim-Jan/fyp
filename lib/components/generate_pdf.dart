// components/generate_pdf.dart
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:sea/components/invoice.dart';
import 'package:sea/components/pdf_details_section.dart'; // Import the new file

Future<Uint8List> generatePdf(Invoice invoice) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Text(
                invoice.title,
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(height: 20),
            PdfDetailsSection.buildDetailsSection(invoice), // Use the new PdfDetailsSection class
            pw.SizedBox(height: 20),
            // pw.TableHelper.fromTextArray(
            //   border: pw.TableBorder.all(),
            //   headers: ['Month', 'Units', 'Bill'],
            //   data: invoice.items.map((item) {
            //     return [
            //       item.month,
            //       item.units.toString(),
            //       item.bill.toString(),
            //     ];
            //   }).toList(),
            // ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
