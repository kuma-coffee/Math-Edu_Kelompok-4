// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/materi/materi_list_page.dart';
import 'package:maths_edu/main/home/subBab/input_subBab_page.dart';
import 'package:maths_edu/main/home/subBab/update_subBab_page.dart';

class SubBabList extends StatefulWidget {
  SubBabList(this.babIdData, {Key? key}) : super(key: key) {
    _documentReferenceBab =
        FirebaseFirestore.instance.collection('bab').doc(babIdData['id']);
    _referenceSubBab = _documentReferenceBab.collection('subBab');
    _streamSubBab =
        _referenceSubBab.orderBy('timePost', descending: true).snapshots();
    _babIdData = babIdData;
  }
  Map babIdData;
  @override
  State<SubBabList> createState() => _SubBabListState();
}

// String url = '';
// final textController = TextEditingController();
// late int number;

late DocumentReference _documentReferenceBab;
late DocumentReference _documentReferenceSubBab;
late CollectionReference _referenceSubBab;
late Stream<QuerySnapshot> _streamSubBab;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SUB BAB'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => InputSubBab(_babIdData),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
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
                              builder: (context) =>
                                  createMateri(_babIdData, listItems)),
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
                                        builder: (context) => UpdateSubBab(
                                            _babIdData, listItems)),
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
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
