// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/main/home/setting_page.dart';
import 'package:maths_edu/screens/auth/EditAcc/editAccount.dart';
import 'package:maths_edu/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final User? user = Auth().currentUser;

  void initState() {
    super.initState();
    updateUsername();
    updateProfileImg();
  }

  //import sign out
  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future updateUsername() async {
    final userProfile = FirebaseFirestore.instance
        .collection('userProfile')
        .where('uid', isEqualTo: user?.uid)
        .snapshots()
        .listen((data) => data.docs
            .forEach((doc) => user?.updateDisplayName(doc['username'])));
    return userProfile;
  }

  Future updateProfileImg() async {
    final userProfile = FirebaseFirestore.instance
        .collection('userProfile')
        .where('uid', isEqualTo: user?.uid)
        .snapshots()
        .listen((data) => data.docs
            .forEach((doc) => user?.updatePhotoURL(doc['profileImg'])));
    //return print(userProfile.toString());
    return userProfile;
  }

  // Widget _userUid() {
  //   return Text(user?.email ?? 'User email');
  // }

  // Widget _userPhoto() {
  //   return Text(user?.photoURL ?? 'User PhotoURL');
  // }

  // Widget _userName() {
  //   return Text(user?.displayName ?? 'User Name');
  // }

  // Widget _userPhone() {
  //   return Text(user?.phoneNumber ?? 'User PhoneNumber');
  // }

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => settingPage()),
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
            children: <Widget>[
              //_userUid(),
              Text(
                'Profile',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 24,
              ),

              // CircleAvatar(
              //   radius: 40,
              //   backgroundImage:
              //       NetworkImage(user?.photoURL ?? 'User PhotoURL'),
              // ),
              Center(
                child: Stack(
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: Ink.image(
                          image:
                              NetworkImage(user?.photoURL ?? 'User PhotoURL'),
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
                'Username: ${user?.displayName}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),

              Text(
                'Email: ${user?.email}',
                style: TextStyle(fontSize: 18),
              ),

              SizedBox(
                height: 32,
              ),
              //Sign out button
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return editAcc();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'EDIT ACCOUNT',
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
