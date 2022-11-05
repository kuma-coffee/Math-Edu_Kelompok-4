// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class View extends StatelessWidget {
  PdfViewerController _pdfViewerController = PdfViewerController();
  final url;
  final name;
  View({super.key, this.url, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name.toString()),
        ),
        body: SfPdfViewer.network(
          url,
          controller: _pdfViewerController,
        ));
  }
}
