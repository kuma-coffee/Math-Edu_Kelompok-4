import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/dashboard.dart';
import 'package:maths_edu/screens/chat/chat_page.dart';
import 'package:maths_edu/screens/wrapper.dart';
import 'package:maths_edu/services/auth.dart';
import 'package:maths_edu/services/utils.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: ((context) => GoogleSignInProvider()),
      child: MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'ZenMaruGothic'),
        home: Dashboard(),
      ),
    );
  }
}
