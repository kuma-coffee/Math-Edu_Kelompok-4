// ignore_for_file: prefer_const_constructors, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/dashboard.dart';

final textController = TextEditingController();

class InputBab extends StatelessWidget {
  String kelasId;

  InputBab(this.kelasId, {super.key}) {
    _kelasId = kelasId;
  }
  String url = '';
  late String _kelasId;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Bab'),
      ),
      body: Center(
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
                  //Bab Name textfield
                  TextFormField(
                    controller: textController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Bab Name',
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.01,
            ),

            //Select Image Icon Password
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  ApiServices services = ApiServices();
                  services.uploadDataToFirebase(_kelasId, url, textController);
                },
                child: Text(
                  'Select Image Icon',
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

            SizedBox(
              height: size.height * 0.05,
            ),

            //Save
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Dashboard(),
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
    );
  }
}
