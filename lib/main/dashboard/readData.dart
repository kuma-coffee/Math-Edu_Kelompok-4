// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/dashboard/listview_1.dart';

class BAB {
  String id;
  final String nama;

  BAB({
    this.id = '',
    required this.nama,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
      };
  static BAB fromJson(Map<String, dynamic> json) => BAB(
        id: json['id'],
        nama: json['nama'],
      );
}

class readBab extends StatefulWidget {
  const readBab({super.key});

  @override
  State<readBab> createState() => _readBabState();
}

Widget buildbab(BAB bab) => ListTile(
      leading: CircleAvatar(
        child: Text('1'),
      ),
      title: Text(bab.nama),
    );

Stream<List<BAB>> readBAB() =>
    FirebaseFirestore.instance.collection('bab').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => BAB.fromJson(doc.data())).toList());

class _readBabState extends State<readBab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bab'),
      ),
      body: StreamBuilder<List<BAB>>(
        stream: readBAB(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something wes wrong!');
          } else if (snapshot.hasData) {
            final bab = snapshot.data!;

            return ListView(
              children: bab.map(buildbab).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
