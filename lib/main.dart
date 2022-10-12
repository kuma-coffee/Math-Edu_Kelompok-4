import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/dashboard/babList.dart';
import 'package:maths_edu/main/home/bab/createBab.dart';
import 'package:maths_edu/main/dashboard/download.dart';
import 'package:maths_edu/main/dashboard/listViewDownload%20copy.dart';
import 'package:maths_edu/main/dashboard/listview_1.dart';
import 'package:maths_edu/main/dashboard/listview_2.dart';
import 'package:maths_edu/main/dashboard/openPDF.dart';
import 'package:maths_edu/main/dashboard/pdfAPI%20copy.dart';
import 'package:maths_edu/main/dashboard/pdfAPI.dart';
import 'package:maths_edu/main/dashboard/readData.dart';
import 'package:maths_edu/main/dashboard/upload.dart';
import 'package:maths_edu/main/dashboard/wrapper.dart';
import 'package:maths_edu/screens/wrapper.dart';
import 'package:maths_edu/services/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const createBab(),
    );
  }
}
