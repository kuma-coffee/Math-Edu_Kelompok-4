// ignore_for_file: prefer_const_constructors, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/subBab/createSubBab.dart';

class updateSubBab extends StatelessWidget {
  updateSubBab(this.babIdData, this.subBabIdData, {Key? key})
      : super(key: key) {
    _documentReferenceBab =
        FirebaseFirestore.instance.collection('bab').doc(babIdData['id']);
    _documentReferenceSubBab =
        _documentReferenceBab.collection('subBab').doc(subBabIdData['id']);
  }
  Map babIdData;
  Map subBabIdData;
  late DocumentReference _documentReferenceBab;
  late DocumentReference _documentReferenceSubBab;
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
              services.updateCollectionToFirebase(
                  _documentReferenceSubBab, url, textController);
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
                  builder: (context) => createSubBab(babIdData),
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
