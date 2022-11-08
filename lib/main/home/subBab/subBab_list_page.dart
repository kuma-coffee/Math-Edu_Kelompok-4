// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/dashboard.dart';
import 'package:maths_edu/main/home/materi/materi_list_page.dart';
import 'package:maths_edu/main/home/subBab/input_subBab_page.dart';
import 'package:maths_edu/main/home/subBab/update_subBab_page.dart';
import 'package:maths_edu/main/home/subBab/update_test_page.dart';
import 'package:maths_edu/main/home/test/test_list_page.dart';
import 'package:maths_edu/services/auth.dart';

class SubBabList extends StatefulWidget {
  SubBabList(this.adminUID, this.kelasId, this.babIdData, {Key? key})
      : super(key: key) {
    _adminUID = adminUID;
    _kelasId = kelasId;
    _documentReferenceBab =
        FirebaseFirestore.instance.collection(kelasId).doc(babIdData['id']);
    _referenceSubBab = _documentReferenceBab.collection('subBab');
    _referenceTest = _documentReferenceBab.collection('test');
    _streamSubBab =
        _referenceSubBab.orderBy('timePost', descending: false).snapshots();
    _streamTest =
        _referenceTest.orderBy('timePost', descending: false).snapshots();

    _babIdData = babIdData;
  }
  List adminUID;
  String kelasId;
  Map babIdData;
  @override
  State<SubBabList> createState() => _SubBabListState();
}

late List _adminUID;
late String _kelasId;
late DocumentReference _documentReferenceBab;
late DocumentReference _documentReferenceSubBab;
late DocumentReference _documentReferenceTest;
late CollectionReference _referenceSubBab;
late CollectionReference _referenceTest;
late Stream<QuerySnapshot> _streamSubBab;
late Stream<QuerySnapshot> _streamTest;
late Map _babIdData;

// uploadCollectionToFirebase() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles();
//   File pick = File(result!.files.single.path.toString());
//   var file = pick.readAsBytesSync();
//   String name = DateTime.now().millisecondsSinceEpoch.toString();

//   var pdfFile =
//       FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
//   UploadTask task = pdfFile.putData(file);
//   TaskSnapshot snapshot = await task;
//   url = await snapshot.ref.getDownloadURL();

//   Map<String, dynamic> inputSubBab = ({
//     'id': _referenceSubBab.doc().id,
//     'imgUrl': url,
//     'subBabName': textController.text.trim(),
//     'timePost': FieldValue.serverTimestamp()
//   });
//   _referenceSubBab.add(inputSubBab);
//   return "Success";
// }

class _SubBabListState extends State<SubBabList> {
  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Dashboard();
                },
              ),
            );
          },
        ),
        title: Text('SUB BAB'),
        actions: _adminUID.contains('${user?.uid}')
            ? [
                IconButton(
                  onPressed: () {
                    ApiServices services = ApiServices();
                    services.inputTest(_referenceTest);
                  },
                  icon: Icon(
                    Icons.add_circle_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            InputSubBab(_adminUID, _kelasId, _babIdData),
                      ),
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ]
            : null,
      ),
      body: Column(
        children: [
          //Test List
          Visibility(
            child: Flexible(
              child: SizedBox(
                height: 60,
                child: testList(),
              ),
            ),
            visible: testList() == null ? false : true,
          ),

          //Sub Bab List
          Expanded(
            child: subBabList(),
          ),
        ],
      ),
    );
  }

  subBabList() {
    return StreamBuilder(
      stream: _streamSubBab,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error:${snapshot.error}'));
        }
        if (snapshot.hasData) {
          QuerySnapshot data = snapshot.data!;
          List<QueryDocumentSnapshot> documents = data.docs;
          List<Map> items = documents
              .map((e) => {'id': e.id, 'subBabName': e['subBabName']})
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
                          builder: (context) => MateriList(
                              _adminUID, _kelasId, _babIdData, listItems)),
                    );
                  },
                  child: ListTile(
                    leading: ClipOval(
                      child: Image.network(
                        x['imgUrl'],
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      x['subBabName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    trailing: _adminUID.contains('${user?.uid}')
                        ? Wrap(
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
                                          builder: (context) => UpdateSubBab(
                                              _adminUID,
                                              _kelasId,
                                              _babIdData,
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
                                    _documentReferenceSubBab =
                                        _documentReferenceBab
                                            .collection('subBab')
                                            .doc(listItems['id']);
                                    // _documentSnapshot =
                                    //     await _documentReference.get().
                                    // var docID = _documentSnapshot.reference.id;

                                    ApiServices services = ApiServices();
                                    services.deleteCollectionToFirebase(
                                        _documentReferenceSubBab);
                                  },
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
                );
              });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  testList() {
    return StreamBuilder(
      stream: _streamTest,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error:${snapshot.error}'));
        }
        if (snapshot.hasData) {
          QuerySnapshot data = snapshot.data!;
          List<QueryDocumentSnapshot> documents = data.docs;
          List<Map> items = documents
              .map((e) => {'id': e.id, 'testName': e['testName']})
              .toList();
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                Map listItems = items[i];
                return InkWell(
                  onTap: () {
                    DocumentReference _referenceTestID =
                        _referenceTest.doc(listItems['id']);
                    CollectionReference _referenceQuestionAnswered =
                        _referenceTestID.collection('${user?.uid}');
                    ApiServices services = ApiServices();
                    services.questionAnswered(
                      _referenceQuestionAnswered,
                      '${user?.uid}',
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TestList(
                              _adminUID, _kelasId, _babIdData, listItems)),
                    );
                  },
                  child: ListTile(
                    leading: ClipOval(
                      child: Image.network(
                        x['imgUrl'],
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      x['testName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    trailing: _adminUID.contains('${user?.uid}')
                        ? Wrap(
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
                                          builder: (context) => UpdateTest(
                                              _adminUID,
                                              _kelasId,
                                              _babIdData,
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
                                    _documentReferenceTest =
                                        _documentReferenceBab
                                            .collection('test')
                                            .doc(listItems['id']);
                                    ApiServices services = ApiServices();
                                    services.deleteCollectionTest(
                                      _documentReferenceTest,
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
                );
              });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
