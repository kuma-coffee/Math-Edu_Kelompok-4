// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/screens/auth/EditAcc/editAccount.dart';
import 'package:maths_edu/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class scorePage extends StatefulWidget {
  scorePage(this.babIdData, this.testID, {super.key}) {
    _babIdData = babIdData;
    _testID = testID;
    _documentReferenceBab =
        FirebaseFirestore.instance.collection('bab').doc(babIdData['id']);
    _documentReferenceTest =
        _documentReferenceBab.collection('test').doc(testID['id']);
    _referenceTestList = _documentReferenceTest.collection('testList');
    _questionAnsweredRef = _documentReferenceTest.collection('${user?.uid}');
    _score = _questionAnsweredRef.doc('score');
  }

  Map babIdData;
  Map testID;
  final User? user = Auth().currentUser;

  @override
  State<scorePage> createState() => _scorePageState();
}

late Map _babIdData;
late Map _testID;
late DocumentReference _documentReferenceBab;
late DocumentReference _documentReferenceTest;
late DocumentReference _score;
late CollectionReference _questionAnsweredRef;
late CollectionReference _referenceTestList;

class _scorePageState extends State<scorePage> {
  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
            top: Radius.circular(16),
          )),
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: _score.snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                DocumentSnapshot y = snapshot.data;

                return Container(
                  height: size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/sec-background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //_userUid(),
                        Text(
                          'CONGRATULATION',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 24,
                        ),

                        Center(
                          child: Stack(
                            children: [
                              ClipOval(
                                child: Material(
                                  color: Colors.transparent,
                                  child: Ink.image(
                                    image: NetworkImage(
                                        user?.photoURL ?? 'User PhotoURL'),
                                    fit: BoxFit.cover,
                                    width: 128,
                                    height: 128,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Text(
                          '${user?.displayName}',
                          style: TextStyle(fontSize: 22),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Text(
                          'Your Score: ${y['finalScore']}',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 8,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
    );

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
