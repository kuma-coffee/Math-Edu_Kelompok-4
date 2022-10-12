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

class openPDFPageCopy extends StatefulWidget {
  const openPDFPageCopy({super.key});

  @override
  State<openPDFPageCopy> createState() => _openPDFPageCopyState();
}

class _openPDFPageCopyState extends State<openPDFPageCopy> {
  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseStorage.instance.ref('/assets').listAll();
  }

  Future<File> loadFirebase(Reference ref) async {
    final refPDF = FirebaseStorage.instance.ref();
    final bytes = await refPDF.getData();

    return _storeFile(ref, bytes!);
  }

  Future<File> _storeFile(Reference ref, List<int> bytes) async {
    final filename = basename(ref.toString());
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
        title: const Text('All PDF'),
      ),
      body: FutureBuilder<ListResult>(
        future: futureFiles,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];

                  return ListTile(
                    title: Text(file.name),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.open_in_full,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        //final url = 'assets/KRS.pdf';
                        final url = await loadFirebase(file);

                        openPDF(context, url);
                      },
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error occured'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
