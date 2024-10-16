import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sea/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/login/login_provider.dart';

class DetailsSection extends StatefulWidget {
  const DetailsSection({super.key});

  @override
  State<DetailsSection> createState() => _DetailsSectionState();
}

class _DetailsSectionState extends State<DetailsSection> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<LoginProvider>(context,listen: false).fetchUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
print(TConstant.electricityDuty);

    //TConstant.currentBill = TConstant.totalCost + TConstant.electricityDuty + TConstant.tvFee + TConstant.gst + TConstant.annualQtr + TConstant.fcSur + TConstant.totalFpa;
double ed = (TConstant.electricityDuty /100) * TConstant.totalCost;
double fc = TConstant.fcSur * TConstant.totalUnits;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Name:', loginProvider.name),
        // _buildDetailRow('Address:', 'District Charsadda'),
        _buildDetailRow('Bill Month:', DateFormat('MMMM yyyy').format(DateTime.now())),
        _buildDetailRow('Reading Date:', DateFormat('dd/MM/yyyy').format(DateTime.now())),
        _buildDetailRow('Previous Units:', TConstant.prevUnits),
        _buildDetailRow('Current Units:', TConstant.currUnits),
        _buildDetailRow('Units Consumed:', TConstant.totalUnits.toStringAsFixed(2)),
        _buildDetailRow('Units Price:', TConstant.unitsPrice.toStringAsFixed(2)),
        _buildDetailRow('Total Cost:', TConstant.totalCost.toStringAsFixed(2)),
  //      _buildDetailRow('Electricity Duty:', TConstant.electricityDuty),
        _buildDetailRow('Electricity Duty:', ed.toStringAsFixed(2)),
        _buildDetailRow('TV Fee:', TConstant.tvFee),
        _buildDetailRow('GST:',TConstant.gst),
        _buildDetailRow('Annual Qtr:',TConstant.annualQtr),
    //    _buildDetailRow('FC-SUR:',TConstant.fcSur),
        _buildDetailRow('FC-SUR:',fc.toStringAsFixed(2)),
        _buildDetailRow('Total FPA:', TConstant.totalFpa),
        _buildDetailRow('Current Bill:', TConstant.currentBill.toStringAsFixed(2)),
      ],
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    String formattedValue = value is DateTime
        ? DateFormat('yyyy-MM-dd').format(value)
        : value.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(formattedValue, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
