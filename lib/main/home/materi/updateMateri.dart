// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/materi/createMateri.dart';

class updateMateri extends StatelessWidget {
  updateMateri(this.babIdData, this.subBabIdData, this.materiIdData, {Key? key})
      : super(key: key) {
    _documentReferenceBab =
        FirebaseFirestore.instance.collection('bab').doc(babIdData['id']);
    _documentReferenceSubBab =
        _documentReferenceBab.collection('subBab').doc(subBabIdData['id']);
    _documentReferenceMateri =
        _documentReferenceSubBab.collection('materi').doc(materiIdData['id']);
  }
  Map babIdData;
  Map subBabIdData;
  Map materiIdData;
  late DocumentReference _documentReferenceBab;
  late DocumentReference _documentReferenceSubBab;
  late DocumentReference _documentReferenceMateri;

  String url = '';
  final textController = TextEditingController();
  late int number;

  // uploadDataToFirebase() async {
  //   //number = Random().nextInt(10);
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   File pick = File(result!.files.single.path.toString());
  //   var file = pick.readAsBytesSync();
  //   String name = DateTime.now().millisecondsSinceEpoch.toString();

  //   var pdfFile = FirebaseStorage.instance.ref().child(name).child('/.pdf');
  //   UploadTask task = pdfFile.putData(file);
  //   TaskSnapshot snapshot = await task;
  //   url = await snapshot.ref.getDownloadURL();
  //   await FirebaseFirestore.instance.collection('file').doc().set({
  //     'fileUrl': url,
  //     'name': textController.text.trim(),
  //     'timePost': FieldValue.serverTimestamp()
  //   });
  // }

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
              labelText: 'Enter Name',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              ApiServices services = ApiServices();
              services.updatePDFToFirebase(
                  _documentReferenceMateri, url, textController);
            },
            child: const Text('Select File'),
          ),
          SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => createMateri(babIdData, subBabIdData),
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