// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/test/test_list_page.dart';
import 'package:maths_edu/services/auth.dart';
import 'package:maths_edu/services/utils.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage(
      this.adminUID,
      this.kelasId,
      this.name,
      this.question,
      this.answerA,
      this.answerB,
      this.answerC,
      this.answerD,
      this.answerE,
      this.babIdData,
      this.testID,
      this.questionID,
      {Key? key})
      : super(key: key) {
    _adminUID = adminUID;
    _kelasId = kelasId;
    _name = name;
    _question = question;
    _answerA = answerA;
    _answerB = answerB;
    _answerC = answerC;
    _answerD = answerD;
    _answerE = answerE;
    _babIdData = babIdData;
    _testID = testID;
    _questionID = questionID;

    _documentReferenceBab =
        FirebaseFirestore.instance.collection(kelasId).doc(babIdData['id']);
    _documentReferenceTest =
        _documentReferenceBab.collection('test').doc(testID['id']);
    _questionRef =
        _documentReferenceTest.collection('testList').doc(questionID['id']);
    _questionAnsweredRef = _documentReferenceTest.collection('${user?.uid}');
    _score = _questionAnsweredRef.doc('score');
    _streamQuestion = _questionRef.snapshots();
    _streamQuestionAnswered = _questionAnsweredRef.snapshots();
  }

  List adminUID;
  String kelasId;
  var name;
  var question;
  var answerA;
  var answerB;
  var answerC;
  var answerD;
  var answerE;
  Map babIdData;
  Map testID;
  Map questionID;
  final User? user = Auth().currentUser;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

late List _adminUID;
late String _kelasId;
late String _name;
late String _question;
late String _answerA;
late String _answerB;
late String _answerC;
late String _answerD;
late String _answerE;
late Map _babIdData;
late Map _testID;
late Map _questionID;
late DocumentReference _documentReferenceBab;
late DocumentReference _documentReferenceTest;
late DocumentReference _questionRef;
late DocumentReference _score;
late CollectionReference _questionAnsweredRef;
late Stream<DocumentSnapshot<Object?>> _streamQuestion;
late Stream<QuerySnapshot<Object?>> _streamQuestionAnswered;

class _QuestionPageState extends State<QuestionPage> {
  final User? user = Auth().currentUser;
  bool checkA = false;
  bool checkB = false;
  bool checkC = false;
  bool checkD = false;
  bool checkE = false;

  @override
  void initState() {
    super.initState();
    checkA = false;
    checkB = false;
    checkC = false;
    checkD = false;
    checkE = false;
  }

  void changeAnswerToA() {
    setState(() {
      checkA = true;
      checkB = false;
      checkC = false;
      checkD = false;
      checkE = false;
    });
    return print('Change answer succesfull');
  }

  void changeAnswerToB() {
    setState(() {
      checkA = false;
      checkB = true;
      checkC = false;
      checkD = false;
      checkE = false;
    });
    return print('Change answer succesfull');
  }

  void changeAnswerToC() {
    setState(() {
      checkA = false;
      checkB = false;
      checkC = true;
      checkD = false;
      checkE = false;
    });
    return print('Change answer succesfull');
  }

  void changeAnswerToD() {
    setState(() {
      checkA = false;
      checkB = false;
      checkC = false;
      checkD = true;
      checkE = false;
    });
    return print('Change answer succesfull');
  }

  void changeAnswerToE() {
    setState(() {
      checkA = false;
      checkB = false;
      checkC = false;
      checkD = false;
      checkE = true;
    });
    return print('Change answer succesfull');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: _streamQuestion,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error:${snapshot.error}'));
          }
          if (snapshot.hasData) {
            DocumentSnapshot x = snapshot.data;
            return StreamBuilder(
              stream: _score.snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  DocumentSnapshot y = snapshot.data;

                  return Scaffold(
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      title: Text(_name.toString()),
                      leading: BackButton(
                        color: Colors.white,
                      ),
                      elevation: 0,
                    ),
                    body: Container(
                      height: size.height,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/fourth-background.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'MATH EDU',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 140,
                                        child: Text(
                                          '1.',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.04,
                                      ),
                                      Flexible(
                                        child: Text(
                                          _question.toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: ListTile(
                                    leading: checkA
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.circle_rounded,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {},
                                          )
                                        : IconButton(
                                            icon: const Icon(
                                              Icons.circle_outlined,
                                              color: Colors.black,
                                            ),
                                            onPressed: () => changeAnswerToA(),
                                          ),
                                    title: Text(_answerA.toString()),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: ListTile(
                                    leading: checkB
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.circle_rounded,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {},
                                          )
                                        : IconButton(
                                            icon: const Icon(
                                              Icons.circle_outlined,
                                              color: Colors.black,
                                            ),
                                            onPressed: () => changeAnswerToB(),
                                          ),
                                    title: Text(_answerB.toString()),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: ListTile(
                                    leading: checkC
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.circle_rounded,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {},
                                          )
                                        : IconButton(
                                            icon: const Icon(
                                              Icons.circle_outlined,
                                              color: Colors.black,
                                            ),
                                            onPressed: () => changeAnswerToC(),
                                          ),
                                    title: Text(_answerC.toString()),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: ListTile(
                                    leading: checkD
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.circle_rounded,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {},
                                          )
                                        : IconButton(
                                            icon: const Icon(
                                              Icons.circle_outlined,
                                              color: Colors.black,
                                            ),
                                            onPressed: () => changeAnswerToD(),
                                          ),
                                    title: Text(_answerD.toString()),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: ListTile(
                                    leading: checkE
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.circle_rounded,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {},
                                          )
                                        : IconButton(
                                            icon: const Icon(
                                              Icons.circle_outlined,
                                              color: Colors.black,
                                            ),
                                            onPressed: () => changeAnswerToE(),
                                          ),
                                    title: Text(_answerE.toString()),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.05,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  //Submit Password
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: size.width * 0.35,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        ApiServices services = ApiServices();
                                        if (checkA == true) {
                                          services.updateQuestionAnswered(
                                              _questionRef,
                                              _questionAnsweredRef,
                                              '${user?.uid}',
                                              x['id'],
                                              y['score'],
                                              x['answerA'],
                                              x['answer']);
                                        } else if (checkB == true) {
                                          services.updateQuestionAnswered(
                                              _questionRef,
                                              _questionAnsweredRef,
                                              '${user?.uid}',
                                              x['id'],
                                              y['score'],
                                              x['answerB'],
                                              x['answer']);
                                        } else if (checkC == true) {
                                          services.updateQuestionAnswered(
                                              _questionRef,
                                              _questionAnsweredRef,
                                              '${user?.uid}',
                                              x['id'],
                                              y['score'],
                                              x['answerC'],
                                              x['answer']);
                                        } else if (checkD == true) {
                                          services.updateQuestionAnswered(
                                              _questionRef,
                                              _questionAnsweredRef,
                                              '${user?.uid}',
                                              x['id'],
                                              y['score'],
                                              x['answerD'],
                                              x['answer']);
                                        } else if (checkE == true) {
                                          services.updateQuestionAnswered(
                                              _questionRef,
                                              _questionAnsweredRef,
                                              '${user?.uid}',
                                              x['id'],
                                              y['score'],
                                              x['answerE'],
                                              x['answer']);
                                        } else {
                                          return print(
                                              'You have not answered the question');
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TestList(
                                                  _adminUID,
                                                  _kelasId,
                                                  _babIdData,
                                                  _testID)),
                                        );
                                      },
                                      child: Text(
                                        'SUBMIT',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 40),
                                        backgroundColor: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
