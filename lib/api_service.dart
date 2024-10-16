// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
//
// class ApiService {
//   final String apiKey = 'AIzaSyDV7W1x82DoRwtdT-6AB_Psyeic-E6yNME';
//   final String endpoint = 'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent'; // replace with the correct endpoint
//
//   Future<Map<String, dynamic>> sendImageToGemini(File image) async {
//     final request = http.MultipartRequest('POST', Uri.parse(endpoint));
//     request.headers['Authorization'] = 'Bearer $apiKey';
//
//     request.files.add(await http.MultipartFile.fromPath('image', image.path));
//
//     request.fields['prompt'] = jsonEncode({
//       "prompt": "Following is the image of an electric meter with units written on its display. Analyze the following image and provide the units value written on its display in JSON format. Note that your response will be only in JSON format, don't provide me any additional text."
//     });
//
//     final response = await request.send();
//
//     if (response.statusCode == 200) {
//       final responseData = await response.stream.bytesToString();
//       return jsonDecode(responseData);
//     } else {
//       throw Exception('Failed to send image to Gemini API');
//
//     }
//   }
// }
