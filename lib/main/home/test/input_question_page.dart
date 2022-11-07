// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/test/test_list_page.dart';

final nameController = TextEditingController();
final questionController = TextEditingController();
final answerAController = TextEditingController();
final answerBController = TextEditingController();
final answerCController = TextEditingController();
final answerDController = TextEditingController();
final answerEController = TextEditingController();
final answerController = TextEditingController();

class InputQuestion extends StatelessWidget {
  InputQuestion(this.adminUID, this.kelasId, this.babIdData, this.testID,
      {Key? key})
      : super(key: key) {
    _documentReferenceBab =
        FirebaseFirestore.instance.collection(kelasId).doc(babIdData['id']);
    _documentReferenceSubBab =
        _documentReferenceBab.collection('test').doc(testID['id']);
    _referenceTestList = _documentReferenceSubBab.collection('testList');
  }
  String adminUID;
  String kelasId;
  Map babIdData;
  Map testID;
  late DocumentReference _documentReferenceBab;
  late DocumentReference _documentReferenceSubBab;
  late CollectionReference _referenceTestList;

  String url = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Pertanyaan'),
      ),
      body: Center(
        child: SingleChildScrollView(
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
                    //Question Name textfield
                    TextFormField(
                      controller: nameController,
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
                height: size.height * 0.005,
              ),

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
                    //Question Name textfield
                    TextFormField(
                      controller: questionController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Enter Question',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.005,
              ),

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
                    //Question Name textfield
                    TextFormField(
                      controller: answerAController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Enter Answer A',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.005,
              ),
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
                    //Question Name textfield
                    TextFormField(
                      controller: answerBController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Enter Answer B',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.005,
              ),
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
                    //Question Name textfield
                    TextFormField(
                      controller: answerCController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Enter Answer C',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.005,
              ),
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
                    //Question Name textfield
                    TextFormField(
                      controller: answerDController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Enter Answer D',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.005,
              ),
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
                    //Question Name textfield
                    TextFormField(
                      controller: answerEController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Enter Answer E',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.005,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  //color: Color.fromARGB(255, 240, 239, 239),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kPrimaryColor, width: 1.0),
                  color: Colors.lightGreen,
                ),
                child: Column(
                  children: [
                    //Question Name textfield
                    TextFormField(
                      controller: answerController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Enter Answer',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),

              //Save
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    ApiServices services = ApiServices();
                    services.inputQuestion(
                        _referenceTestList,
                        nameController,
                        questionController,
                        answerAController,
                        answerBController,
                        answerCController,
                        answerDController,
                        answerEController,
                        answerController);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            TestList(adminUID, kelasId, babIdData, testID),
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
            ],
          ),
        ),
      ),
    );
  }
}
