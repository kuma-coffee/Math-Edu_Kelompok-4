// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/services/utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
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
                    'Receive an email to reset your password',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
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
                    //Email textfield
                    TextFormField(
                      controller: emailController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        icon: Icon(
                          FontAwesomeIcons.solidUser,
                          color: kPrimaryColor,
                        ),
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              : null,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),

              //Forgot Password
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: resetPassword,
                  child: Text(
                    'RESET PASSWORD',
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

  // RESET PASSWORD
  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar('Password Reset Email Sent', Colors.red);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message, Colors.red);
      Navigator.of(context).pop();
    }
  }
}
