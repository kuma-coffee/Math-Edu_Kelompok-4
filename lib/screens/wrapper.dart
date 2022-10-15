// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/screens/SignInPage/sign_in_page.dart';
import 'package:maths_edu/screens/VerifyEmail/verify_email_page.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return VerifyEmailPage();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something Went Wrong!'),
          );
        } else {
          return SignInPage();
        }
      },
    );
  }
}
