// ignore_for_file: prefer_const_constructors, file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ApiServices {
  uploadDataToFirebase(String url, TextEditingController textController) async {
    //number = Random().nextInt(10);
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    var pdfFile =
        FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
    UploadTask task = pdfFile.putData(file);
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

    var pdfFile =
        FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
    UploadTask task = pdfFile.putData(file);
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

    var pdfFile =
        FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
    UploadTask task = pdfFile.putData(file);
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

    var pdfFile =
        FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
    UploadTask task = pdfFile.putData(file);
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

  //   var pdfFile =
  //       FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
  //   UploadTask task = pdfFile.putData(file);
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
}
