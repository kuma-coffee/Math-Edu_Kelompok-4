// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/materi/materi_list_page.dart';

final textController = TextEditingController();

class UpdateMateri extends StatelessWidget {
  UpdateMateri(this.adminUID, this.kelasId, this.babIdData, this.subBabIdData,
      this.materiIdData,
      {Key? key})
      : super(key: key) {
    _documentReferenceBab =
        FirebaseFirestore.instance.collection(kelasId).doc(babIdData['id']);
    _documentReferenceSubBab =
        _documentReferenceBab.collection('subBab').doc(subBabIdData['id']);
    _documentReferenceMateri =
        _documentReferenceSubBab.collection('materi').doc(materiIdData['id']);
  }
  String adminUID;
  String kelasId;
  Map babIdData;
  Map subBabIdData;
  Map materiIdData;
  late DocumentReference _documentReferenceBab;
  late DocumentReference _documentReferenceSubBab;
  late DocumentReference _documentReferenceMateri;

  String url = '';
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Materi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              decoration: BoxDecoration(
                //color: Color.fromARGB(255, 240, 239, 239),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kPrimaryColor, width: 1.0),
              ),
              child: Column(
                children: [
                  //Bab Name textfield
                  TextFormField(
                    controller: textController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Materi Name',
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.01,
            ),

            //Select Image Icon Password
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  ApiServices services = ApiServices();
                  services.updatePDFToFirebase(
                      _documentReferenceMateri, url, textController);
                },
                child: Text(
                  'Select File',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  backgroundColor: kPrimaryColor,
                ),
              ),
            ),

            SizedBox(
              height: size.height * 0.05,
            ),

            //Save
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MateriList(
                          adminUID, kelasId, babIdData, subBabIdData),
                    ),
                  );
                },
                child: Text(
                  'SAVE',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  backgroundColor: kPrimaryColor,
                ),
              ),
            ),

            // TextFormField(
            //   controller: textController,
            //   onChanged: (value) {},
            //   decoration: const InputDecoration(
            //     border: UnderlineInputBorder(),
            //     labelText: 'Enter Name',
            //   ),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     ApiServices services = ApiServices();
            //     services.updatePDFToFirebase(
            //         _documentReferenceMateri, url, textController);
            //   },
            //   child: const Text('Select File'),
            // ),
            // SizedBox(
            //   height: 32,
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => createMateri(babIdData, subBabIdData),
            //       ),
            //     );
            //   },
            //   child: const Text('Save'),
            // ),
          ],
        ),
      ),
    );
  }
}
