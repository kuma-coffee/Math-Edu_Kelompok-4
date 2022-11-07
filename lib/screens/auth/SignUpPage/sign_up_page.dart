// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/main.dart';
import 'package:maths_edu/screens/auth/SignInPage/sign_in_page.dart';
import 'package:maths_edu/screens/auth/VerifyEmail/verify_email_page.dart';
import 'package:maths_edu/screens/components/or_divider.dart';
import 'package:maths_edu/services/auth.dart';
import 'package:maths_edu/services/utils.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: formKey,
      child: Scaffold(
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
                //Logo
                Container(
                  height: size.height * 0.18,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/launch_image.png',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),

                //Login Text
                Column(
                  children: [
                    Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      'Create your account',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.isEmpty
                            ? 'Enter a valid usernmae'
                            : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
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

                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      //color: Color.fromARGB(255, 240, 239, 239),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kPrimaryColor, width: 1.0)),
                  child: Column(
                    children: [
                      //Password textfield
                      TextFormField(
                        controller: passwordController,
                        onChanged: (value) {},
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(
                            FontAwesomeIcons.lock,
                            color: kPrimaryColor,
                          ),
                          border: InputBorder.none,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? 'Enter min. 6 characters'
                            : null,
                      ),
                    ],
                  ),
                ),

                //Sign Up button
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      await signUp();
                    },
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      backgroundColor: kPrimaryColor,
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an Account? ',
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignInPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),

                //Or divider
                OrDivider(),

                //Sign Up with google
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googLogin();
                    },
                    icon: Image(
                      image: AssetImage('assets/icons/google.png'),
                      width: 20.0,
                    ),
                    label: Text(
                      'Sign Up With Google',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: kPrimaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SIGN UP
  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      CollectionReference userProfile =
          FirebaseFirestore.instance.collection('userProfile');
      await userProfile.doc(Auth().currentUser?.uid).set({
        'uid': Auth().currentUser?.uid,
        'profileImg':
            'https://firebasestorage.googleapis.com/v0/b/mathedu-kelompok4.appspot.com/o/userDefaultLogo.png?alt=media&token=a2722a2a-0199-4841-9b6f-18928d8b06a2',
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'admin': false,
      });
      // CollectionReference userProfile =
      //     FirebaseFirestore.instance.collection('userProfile');
      // await userProfile.doc().set({
      //   'id': userProfile.doc().id,
      //   'imgUrl':
      //       'https://firebasestorage.googleapis.com/v0/b/mathedu-kelompok4.appspot.com/o/userDefaultLogo.png?alt=media&token=a2722a2a-0199-4841-9b6f-18928d8b06a2',
      // });
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message, Colors.red);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
