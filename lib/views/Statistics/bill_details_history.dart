import 'package:flutter/material.dart';
import 'package:sea/constants/custom_appbar.dart';

class BillDetailsHistory extends StatelessWidget {
  final String date;
  final String billMonth;
   final String prevUnits;
   final String currUnits;
  final String totalUnits;
  final String unitsPrice;
  final String cost;
   final String ed;
  final double tvFee;
   final double GST;
   final double Qtr;
   final String fcSur;
  final double fpa;
  final String currBill;
  const BillDetailsHistory({
    required this.date,
    required this.billMonth,
     required this.prevUnits,
     required this.currUnits,
     required this.totalUnits,
      required this.unitsPrice,
   required this.tvFee,
     required this.currBill,
     required this.fcSur,
      required this.ed,
     required this.cost,
      required this.fpa,
     required this.GST,
    required this.Qtr,
    super.key});

  @override
  Widget build(BuildContext context) {
    var heightX  = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(title: date, ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text('Bill History', style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),),
          SizedBox(
            height: heightX * 0.03,
          ),
            _DetailRow('Bill Month:', billMonth),
            _DetailRow('Reading Date:', date),
             _DetailRow('Previous Units:', prevUnits),
            _DetailRow('Current Units:', currUnits),
             _DetailRow('Units Consumed:', totalUnits),
             _DetailRow('Units Price:', unitsPrice),
              _DetailRow('Total Cost:', cost),
             _DetailRow('Electricity Duty:', ed),
            _DetailRow('TV Fee:', tvFee),
              _DetailRow('GST:', GST),
            _DetailRow('Annual QTR:', Qtr),
             _DetailRow('FC-SUR:', fcSur),
            _DetailRow('Total FPA:', fpa),
            _DetailRow('Current Bill:', currBill),
          ],
        ),
      ),
    );
  }
  Widget _DetailRow(String label, dynamic value) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(value.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
