// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/screens/SignInPage/sign_in_page.dart';
import 'package:maths_edu/screens/components/or_divider.dart';
import 'package:maths_edu/services/auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? errorMessage = '';
  //bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  // import SIGN UP
  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // error message
  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : 'Your email or password is wrong',
      style: TextStyle(color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    List socialImg = [
      'facebook.png',
      'google.png',
      'twitter.png',
    ];

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
            children: [
              //Logo
              Container(
                height: size.height * 0.2,
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
                    'Create an account',
                    style: TextStyle(fontSize: 18),
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
                  color: Color.fromARGB(255, 240, 239, 239),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    //Email textfield
                    TextField(
                      controller: _controllerEmail,
                      //onChanged: (value) => setState(() => value),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                          icon: Icon(
                            FontAwesomeIcons.solidUser,
                            color: kPrimaryColor,
                          ),
                          hintText: 'Email',
                          border: InputBorder.none),
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
                  color: Color.fromARGB(255, 240, 239, 239),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    //Password textfield
                    TextField(
                      controller: _controllerPassword,
                      onChanged: (value) {},
                      //onChanged: (value) => setState(() => value),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: Icon(
                          FontAwesomeIcons.lock,
                          color: kPrimaryColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),

              //error message
              _errorMessage(),

              //Sign Up button
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () async {
                    await createUserWithEmailAndPassword();
                  },
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

              //Sign Up with another way
              Wrap(
                children: List<Widget>.generate(
                  3,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: kPrimaryColor,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage('assets/icons/' + socialImg[index]),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}





// class SignUpPage extends StatelessWidget {
//   SignUpPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Background(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               //Logo
//               Image.asset(
//                 'assets/images/launch_image.png',
//                 height: size.height * 0.2,
//               ),
//               SizedBox(
//                 height: size.height * 0.05,
//               ),

//               //Login Text
//               Text(
//                 'SIGN UP',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 36,
//                 ),
//               ),
//               SizedBox(
//                 height: size.height * 0.01,
//               ),

//               Text(
//                 'Create an account',
//                 style: TextStyle(fontSize: 18),
//               ),
//               SizedBox(
//                 height: size.height * 0.05,
//               ),

//               //Email textfield
//               RoundedInputField(
//                 hintText: 'Email',
//                 onChanged: (value) {},
//               ),

//               //Password textfield
//               RoundedPasswordField(
//                 onChanged: (value) {},
//               ),

//               //Sign Up button
//               RoundedButton(
//                 text: 'SIGN UP',
//                 press: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (context) {
//                   //     return TabBarDemo();
//                   //   }),
//                   // );
//                 },
//               ),

//               //Don't have an Account? Sign Up
//               HaveAnAccountCheck(
//                 login: false,
//                 tap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return LoginPage();
//                       },
//                     ),
//                   );
//                 },
//               ),

//               //Or divider
//               OrDivider(),

//               //Sign Up with another way
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SocialIcon(
//                     iconSrc: FontAwesomeIcons.google,
//                     tap: () {},
//                   ),
//                   SocialIcon(
//                     iconSrc: FontAwesomeIcons.facebookF,
//                     tap: () {},
//                   ),
//                   SocialIcon(
//                     iconSrc: FontAwesomeIcons.twitter,
//                     tap: () {},
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
