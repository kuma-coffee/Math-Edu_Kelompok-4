// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:maths_edu/main/dashboard/listViewDownload.dart';

// class displayListViewDownload extends StatelessWidget {
//   final FirebaseFile file;

//   const displayListViewDownload({
//     Key? key,
//     required this.file,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isImage = ['.jpeg', '.jpg', '.png'].any(file.name.contains);

//     return Scaffold(
//         appBar: AppBar(
//           title: Text(file.name),
//           centerTitle: true,
//           actions: [
//             IconButton(
//               icon: Icon(Icons.file_download),
//               onPressed: () async {
//                 await FirebaseApi.downloadFile(file.ref);

//                 final snackBar = SnackBar(
//                   content: Text('Downloaded ${file.name}'),
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
//               },
//             ),
//             const SizedBox(width: 12),
//           ],
//         ),
//         body: PDFView(
//           filePath: file.url,
//         ));
//   }
// }
