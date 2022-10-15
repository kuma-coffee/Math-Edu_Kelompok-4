import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class Download extends StatefulWidget {
  const Download({super.key});

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseStorage.instance.ref('/assets').listAll();
  }

  Future downloadFile(Reference ref) async {
    // final dir = await getApplicationDocumentsDirectory();
    // final file = File('${dir.path}/${ref.name}');

    // await ref.writeToFile(file);

    final url = await ref.getDownloadURL();
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    await Dio().download(url, path);

    if (url.contains('.jpg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    } else if (url.contains('.pdf')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloaded ${ref.name}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download'),
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
                        Icons.download,
                        color: Colors.black,
                      ),
                      onPressed: () => downloadFile(file),
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
