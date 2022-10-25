// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/main.dart';
import 'package:maths_edu/screens/ForgotPass/forgot_pass_page.dart';
import 'package:maths_edu/screens/SignUpPage/sign_up_page.dart';
import 'package:maths_edu/screens/components/or_divider.dart';
import 'package:maths_edu/screens/homePage/dump.dart';
import 'package:maths_edu/services/auth.dart';
import 'package:maths_edu/services/utils.dart';
import 'package:provider/provider.dart';

class editAcc extends StatefulWidget {
  const editAcc({super.key});

  @override
  State<editAcc> createState() => _editAccState();
}

class _editAccState extends State<editAcc> {
  final User? user = Auth().currentUser;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  //import sign out
  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Dump();
                },
              ),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
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
            children: [
              Column(
                children: [
                  Text(
                    'Edit Account',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return editAcc();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -1,
                          right: 1,
                          child: ClipOval(
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(3.0),
                              child: ClipOval(
                                child: Container(
                                  color: kPrimaryColor,
                                  padding: EdgeInsets.all(0.0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.photo_camera,
                                      size: 20,
                                    ),
                                    color: Colors.white,
                                    onPressed: updateProfileImg,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
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
                    //Username textfield
                    TextFormField(
                      controller: usernameController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        icon: Icon(
                          FontAwesomeIcons.solidUser,
                          color: kPrimaryColor,
                        ),
                        hintText: 'Username',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),

              //Update button
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ForgotPasswordPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'CHANGE PASSWORD',
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

              //Update button
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: updateUsername,
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

  // editAcc() async {
  //   if (usernameController.text.isNotEmpty) {
  //     user?.updateDisplayName(usernameController.text.trim());
  //     Utils.showSnackBar('Updates Success', Colors.green);
  //   } else {
  //     Utils.showSnackBar('No Updates', Colors.red);
  //     print('No Username Updates');
  //   }

  //   // if (usernameController.text.isNotEmpty) {
  //   //   user?.updateEmail(emailController.text.trim());
  //   // } else {
  //   //   print('No Email Updates');
  //   // }

  //   return 'Update Success';
  // }
  updateUsername() {
    //update
    if (usernameController.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('userProfile')
          .where('uid', isEqualTo: user?.uid)
          .get()
          .then((value) => value.docs.forEach((doc) => doc.reference.update({
                'username': usernameController.text.trim(),
              })));

      Utils.showSnackBar('Updates Success', Colors.green);
    } else {
      Utils.showSnackBar('No Updates', Colors.red);
      print('No Username Updates');
    }
  }

  updateProfileImg() async {
    String url = '';

    //get image
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    var imgFile =
        FirebaseStorage.instance.ref().child(name).child('/.jpg' + '/.png');
    UploadTask task = imgFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    //update
    try {
      FirebaseFirestore.instance
          .collection('userProfile')
          .where('uid', isEqualTo: user?.uid)
          .get()
          .then((value) => value.docs.forEach((doc) => doc.reference.update({
                'profileImg': url,
              })));
      Utils.showSnackBar('Updates Success', Colors.green);
    } on Exception catch (e) {
      Utils.showSnackBar('Updates Success', Colors.red);
      print(e);
    }
  }
}
