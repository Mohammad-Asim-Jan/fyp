import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sea/components/total_container.dart';
import 'package:sea/constants/app_dropdown.dart';
import 'package:sea/constants/colors.dart';
import 'package:sea/constants/custom_appbar.dart';
import 'package:sea/constants/custom_button.dart';
import 'package:sea/utils/screen_size.dart';

import '../../utils/constant.dart';

class TotalUnits extends StatefulWidget {
  final PageController pageController;

  const TotalUnits({
    super.key,
    required this.pageController,
  });

  @override
  State<TotalUnits> createState() => _TotalUnitsState();
}

class _TotalUnitsState extends State<TotalUnits> {
  bool _showCheckbox = false;
  bool _showFirstCheckbox = false;
  bool _showSecondCheckbox = false;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  String? _selectedConsumerType;


  @override
  void initState() {
    super.initState();
    _testReadValue();
  }

  Future<void> _testReadValue() async {
    try {
      DatabaseReference dbRef = FirebaseDatabase.instance.ref();

      // Fetch values from Firebase
      TConstant.unitsP1 = await _fetchDoubleValue(dbRef.child('unitsP1'));
      TConstant.unitsP2 = await _fetchDoubleValue(dbRef.child('unitsP2'));
      TConstant.unitsP3 = await _fetchDoubleValue(dbRef.child('unitsP3'));
      TConstant.unitsP4 = await _fetchDoubleValue(dbRef.child('unitsP4'));
      TConstant.unitsUp1 = await _fetchDoubleValue(dbRef.child('unitsUp1'));
      TConstant.unitsUp2 = await _fetchDoubleValue(dbRef.child('unitsUp2'));
      TConstant.unitsUp3 = await _fetchDoubleValue(dbRef.child('unitsUp3'));
      TConstant.unitsUp4 = await _fetchDoubleValue(dbRef.child('unitsUp4'));
      TConstant.unitsUp5 = await _fetchDoubleValue(dbRef.child('unitsUp5'));
      TConstant.unitsUp6 = await _fetchDoubleValue(dbRef.child('unitsUp6'));
      TConstant.unitsUp7 = await _fetchDoubleValue(dbRef.child('unitsUp7'));
      TConstant.unitsUp8 = await _fetchDoubleValue(dbRef.child('unitsUp8'));
      TConstant.electricityDuty = await _fetchDoubleValue(dbRef.child('electricityDuty'));
      TConstant.tvFee = await _fetchDoubleValue(dbRef.child('tvFee'));
      TConstant.gst = await _fetchDoubleValue(dbRef.child('gst'));
      TConstant.annualQtr = await _fetchDoubleValue(dbRef.child('annualQtr'));
      TConstant.fcSur = await _fetchDoubleValue(dbRef.child('fcSur'));
      TConstant.totalFpa = await _fetchDoubleValue(dbRef.child('totalFpa'));


    } catch (e) {
      debugPrint("Error reading values from Firebase: $e");
    }
  }

  Future<double> _fetchDoubleValue(DatabaseReference ref) async {
    try {
      DatabaseEvent event = await ref.once();
      dynamic value = event.snapshot.value;
      return _parseDouble(value);
    } catch (e) {
      debugPrint("Error fetching value: $e");
      return 0.0; // or handle error case as needed
    }
  }

