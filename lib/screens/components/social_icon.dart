import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';

class SocialIcon extends StatelessWidget {
  final IconData iconSrc;
  final VoidCallback tap;
  const SocialIcon({
    Key? key,
    required this.iconSrc,
    required this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: kPrimaryColor,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconSrc,
          size: 25,
        ),
      ),
    );
  }
}
