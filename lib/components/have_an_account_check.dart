import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';

class HaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback tap;
  const HaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don\'t have an Account? " : 'Already have an Account? ',
        ),
        GestureDetector(
          onTap: tap,
          child: Text(
            login ? 'Sign Up' : 'Login',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
