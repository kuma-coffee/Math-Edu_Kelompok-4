// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/materi/input_materi_page.dart';
import 'package:maths_edu/main/home/materi/update_materi_page.dart';
import 'package:maths_edu/main/home/subBab/subBab_list_page.dart';
import 'package:maths_edu/main/home/test/input_question_page.dart';
import 'package:maths_edu/main/home/test/question_page.dart';
import 'package:maths_edu/main/home/test/score_page.dart';
import 'package:maths_edu/main/home/test/update_question_page.dart';
import 'package:maths_edu/main/home/viewPDF.dart';
import 'package:maths_edu/services/auth.dart';

class TestList extends StatefulWidget {
  TestList(this.babIdData, this.testID, {Key? key}) : super(key: key) {
    _babIdData = babIdData;
    _testID = testID;
    _documentReferenceBab =
        FirebaseFirestore.instance.collection('bab').doc(babIdData['id']);
    _documentReferenceTest =
        _documentReferenceBab.collection('test').doc(testID['id']);
    _referenceTestList = _documentReferenceTest.collection('testList');
    _questionAnsweredRef = _documentReferenceTest.collection('${user?.uid}');
    _score = _questionAnsweredRef.doc('score');
    _streamMateri =
        _referenceTestList.orderBy('timePost', descending: false).snapshots();
  }

  Map babIdData;
  Map testID;
  final User? user = Auth().currentUser;

  @override
  State<TestList> createState() => _TestListState();
}

late Map _babIdData;
late Map _testID;
late DocumentReference _documentReferenceBab;
late DocumentReference _documentReferenceTest;
late DocumentReference _score;
late CollectionReference _questionAnsweredRef;
late CollectionReference _referenceTestList;
late Stream<QuerySnapshot> _streamMateri;

class _TestListState extends State<TestList> {
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
                  return SubBabList(_babIdData);
                },
              ),
            );
          },
        ),
        title: Text('TEST'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => InputQuestion(_babIdData, _testID),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          checkScore(),
          Padding(
            padding: EdgeInsets.only(top: 60),
            child: testList(),
          ),
        ],
      ),
    );
  }

  testList() {
    return StreamBuilder(
        stream: _streamMateri,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error:${snapshot.error}'));
          }
          if (snapshot.hasData) {
            QuerySnapshot data = snapshot.data!;
            List<QueryDocumentSnapshot> documents = data.docs;
            List<Map> items =
                documents.map((e) => {'id': e.id, 'name': e['name']}).toList();
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                Map listItems = items[i];

                return StreamBuilder(
                  stream: _score.snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      DocumentSnapshot y = snapshot.data;
                      print(y['score']);
                    }

                    print(x);
                    print(listItems['id']);

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionPage(
                              x['name'],
                              x['question'],
                              x['answerA'],
                              x['answerB'],
                              x['answerC'],
                              x['answerD'],
                              x['answerE'],
                              _babIdData,
                              _testID,
                              listItems,
                            ),
                          ),
                        );
                      },
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
                                        builder: (context) => UpdateQuestion(
                                            _babIdData, _testID, listItems)),
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
                                  DocumentReference _documentReferenceTestList =
                                      _documentReferenceTest
                                          .collection('testList')
                                          .doc(listItems['id']);

                                  ApiServices services = ApiServices();
                                  services.deleteQuestion(
                                      _documentReferenceTestList);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  checkScore() {
    final User? user = Auth().currentUser;
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: _score.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot y = snapshot.data;
            return Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.95,
              child: ElevatedButton(
                onPressed: () {
                  ApiServices services = ApiServices();
                  services.checkScore(
                      _questionAnsweredRef, '${user?.uid}', y['score']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => scorePage(_babIdData, _testID)),
                  );
                },
                child: Text(
                  'CHECK SCORE',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.green,
                ),
              ),
            );
          }
          return Container();
        });
  }
}
