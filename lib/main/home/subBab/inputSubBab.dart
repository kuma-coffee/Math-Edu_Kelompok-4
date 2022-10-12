// ignore_for_file: prefer_const_constructors, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/subBab/createSubBab.dart';

class InputSubBab extends StatelessWidget {
  InputSubBab(this.data, {Key? key}) : super(key: key) {
    _documentReference =
        FirebaseFirestore.instance.collection('bab').doc(data['id']);
    _referenceSubBab = _documentReference.collection('subBab');
  }
  Map data;
  late DocumentReference _documentReference;
  late CollectionReference _referenceSubBab;
  String url = '';
  final textController = TextEditingController();
  late int number;

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
              services.uploadCollectionToFirebase(
                  _referenceSubBab, url, textController);
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
                  builder: (context) => createSubBab(data),
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
