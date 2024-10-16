// components/pdf_details_section.dart
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sea/components/invoice.dart';
import 'package:sea/utils/constant.dart';

class PdfDetailsSection {
  static pw.Widget buildDetailsSection(Invoice invoice) {
    double ed = (TConstant.electricityDuty /100) * TConstant.totalCost;
    double fc = TConstant.fcSur * TConstant.totalUnits;
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
       // _buildDetailRow('Name:', 'Muhammad Usman'),
        // _buildDetailRow('Address:', 'District Charsadda'),
        _buildDetailRow('Bill Month:', DateFormat('MMMM yyyy').format(DateTime.now())),
        _buildDetailRow('Reading Date:', DateFormat('dd/MM/yyyy').format(DateTime.now())),
        _buildDetailRow('Previous Units:', TConstant.prevUnits),
        _buildDetailRow('Current Units:', TConstant.currUnits),
        _buildDetailRow('Units Consumed:', TConstant.totalUnits.toStringAsFixed(2)),
        _buildDetailRow('Units Price:', TConstant.unitsPrice.toStringAsFixed(2)),
        _buildDetailRow('Total Cost:', TConstant.totalCost.toStringAsFixed(2)),
       // _buildDetailRow('Electricity Duty:', TConstant.electricityDuty.toString()),
        _buildDetailRow('Electricity Duty:', ed.toStringAsFixed(2)),
        _buildDetailRow('TV Fee:', TConstant.tvFee.toString()),
        _buildDetailRow('GST:',TConstant.gst.toString()),
        _buildDetailRow('Annual Qtr:',TConstant.annualQtr.toString()),
     //   _buildDetailRow('FC-SUR:',TConstant.fcSur.toString()),
        _buildDetailRow('FC-SUR:',fc.toStringAsFixed(2)),
        _buildDetailRow('Total FPA:', TConstant.totalFpa.toString()),
        _buildDetailRow('Current Bill:', TConstant.currentBill.toStringAsFixed(2)),
      ],
    );
  }

  static pw.Widget _buildDetailRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(value, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }
}
