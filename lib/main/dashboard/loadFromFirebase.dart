// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// class PDFApi{
//   static Future<File> loadNetwork(String url) async{
//     final respone = await http.get(url);
//     final bytes = respone.bodyBytes;

//     return _storeFile(url, bytes);

//   }

//   static Future<File>(String url, List<int> bytes){
//     final filename = basename(url);
//     final dir = await getApplicationDocumentsDirectory();
    
//     final file = File('${dir.path}/$filename');
//     await file.writeAsBytes(bytes, flush: true);
//     return file;
//   }
// }

// class loadFile extends StatefulWidget {
//   const loadFile({super.key});

//   @override
//   State<loadFile> createState() => _loadFileState();
// }

// class _loadFileState extends State<loadFile> {
//   static Future<File> loadFirebase(String url) async {
//     try {
//       final refPDF = FirebaseStorage.instance.ref().child(url);
//       final bytes = await refPDF.getData();

//       return _storeFile(url, bytes);
//     } catch (e) {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Math Edu'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 final url = 'sample.pdf';
//                 final file = await PDFApi.loadFirebase(url);

//                 if (file == null) return;
//                 openPDF(context, file);
//               },
//               child: const Text('Select File'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
