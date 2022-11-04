// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/dashboard/dashboard.dart';

class setting extends StatefulWidget {
  const setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Column(children: [
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Edit Account'),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app_rounded),
          title: Text('Sign Out'),
        ),
      ]),
    );
  }
}
