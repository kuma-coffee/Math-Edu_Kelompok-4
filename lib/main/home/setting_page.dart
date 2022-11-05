// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/dashboard.dart';
import 'package:maths_edu/screens/auth/profilePage/profile_page.dart';
import 'package:maths_edu/services/auth.dart';

class settingPage extends StatefulWidget {
  const settingPage({Key? key}) : super(key: key);

  @override
  State<settingPage> createState() => _settingPageState();
}

//import sign out
Future<void> signOut() async {
  await Auth().signOut();
}

class _settingPageState extends State<settingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          },
        ),
      ),
      body: Column(children: [
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Edit Account'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => profilePage()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app_rounded),
          title: Text('Sign Out'),
          onTap: () async {
            await signOut();
          },
        ),
      ]),
    );
  }
}
