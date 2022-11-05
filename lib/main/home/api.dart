// ignore_for_file: prefer_const_constructors, file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/services/utils.dart';

class ApiServices {
  uploadDataToFirebase(String url, TextEditingController textController) async {
    //number = Random().nextInt(10);
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    var imgFile =
        FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
    UploadTask task = imgFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    CollectionReference babName = FirebaseFirestore.instance.collection('bab');
    await babName.doc().set({
      'id': babName.doc().id,
      'imgUrl': url,
      'babName': textController.text.trim(),
      'timePost': FieldValue.serverTimestamp()
    });
    return "Success";
  }

  updateDataToFirebase(DocumentReference _documentReference, String url,
      TextEditingController textController) async {
    //number = Random().nextInt(10);
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    var imgFile =
        FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
    UploadTask task = imgFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    Map<String, dynamic> updateBab = ({
      'imgUrl': url,
      'babName': textController.text.trim(),
      'timePost': FieldValue.serverTimestamp()
    });
    _documentReference.update(updateBab);
    return "Success";
  }

  deleteDataToFirebase(DocumentReference _documentReference) {
    _documentReference.delete();
  }

  uploadCollectionToFirebase(CollectionReference _referenceSubBab, String url,
      TextEditingController textController) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    var imgFile =
        FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
    UploadTask task = imgFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> inputSubBab = ({
      'id': _referenceSubBab.doc().id,
      'imgUrl': url,
      'subBabName': textController.text.trim(),
      'timePost': FieldValue.serverTimestamp()
    });
    _referenceSubBab.add(inputSubBab);
    return "Success";
  }

  updateCollectionToFirebase(DocumentReference _documentReferenceSubBab,
      String url, TextEditingController textController) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    var imgFile =
        FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
    UploadTask task = imgFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> updateSubBab = ({
      'imgUrl': url,
      'subBabName': textController.text.trim(),
      'timePost': FieldValue.serverTimestamp()
    });
    _documentReferenceSubBab.update(updateSubBab);
    return "Success";
  }

  deleteCollectionToFirebase(DocumentReference _documentReference) {
    _documentReference.delete();
  }

  // uploadCollectionToFirebase(
  //     String url, TextEditingController textController) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   File pick = File(result!.files.single.path.toString());
  //   var file = pick.readAsBytesSync();
  //   String name = DateTime.now().millisecondsSinceEpoch.toString();

  //   var imgFile =
  //       FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
  //   UploadTask task = imgFile.putData(file);
  //   TaskSnapshot snapshot = await task;
  //   url = await snapshot.ref.getDownloadURL();

  //   CollectionReference subBabName =
  //       FirebaseFirestore.instance.collection('bab');
  //   var id = subBabName.id;
  //   subBabName.doc(id).collection('subBab').add({
  //     'id': id,
  //     'imgUrl': url,
  //     'subBabName': textController.text.trim(),
  //     'timePost': FieldValue.serverTimestamp()
  //   });
  //   return "Success";
  // }

  uploadPDFToFirebase(CollectionReference _referencePDF, String url,
      TextEditingController textController) async {
    //number = Random().nextInt(10);
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    var pdfFile = FirebaseStorage.instance.ref().child(name).child('/.pdf');
    UploadTask task = pdfFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    Map<String, dynamic> inputPDFFile = ({
      'id': _referencePDF.doc().id,
      'fileUrl': url,
      'name': textController.text.trim(),
      'timePost': FieldValue.serverTimestamp()
    });
    _referencePDF.add(inputPDFFile);
    return "Success";
  }

  updatePDFToFirebase(DocumentReference _documentReferenceMateri, String url,
      TextEditingController textController) async {
    //number = Random().nextInt(10);
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    var pdfFile = FirebaseStorage.instance.ref().child(name).child('/.pdf');
    UploadTask task = pdfFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    Map<String, dynamic> updatePDFFile = ({
      'fileUrl': url,
      'name': textController.text.trim(),
      'timePost': FieldValue.serverTimestamp()
    });
    _documentReferenceMateri.update(updatePDFFile);
    return "Success";
  }

  deletePDFToFirebase(DocumentReference _documentReference) {
    _documentReference.delete();
  }

  //TEST API
  inputTest(CollectionReference referenceTest) async {
    Map<String, dynamic> uploadTest = ({
      'id': referenceTest.doc().id,
      'imgUrl':
          'https://firebasestorage.googleapis.com/v0/b/mathedu-kelompok4.appspot.com/o/testImg.png?alt=media&token=b1049d88-d78e-429e-9177-6d3c43d554da',
      'testName': 'Test',
      'timePost': FieldValue.serverTimestamp()
    });
    referenceTest.add(uploadTest);
    return print('Success');
  }

  updateCollectionTest(DocumentReference _documentReferenceTest, String url,
      TextEditingController textController) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    var imgFile =
        FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
    UploadTask task = imgFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> updateTest = ({
      'imgUrl': url,
      'testName': textController.text.trim(),
      'timePost': FieldValue.serverTimestamp()
    });
    _documentReferenceTest.update(updateTest);
    return "Success";
  }

  deleteCollectionTest(DocumentReference _documentReferenceTest) {
    _documentReferenceTest.delete();
  }

  //TEST LIST & QUESTION API

  inputQuestion(
      CollectionReference referenceQuestion,
      TextEditingController nameController,
      TextEditingController questionController,
      TextEditingController answerAController,
      TextEditingController answerBController,
      TextEditingController answerCController,
      TextEditingController answerDController,
      TextEditingController answerEController,
      TextEditingController answerController) async {
    Map<String, dynamic> inputquestion = ({
      'id': referenceQuestion.doc().id,
      'name': nameController.text.trim(),
      'question': questionController.text.trim(),
      'answerA': answerAController.text.trim(),
      'answerB': answerBController.text.trim(),
      'answerC': answerCController.text.trim(),
      'answerD': answerDController.text.trim(),
      'answerE': answerEController.text.trim(),
      'answer': answerController.text.trim(),
      'score': 0,
      'done': false,
      'timePost': FieldValue.serverTimestamp()
    });
    referenceQuestion.add(inputquestion);
    return Utils.showSnackBar('Input Sucessfull', Colors.green);
  }

  updateQuestion(
      DocumentReference referenceTestList,
      TextEditingController nameController,
      TextEditingController questionController,
      TextEditingController answerAController,
      TextEditingController answerBController,
      TextEditingController answerCController,
      TextEditingController answerDController,
      TextEditingController answerEController,
      TextEditingController answerController) async {
    Map<String, dynamic> updatequestion = ({
      'name': nameController.text.trim(),
      'question': questionController.text.trim(),
      'answerA': answerAController.text.trim(),
      'answerB': answerBController.text.trim(),
      'answerC': answerCController.text.trim(),
      'answerD': answerDController.text.trim(),
      'answerE': answerEController.text.trim(),
      'answer': answerController.text.trim(),
      'timePost': FieldValue.serverTimestamp()
    });
    referenceTestList.update(updatequestion);
    return Utils.showSnackBar('Input Sucessfull', Colors.green);
  }

  deleteQuestion(DocumentReference referenceTestList) {
    referenceTestList.delete();
  }

  //Question Answered
  questionAnswered(
    CollectionReference referenceQuestionAnswered,
    String userUID,
  ) {
    DocumentReference scoreRef = referenceQuestionAnswered.doc('score');
    Map<String, dynamic> inputQuestionAnswered = ({
      'userUID': userUID,
      'score': 0,
      'finalScore': 0,
      'timePost': FieldValue.serverTimestamp(),
    });
    scoreRef.set(inputQuestionAnswered);
  }

  updateQuestionAnswered(
    DocumentReference questionRef,
    CollectionReference referenceQuestionAnswered,
    String userUID,
    String questionID,
    int score,
    String userAnswer,
    String answer,
  ) {
    DocumentReference scoreRef = referenceQuestionAnswered.doc('score');

    if (userAnswer == answer) {
      Map<String, dynamic> updateQuestionAnswered = ({
        'userUID': userUID,
        'questionID': questionID,
        'timePost': FieldValue.serverTimestamp(),
        'score': score += 1,
        'finalScore': 0,
        'done.${questionRef.id}': true,
      });
      scoreRef.update(updateQuestionAnswered);
      return print('Question Answered');
    } else {
      Map<String, dynamic> updateQuestionAnswered = ({
        'userUID': userUID,
        'questionID': questionID,
        'timePost': FieldValue.serverTimestamp(),
        'score': score,
        'finalScore': 0,
        'done.${questionRef.id}': true,
      });
      scoreRef.update(updateQuestionAnswered);
      return print('Question Answered');
    }
  }

  checkScore(
    CollectionReference referenceQuestionAnswered,
    String userUID,
    int score,
  ) {
    DocumentReference scoreRef = referenceQuestionAnswered.doc('score');
    int result = score * 10;
    Map<String, dynamic> updateQuestionAnswered = ({
      'finalScore': result,
    });
    scoreRef.update(updateQuestionAnswered);
    print('Score show');
  }
}
