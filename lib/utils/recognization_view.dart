// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
//
// class Reg extends StatelessWidget {
//   const Reg({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Barcode Printer'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             printBarcode(context, 'Sample Barcode Data');
//           },
//           child: const Text('Print Barcode'),
//         ),
//       ),
//     );
//   }
// }
//
// void printBarcode(BuildContext context, String data) async {
//   final pdf = pw.Document();
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) => pw.Center(
//         child: pw.Text(data),
//       ),
//     ),
//   );
//
//   await Printing.layoutPdf(
//     onLayout: (PdfPageFormat format) async => pdf.save(),
//   );
// }








// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
//
// class RecognizePage extends StatefulWidget {
//   final String? path;
//   const RecognizePage({super.key, this.path});
//
//   @override
//   State<RecognizePage> createState() => _RecognizePageState();
// }
//
// class _RecognizePageState extends State<RecognizePage> {
//   bool _isBusy = false;
//   TextEditingController controller = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     if (widget.path != null) {
//       final InputImage inputImage = InputImage.fromFilePath(widget.path!);
//       processImage(inputImage);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Text Generation'),
//           centerTitle: true,
//         ),
//         body: _isBusy == true
//             ? const Center(
//           child: CircularProgressIndicator(),
//         )
//             : Container(
//           padding: const EdgeInsets.all(20),
//           child: TextFormField(
//             controller: controller,
//             maxLines: null,
//             style: const TextStyle(color: Colors.white),
//             decoration: const InputDecoration(
//               hintText: 'Current Units',
//             ),
//           ),
//         ));
//   }
//
//   void processImage(InputImage image) async{
//     final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//     setState(() {
//       _isBusy = true;
//     });
//     // print(image.filePath);
//     final RecognizedText recognizedText = await textRecognizer.processImage(image);
//     controller.text = recognizedText.text;
//
//     ///End busy state
//     setState(() {
//       _isBusy = false;
//     });
//   }
// }
