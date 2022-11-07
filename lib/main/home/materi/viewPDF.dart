// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class View extends StatelessWidget {
  PdfViewerController _pdfViewerController = PdfViewerController();
  final url;
  final name;
  View({super.key, this.url, this.name});

  int progress = 0;
  ReceivePort receivePort = ReceivePort();
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, 'Downloading');
    receivePort.listen((message) {
      print(message);
      print(progress);
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  static downloadCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName('Downloading');
    sendPort?.send(progress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name.toString()),
          actions: [
            IconButton(
              onPressed: () => downloadPDF(url, name),
              icon: Icon(Icons.download),
            ),
          ],
        ),
        body: SfPdfViewer.network(
          url,
          controller: _pdfViewerController,
        ));
  }

  void downloadPDF(String fileURL, String fileName) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final storage = await getExternalStorageDirectory();
      final id = await FlutterDownloader.enqueue(
          url: fileURL, savedDir: storage!.path, fileName: fileName);
      print(storage);
    } else {
      print('No permission');
    }
    print('Download Sucessfull');
  }
}
