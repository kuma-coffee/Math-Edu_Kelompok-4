import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:maths_edu/main/dashboard/listViewDownload.dart';
import 'package:path/path.dart';

class displayListViewDownload extends StatelessWidget {
  final FirebaseFile file;
  const displayListViewDownload({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
      ),
      body: PDFView(
        filePath: file.url,
      ),
    );
  }
}
