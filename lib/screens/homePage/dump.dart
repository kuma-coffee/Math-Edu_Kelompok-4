// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dump extends StatelessWidget {
  Dump({super.key});

  final User? user = Auth().currentUser;

  //import sign out
  Future<void> signOut() async {
    await Auth().signOut();
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

              CircleAvatar(
                radius: 40,
                backgroundImage:
                    NetworkImage(user?.photoURL ?? 'User PhotoURL'),
              ),
              SizedBox(
                height: 10,
              ),

              Text(
                'Name: ${user?.displayName}',
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
                height: 10,
              ),

              Text(
                'Nomor Telepon: ${user?.phoneNumber}',
                style: TextStyle(fontSize: 18),
              ),

              SizedBox(
                height: 24,
              ),
              //Sign out button
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () async {
                    await signOut();
                  },
                  child: Text(
                    'SIGN OUT',
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
