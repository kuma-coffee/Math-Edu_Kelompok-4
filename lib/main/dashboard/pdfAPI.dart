import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/dashboard/openPDF.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// class PDFApi {
//   static Future<File> loadNetwork(String url) async {
//     final respone = await http.get(url);
//     final bytes = respone.bodyBytes;

//     return _store
//   }

//   static Future<File> loadFirebase(String url) async {
//     final refPDF = FirebaseStorage.instance.ref().child(url);
//     final bytes = await refPDF.getData();

//     return _storeFile(url, bytes!);
//   }

//   static Future<File> _storeFile(String url, List<int> bytes) async {
//     final filename = basename(url);
//     final dir = await getApplicationDocumentsDirectory();

//     final file = File('${dir.path}/$filename');
//     await file.writeAsBytes(bytes, flush: true);
//     return file;
//   }

//   void openPDF(BuildContext context, File file) => Navigator.of(context)
//       .push(MaterialPageRoute(builder: (context) => PDFViewPage(file: file)));
// }

class openPDFPage extends StatefulWidget {
  const openPDFPage({super.key});

  @override
  State<openPDFPage> createState() => _openPDFPageState();
}

class _openPDFPageState extends State<openPDFPage> {
  Future<File> loadFirebase(String url) async {
    final refPDF = FirebaseStorage.instance.ref().child(url);
    final bytes = await refPDF.getData();

    return _storeFile(url, bytes!);
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PDFViewPage(file: file)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Edu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final url = 'assets/KRS.pdf';
                final file = await loadFirebase(url);

                if (file == null) return;
                openPDF(context, file);
              },
              child: const Text('Select File'),
            ),
          ],
        ),
      ),
    );
  }
}
