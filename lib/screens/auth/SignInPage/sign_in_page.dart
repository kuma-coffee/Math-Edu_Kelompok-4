// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/main.dart';
import 'package:maths_edu/screens/auth/ForgotPass/forgot_pass_page.dart';
import 'package:maths_edu/screens/auth/SignUpPage/sign_up_page.dart';
import 'package:maths_edu/screens/components/or_divider.dart';
import 'package:maths_edu/services/auth.dart';
import 'package:maths_edu/services/utils.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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

              Column(
                children: [
                  Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Sign in to your account',
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

              // forgot password
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
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
                        'Forgot Password?',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Sign In button
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: signIn,
                  child: Text(
                    'SIGN IN',
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account? ',
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpPage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              //Or divider
              OrDivider(),

              //Sign Up with google
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googLogin();
                  },
                  icon: Image(
                    image: AssetImage('assets/icons/google.png'),
                    width: 20.0,
                  ),
                  label: Text(
                    'Sign In With Google',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 1.0, color: kPrimaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // SIGN IN
  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message, Colors.red);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
