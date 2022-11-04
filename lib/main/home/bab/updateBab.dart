// ignore_for_file: prefer_const_constructors, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/bab/createBab.dart';

class updateBab extends StatelessWidget {
  updateBab(this.data, {Key? key}) : super(key: key) {
    _documentReference =
        FirebaseFirestore.instance.collection('bab').doc(data['id']);
  }
  Map data;
  late DocumentReference _documentReference;
  String url = '';
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            controller: textController,
            onChanged: (value) {},
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter New Bab Name',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              ApiServices services = ApiServices();
              services.updateDataToFirebase(
                  _documentReference, url, textController);
            },
            child: const Text('Select New Image Icon'),
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
