import 'package:flutter/material.dart';
import 'package:maths_edu/components/have_an_account_check.dart';
import 'package:maths_edu/components/rounded_button.dart';
import 'package:maths_edu/components/rounded_input_field.dart';
import 'package:maths_edu/components/rounded_password_field.dart';
import 'package:maths_edu/screens/components/background.dart';
import 'package:maths_edu/screens/components/body.dart';
import 'package:maths_edu/screens/homePage/home_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Logo
              Image.asset(
                'assets/images/launch_image.png',
                height: size.height * 0.2,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),

              //Login Text
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

              //Email textfield
              RoundedInputField(
                hintText: 'Email',
                onChanged: (value) {},
              ),

              //Password textfield
              RoundedPasswordField(
                onChanged: (value) {},
              ),

              //Sign Up button
              RoundedButton(
                text: 'SIGN UP',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return MyHomePage(
                        title: 'Maths Edu',
                      );
                    }),
                  );
                },
              ),

              //Don't have an Account? Sign Up
              HaveAnAccountCheck(
                login: false,
                tap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Body();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
