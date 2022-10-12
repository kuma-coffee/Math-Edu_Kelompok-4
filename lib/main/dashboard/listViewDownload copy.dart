import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:maths_edu/main/dashboard/displayListViewDownload.dart';
import 'package:maths_edu/main/dashboard/listViewDownload.dart';
import 'package:path_provider/path_provider.dart';

class listViewDownloadWrapper extends StatefulWidget {
  const listViewDownloadWrapper({super.key});

  @override
  State<listViewDownloadWrapper> createState() =>
      _listViewDownloadWrapperState();
}

class _listViewDownloadWrapperState extends State<listViewDownloadWrapper> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseAPI.listAll('assets/');
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        leading: ClipOval(
          child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          file.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        // onTap: (() => Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => displayListViewDownload(file: file)))),
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List View Download'),
      ),
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Some error occured!'),
                );
              } else {
                final files = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(files.length),
                    Expanded(
                      child: ListView.builder(
                        itemCount: files.length,
                        itemBuilder: ((context, index) {
                          final file = files[index];
                          return buildFile(context, file);
                        }),
                      ),
                    ),
                  ],
                );
              }
          }
        },
      ),
    );
  }
}
