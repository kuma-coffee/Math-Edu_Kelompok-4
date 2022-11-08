// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/materi/input_materi_page.dart';
import 'package:maths_edu/main/home/materi/update_materi_page.dart';
import 'package:maths_edu/main/home/materi/viewPDF.dart';
import 'package:maths_edu/main/home/subBab/subBab_list_page.dart';
import 'package:maths_edu/services/auth.dart';

class MateriList extends StatefulWidget {
  MateriList(this.adminUID, this.kelasId, this.babIdData, this.subBabIdData,
      {Key? key})
      : super(key: key) {
    _adminUID = adminUID;
    _kelasId = kelasId;
    _babIdData = babIdData;
    _subBabIdData = subBabIdData;
    _documentReferenceBab =
        FirebaseFirestore.instance.collection(kelasId).doc(babIdData['id']);
    _documentReferenceSubBab =
        _documentReferenceBab.collection('subBab').doc(subBabIdData['id']);
    _referenceMateri = _documentReferenceSubBab.collection('materi');
    _streamMateri =
        _referenceMateri.orderBy('timePost', descending: false).snapshots();
  }

  List adminUID;
  String kelasId;
  Map babIdData;
  Map subBabIdData;
  @override
  State<MateriList> createState() => _MateriListState();
}

late List _adminUID;
late String _kelasId;
late Map _babIdData;
late Map _subBabIdData;
late DocumentReference _documentReferenceBab;
late DocumentReference _documentReferenceSubBab;
late DocumentReference _documentReferenceMateri;
late CollectionReference _referenceMateri;
late Stream<QuerySnapshot> _streamMateri;

class _MateriListState extends State<MateriList> {
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
                  return SubBabList(_adminUID, _kelasId, _babIdData);
                },
              ),
            );
          },
        ),
        title: Text('MATERI'),
        actions: _adminUID.contains('${user?.uid}')
            ? [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => InputMateri(
                            _adminUID, _kelasId, _babIdData, _subBabIdData),
                      ),
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ]
            : null,
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ListTile(
                          leading: SizedBox(
                            width: 0,
                          ),
                          title: Align(
                            alignment: Alignment(-1.5, 0),
                            child: Text(
                              x['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 20,
                              ),
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
                                                builder: (context) =>
                                                    UpdateMateri(
                                                        _adminUID,
                                                        _kelasId,
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
                                          ApiServices services = ApiServices();
                                          services.deletePDFToFirebase(
                                              _documentReferenceMateri);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : null,
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
