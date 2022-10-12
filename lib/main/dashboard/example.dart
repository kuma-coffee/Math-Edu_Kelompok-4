// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// class DonwloadAndOPen extends StatefulWidget {
//   const DonwloadAndOPen({super.key});

//   @override
//   State<DonwloadAndOPen> createState() => _DonwloadAndOPenState();
// }

// class _DonwloadAndOPenState extends State<DonwloadAndOPen> {
//   Future openFile({required String url, String? fileName}) async {
//     final name = fileName ?? url.split('/').last;
//     final file = await downloadFile(url, name);
//     if (file == null) return;
//     print('Path: ${file.path}');
//     openFile(url: file.path);
//   }

//   Future<File?> downloadFile(String url, String name) async {
//     final appStorage = await getApplicationSupportDirectory();
//     final file = File('${appStorage.path}/${name}');

//     try {
//       final response = Dio().get(
//         url,
//         options: Options(
//           responseType: ResponseType.bytes,
//           followRedirects: false,
//           receiveTimeout: 0,
//         ),
//       );
//       final raf = file.openSync(mode: FileMode.write);
//       raf.writeFromSync(response.data);
//       await raf.close();
//       return file;
//     } catch (e) {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 32),
//             ElevatedButton(
//                 onPressed: () => openFile(
//                       url:
//                           'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
//                     ),
//                 child: Text('Download & Open'))
//           ],
//         ),
//       ),
//     );
//   }
// }
