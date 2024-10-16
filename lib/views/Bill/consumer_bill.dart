import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:sea/components/details_section.dart';
import 'package:sea/components/generate_pdf.dart';
import 'package:sea/components/invoice.dart';
import 'package:sea/constants/custom_appbar.dart';
import 'package:sea/constants/custom_button.dart';
import 'package:sea/utils/screen_size.dart';
import 'package:sea/views/login/login_provider.dart';

import '../../utils/constant.dart';

class ConsumerBill extends StatefulWidget {
  final Invoice invoice;
  final PageController pageController;

  const ConsumerBill(this.invoice, {super.key, required this.pageController});

  @override
  State<ConsumerBill> createState() => _ConsumerBillState();
}

class _ConsumerBillState extends State<ConsumerBill> {

  void _previousPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.pageController.page != null) {
        widget.pageController.animateToPage(
          widget.pageController.page!.toInt() - 1,
          duration: const Duration(milliseconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }



  Widget content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    widget.invoice.title,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                const DetailsSection(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                btnText: 'Previous',
                btnHeight: screenHeight(context) * 0.053,
                btnWidth: screenWidth(context) * 0.42,
                onPress: _previousPage,
              ),
              const SizedBox(
                width: 10,
              ),
              CustomButton(
                btnText: 'Download Bill',
                btnHeight: screenHeight(context) * 0.053,
                btnWidth: screenWidth(context) * 0.42,
                onPress: () async {
                  try {
                    final pdfBytes = await generatePdf(widget.invoice);
                    await Printing.sharePdf(
                      bytes: pdfBytes, filename: 'Bill.pdf',
                    );
                  } catch (e) {
                    debugPrint('Error generating or sharing PDF: $e');
                  }
                  QuerySnapshot existingBills = await FirebaseFirestore.instance
                      .collection('Bill_Details')
                      .where('Bill_Month', isEqualTo:DateFormat('MMMM yyyy').format(DateTime.now()))
                      .where('Current_Units', isEqualTo: TConstant.currUnits)
                      .get();
    if (existingBills.docs.isEmpty) {
      double ed = (TConstant.electricityDuty / 100) * TConstant.totalCost;
      double fc = TConstant.fcSur * TConstant.totalUnits;
      await FirebaseFirestore.instance.collection('Bill_Details').doc().set({
        'Bill_Month': DateFormat('MMMM yyyy').format(DateTime.now()),
        'Reading_Date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
        'Previous_Units': TConstant.prevUnits,
        'Current_Units': TConstant.currUnits,
        'Units_Consumed': TConstant.totalUnits.toStringAsFixed(2),
        'Units_Price': TConstant.unitsPrice.toStringAsFixed(2),
        'Total_Cost': TConstant.totalCost.toStringAsFixed(2),
        'Electricity_Duty': ed.toStringAsFixed(2),
        'TV_Fee': TConstant.tvFee,
        'GST': TConstant.gst,
        'Annual_QTR': TConstant.annualQtr,
        'FC_SUR': fc.toStringAsFixed(2),
        'Total_FPA': TConstant.totalFpa,
        'Current_Bill': TConstant.currentBill.toStringAsFixed(2),
        'user_id': FirebaseAuth.instance.currentUser!.uid,
      });
    }
    else {
      print('data already present');
    }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<LoginProvider>(context,listen: false).fetchUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'CONSUMER BILL'),
      body:
      content(context), // Show content after loading
    );
  }

  @override
  void dispose() {
    super.dispose();

  }
}