  double _parseDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0; // Default value in case of unknown type
    }
  }

  void _previousPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.pageController.page != null) {
        widget.pageController.previousPage(
          duration: const Duration(milliseconds: 001),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(label: 'Cancel', textColor: Colors.red, onPressed: () {}),
      ),
    );
  }

  double _calculateTotalCost(double totalUnits) {
    if (_isChecked1) {
      if (totalUnits <= 50) {
        TConstant.unitsPrice = TConstant.unitsP1;
        return totalUnits * TConstant.unitsP1;
      } else if (totalUnits <= 100) {
        TConstant.unitsPrice = TConstant.unitsP2;
        return totalUnits * TConstant.unitsP2;
      }
    } else if (_isChecked2) {
      if (totalUnits <= 100) {
        TConstant.unitsPrice = TConstant.unitsP3;
        return totalUnits * TConstant.unitsP3;
      } else if (totalUnits <= 200) {
        TConstant.unitsPrice = TConstant.unitsP4;
        return totalUnits * TConstant.unitsP4;
      }
    } else {
      if (totalUnits <= 100) {
        TConstant.unitsPrice = TConstant.unitsUp1;
        return totalUnits * TConstant.unitsUp1;
      } else if (totalUnits <= 200) {
        TConstant.unitsPrice = TConstant.unitsUp2;
        return totalUnits * TConstant.unitsUp2;
      } else if (totalUnits <= 300) {
        TConstant.unitsPrice = TConstant.unitsUp3;
        return totalUnits * TConstant.unitsUp3;
      } else if (totalUnits <= 400) {
        TConstant.unitsPrice = TConstant.unitsUp4;
        return totalUnits * TConstant.unitsUp4;
      } else if (totalUnits <= 500) {
        TConstant.unitsPrice = TConstant.unitsUp5;
        return totalUnits * TConstant.unitsUp5;
      } else if (totalUnits <= 600) {
        TConstant.unitsPrice = TConstant.unitsUp6;
        return totalUnits * TConstant.unitsUp6;
      } else if (totalUnits <= 700) {
        TConstant.unitsPrice = TConstant.unitsUp7;
        return totalUnits * TConstant.unitsUp7;
      } else {
        TConstant.unitsPrice = TConstant.unitsUp8;
        return totalUnits * TConstant.unitsUp8;
      }
    }
    return 0.0; // Default case if no condition matches
  }

  void _calculateBill() {
    double totalUnits = TConstant.totalUnits;
    double totalCost = _calculateTotalCost(totalUnits);
    TConstant.totalCost = totalCost;
    double ed = (TConstant.electricityDuty / 100) * totalCost;
    double fc =  TConstant.fcSur * totalUnits;

    if (_selectedConsumerType == 'Residential') {
      TConstant.currentBill = TConstant.totalCost +
          ed +
         // TConstant.electricityDuty +
          TConstant.tvFee +
          TConstant.gst +
          TConstant.annualQtr +
          fc +
         // TConstant.fcSur +
          TConstant.totalFpa;
    } else if (_selectedConsumerType == 'Mosque') {
      TConstant.tvFee = 0;
      TConstant.currentBill = TConstant.totalCost +
          ed +
       //   TConstant.electricityDuty +
          TConstant.gst +
          TConstant.annualQtr +
          fc +
         // TConstant.fcSur +
          TConstant.totalFpa;
    }
    debugPrint('Total Cost: $totalCost');
    debugPrint('Current Bill: ${TConstant.currentBill}');
  }

  void _navigateToNextPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.pageController.page != null) {
        widget.pageController.nextPage(
          duration: const Duration(milliseconds: 1 ),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _nextPage() {
    if (_selectedConsumerType == null) {
      showSnackBar('Please Select Consumer Type');
    }
    // else if (_selectedConsumerType == 'Commercial')
    // {
    //   if (_selectedLoad == null) {
    //     showSnackBar('Please Select Load');
    //   } else if (_selectedTimeOfUse == null) {
    //     showSnackBar('Please Select Time Of Use');
    //   } else {
    //     _calculateBill();
    //     _navigateToNextPage();
    //   }
    // }
    else {
      _calculateBill();
      _navigateToNextPage();
    }
  }

  void _updateCheckboxVisibility() {
    setState(() {
      if (_selectedConsumerType == 'Residential' || _selectedConsumerType == 'Mosque') {
        if (TConstant.totalUnits <= 100) {
          _showCheckbox = true;
          _showFirstCheckbox = true;
          _showSecondCheckbox = true;
        } else if (TConstant.totalUnits <= 200) {
          _showCheckbox = true;
          _showFirstCheckbox = false;
          _showSecondCheckbox = true;
        } else {
          _showCheckbox = false;
          _showFirstCheckbox = false;
          _showSecondCheckbox = false;
        }
      } else {
        _showCheckbox = false;
        _showFirstCheckbox = false;
        _showSecondCheckbox = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TOTAL UNITS'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Previous Units',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TotalContainer(text: TConstant.prevUnits),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Units',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TotalContainer(text: TConstant.currUnits),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Units',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TotalContainer(text: TConstant.totalUnits.toStringAsFixed(2)),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Consumer Type',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppDropDown(
                      labelText: 'Select Consumer Type',
                      items: const ['Residential', 'Mosque'],
                      onChanged: (selectedItem) {
                        setState(() {
                          _selectedConsumerType = selectedItem;
                          _updateCheckboxVisibility();
                          _isChecked1 = false; // Reset checkbox states
                          _isChecked2 = false; // Reset checkbox states
                        });
                      },
                    ),
                  ],
                ),
                if (_showCheckbox) ...[
                  const SizedBox(height: 10),
                  if (_showFirstCheckbox)
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked1,
                          checkColor: Colors.white,
                          activeColor: Colours.kGreenColor,
                          side: const BorderSide(color: Colors.white, width: 1.5),
                          onChanged: (bool? value) {
                            if (TConstant.totalUnits > 100) {
                              showSnackBar('Units Is More Than 100');
                            } else {
                              setState(() {
                                _isChecked1 = value ?? false;
                                if (_isChecked1) _isChecked2 = false;
                              });
                            }
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'I am consuming 100 or less units for last 1 Year',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (_showSecondCheckbox)
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked2,
                          checkColor: Colors.white,
                          activeColor: Colours.kGreenColor,
                          side: const BorderSide(color: Colors.white, width: 1.5),
                          onChanged: (bool? value) {
                            if (TConstant.totalUnits > 200) {
                              showSnackBar('Units Is More Than 200');
                            } else {
                              setState(() {
                                _isChecked2 = value ?? false;
                                if (_isChecked2) _isChecked1 = false;
                              });
                            }
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'I am consuming 200 or less units for last 6 months',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
                // if (_selectedConsumerType == 'Commercial') ...[
                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         'Load',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 15,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       AppDropDown(
                //         labelText: 'Select Load',
                //         items: const ['Up to 5 Kw', 'Above 5 Kw'],
                //         onChanged: (selectedItem) {
                //           setState(() {
                //             _selectedLoad = selectedItem;
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         'Time Of Use',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 15,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       AppDropDown(
                //         labelText: 'Select Time Of Use',
                //         items: const ['Peak', 'Off-Peak'],
                //         onChanged: (selectedItem) {
                //           setState(() {
                //             _selectedTimeOfUse = selectedItem;
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                // ],
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      btnText: 'Previous',
                      btnHeight: screenHeight(context) * 0.053,
                      btnWidth: screenWidth(context) * 0.42,
                      onPress: _previousPage,
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      btnText: 'Generate Bill',
                      btnHeight: screenHeight(context) * 0.053,
                      btnWidth: screenWidth(context) * 0.42,
                      onPress: _nextPage,
                      // Disable button if conditions are not met
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
