import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            backgroundColor: color,
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),

      // return Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
      //   child: Container(
      //     padding: EdgeInsets.all(20),
      //     decoration: BoxDecoration(
      //         color: kPrimaryColor,
      //         borderRadius: BorderRadius.circular(12)),
      //     child: Center(
      //       child: Text(
      //         'Login',
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold,
      //           fontSize: 18,
      //         ),
      //       ),
      //     ),
      //   ),
    );
  }
}
