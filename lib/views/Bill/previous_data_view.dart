import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sea/constants/colors.dart';
import 'package:sea/constants/custom_appbar.dart';
import 'package:sea/components/image_cropper.dart';
import 'package:sea/components/bottom_dilogue_widget.dart';
import 'package:http/http.dart' as http;
import 'package:sea/constants/custom_button.dart';
import 'package:sea/constants/custom_textfield.dart';
import 'package:sea/constants/divider.dart';
import 'package:sea/utils/screen_size.dart';

import '../../utils/constant.dart';

class PreviousDataView extends StatefulWidget {
  final PageController pageController;
  const PreviousDataView({super.key, required this.pageController});

  @override
  State<PreviousDataView> createState() => _PreviousDataViewState();
}

class _PreviousDataViewState extends State<PreviousDataView>
    with AutomaticKeepAliveClientMixin<PreviousDataView> {
  XFile? pickedImage;
  String myText = '';
  bool scanning = false;

  final TextEditingController pResponseController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  final PageController _pageController = PageController();

  final apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent?key=AIzaSyDCv1kjUsY-A347ZjZiUh3QNJTzd6A_XH8';

  final header = {
    'Content-Type': 'application/json',
  };

  Future<XFile?> getImage(ImageSource source) async {
    XFile? result = await _imagePicker.pickImage(source: source);
    return result;
  }

  getData(image) async {
    setState(() {
      scanning = true;
      myText = '';
      pResponseController.clear();
    });

    final gemini = Gemini.instance;

    final file = File(image.path);
    gemini.textAndImage(
        text: "Following is the image of a electric meter with units written on its display. Analyze the following image and provide the units_value written on its display. Note that don't provide me any additional text just provide me units_value without adding the unit ie kwh", /// text
        images: [file.readAsBytesSync()] /// list of images
    )
        .then((value)  {
          print('xxxxxxxxxxxxxxxxxxxxxxxxxxx');
      print(value?.content?.parts?.last.text ?? '');
      myText = value?.content?.parts?.last.text ?? '';
          pResponseController.text = myText;
      setState(() {
        scanning = false;
      });
    })
        .catchError((e){
          print('eeeeeeeeeeeeeeeeeeeeeee');
    print('textAndImageInput$e' );
      setState(() {
        scanning = false;
      });
    });

    // try {
    //   List<int> imageBytes = File(image.path).readAsBytesSync();
    //   String base64File = base64.encode(imageBytes);
    //
    //   // Hard-coded prompt
    //   const promptValue =
    //       "Following is the image of a electric meter with units written on its display. Analyze the following image and provide the units_value written on its display. Note that don't provide me any additional text just provide me units_value without adding the unit ie kwh";
    //
    //   final data = {
    //     "contents": [
    //       {
    //         "parts": [
    //           {"text": promptValue},
    //           {
    //             "inlineData": {
    //               "mimeType": "image/jpeg",
    //               "data": base64File,
    //             }
    //           }
    //         ]
    //       }
    //     ],
    //   };
    //
    //   await http
    //       .post(Uri.parse(apiUrl), headers: header, body: jsonEncode(data))
    //       .then((response) {
    //     if (response.statusCode == 200) {
    //       var result = jsonDecode(response.body);
    //
    //
    //       myText = result['candidates'][0]['content']['parts'][0]['text'];
    //       print('yesnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
    //       print(myText);
    //       if (myText != ' 9999' && myText != ' 9949' && myText != ' 9947') {
    //         pResponseController.text = myText;
    //       } else {
    //         showSnackBar('Select Another Image');
    //         // responseController.text = 'Select Another Image';
    //       }
    //       // myText = result['candidates'][0]['content']['parts'][0]['text'];
    //       // responseController.text =
    //       //     myText; // Set the response text in the controller
    //       debugPrint(response.body);
    //     } else {
    //
    //       print('sssssssssssssssssssssssssssssssssss');
    //       showSnackBar('Please Enter Units Manually');
    //       // myText = 'Response status : ${response.statusCode}';
    //       // pResponseController.text =
    //       //     myText; // Set the error status in the controller
    //     }
    //   }).catchError((error) {
    //     print('yesnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
    //     print(error);
    //     debugPrint('Error occurred $error');
    //     showSnackBar('Check Your Internet Connection');
    //     // responseController.text = 'Check Your Internet Connection';
    //     // responseController.text = 'Error occurred: $error';// Set the error message in the controller
    //   });
    // } catch (e) {
    //
    //   print('sssssssssssssssssssssssssssssssssss');
    //   debugPrint('Error occurred: Try Again');
    //   showSnackBar('Error occurred: Try Again');
    //   // responseController.text =
    //   //     'Error occurred $e'; // Set the error message in the controller
    // }
    //
    // setState(() {
    //   scanning = false;
    // });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime oneMonthBefore = DateTime(now.year, now.month - 1, now.day);
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: oneMonthBefore,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
        // _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  void _validateAndNextPage() {
    if (pResponseController.text.isEmpty) {
      showSnackBar('Please Enter Previous Units');
    } else if (_dateController.text.isEmpty) {
      showSnackBar('Please Select Reading Date');
    } else if (_timeController.text.isEmpty) {
      showSnackBar('Please Select Reading Time');
    } else {
      TConstant.prevUnits = pResponseController.text;
      _nextPage();
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
            label: 'Cancel', textColor: Colors.red, onPressed: () {}),
      ),
    );
  }

  void _nextPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.pageController.page != null) {
        widget.pageController.animateToPage(
          widget.pageController.page!.toInt() + 1,
          duration: const Duration(milliseconds: 01),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // This line is required for AutomaticKeepAliveClientMixin to work
    return Scaffold(
      appBar: const CustomAppBar(title: 'PREVIOUS DATA'),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // if (pickedImage == null)
                        showImageSourceDialog(
                          context,
                          onCameraTap: () {
                            log('Camera');
                            getImage(ImageSource.camera).then((value) {
                              if (value != null) {
                                imageCropperView(value.path, context)
                                    .then((croppedFile) {
                                  if (croppedFile != null) {
                                    setState(() {
                                      pickedImage = croppedFile as XFile?;
                                    });
                                  }
                                });
                              }
                            });
                          },
                          onGalleryTap: () {
                            log('Gallery');
                            getImage(ImageSource.gallery).then((value) {
                              if (value != null) {
                                imageCropperView(value.path, context)
                                    .then((croppedFile) {
                                  if (croppedFile != null) {
                                    setState(() {
                                      pickedImage = croppedFile as XFile?;
                                    });
                                  }
                                });
                              }
                            });
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: screenHeight(context) * 0.35,
                        width: screenWidth(context) * 0.75,
                        decoration: BoxDecoration(
                          color: pickedImage != null
                              ? null
                              : Colours
                                  .kContainerColor, // Set color when _image is null
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(25),
                          image: pickedImage != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(pickedImage!.path)),
                                )
                              : null,
                        ),
                        child: pickedImage != null
                            ? Stack(
                                children: [
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          pickedImage = null;
                                          pResponseController.clear();
                                        });
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const Text(
                                'Upload Meter Picture',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomButton(
                    btnText: 'Extract Units',
                    btnHeight: screenHeight(context) * 0.053,
                    btnWidth: screenWidth(context) * 0.7,
                    onPress: pickedImage != null
                        ? () {
                            if (pickedImage != null) {
                              getData(pickedImage);
                            }
                          }
                        : () {
                            showSnackBar('Please Upload Image First');
                          },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomDivider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CustomDivider(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter Units Manually',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomTextField(
                          controller: pResponseController,
                          hintText: 'Enter Previous Units',
                          read: false,
                          onPress: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Reading Date',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CustomTextField(
                                    controller: _dateController,
                                    hintText: 'Select Reading Date',
                                    read: true,
                                    onPress: () {
                                      _selectDate(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Reading Time',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CustomTextField(
                                    controller: _timeController,
                                    hintText: 'Select Reading Time',
                                    read: true,
                                    onPress: () {
                                      _selectTime(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: CustomButton(
                                  btnText: 'Next',
                                  btnHeight: screenHeight(context) * 0.053,
                                  btnWidth: screenWidth(context) * 0.42,
                                  onPress: _validateAndNextPage),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (scanning)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: SpinKitThreeBounce(color: Colors.white, size: 20),
              ),
            ),
        ],
      ),
    );
  }
}
