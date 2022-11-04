// ignore_for_file: prefer_const_constructors, file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/bab/createBab.dart';

class InputBab extends StatelessWidget {
  InputBab({super.key});
  String url = '';
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            controller: textController,
            onChanged: (value) {},
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Bab Name',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              ApiServices services = ApiServices();
              services.uploadDataToFirebase(url, textController);
            },
            child: const Text('Select Image Icon'),
          ),
          SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => createBab(),
                ),
              );
            },
            child: const Text('Save'),
          ),
        ]),
      ),
    );
  }
}
