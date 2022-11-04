// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/materi/InputMateri.dart';
import 'package:maths_edu/main/home/materi/updateMateri.dart';
import 'package:maths_edu/main/home/viewPDF.dart';

class createMateri extends StatefulWidget {
  createMateri(this.babIdData, this.subBabIdData, {Key? key})
      : super(key: key) {
    _babIdData = babIdData;
    _subBabIdData = subBabIdData;
    _documentReferenceBab =
        FirebaseFirestore.instance.collection('bab').doc(babIdData['id']);
    _documentReferenceSubBab =
        _documentReferenceBab.collection('subBab').doc(subBabIdData['id']);
    _referenceMateri = _documentReferenceSubBab.collection('materi');
    _streamMateri =
        _referenceMateri.orderBy('timePost', descending: true).snapshots();
  }

  Map babIdData;
  Map subBabIdData;
  @override
  State<createMateri> createState() => _createMateriState();
}

late Map _babIdData;
late Map _subBabIdData;
late DocumentReference _documentReferenceBab;
late DocumentReference _documentReferenceSubBab;
late DocumentReference _documentReferenceMateri;
late CollectionReference _referenceMateri;
late Stream<QuerySnapshot> _streamMateri;

class _createMateriState extends State<createMateri> {
  // String url = '';
  // late int number;

  // uploadDataToFirebase() async {
  //   number = Random().nextInt(10);
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
  //     'name': 'Book' + number.toString(),
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MATERI'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => InputMateri(_babIdData, _subBabIdData),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: _streamMateri,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error:${snapshot.error}'));
            }
            if (snapshot.hasData) {
              QuerySnapshot data = snapshot.data!;
              List<QueryDocumentSnapshot> documents = data.docs;
              List<Map> items = documents
                  .map((e) => {'id': e.id, 'name': e['name']})
                  .toList();
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    QueryDocumentSnapshot x = snapshot.data!.docs[i];
                    Map listItems = items[i];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => View(
                              url: x['fileUrl'],
                              name: x['name'],
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          x['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                        trailing: Wrap(
                          spacing: 12,
                          children: <Widget>[
                            Container(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.create,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => updateMateri(
                                            _babIdData,
                                            _subBabIdData,
                                            listItems)),
                                  );
                                },
                              ),
                            ),
                            Container(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                                onPressed: () async {
                                  _documentReferenceMateri =
                                      _documentReferenceSubBab
                                          .collection('materi')
                                          .doc(listItems['id']);
                                  // _documentSnapshot =
                                  //     await _documentReference.get().
                                  // var docID = _documentSnapshot.reference.id;

                                  ApiServices services = ApiServices();
                                  services.deletePDFToFirebase(
                                      _documentReferenceMateri);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: uploadDataToFirebase,
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
