import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maths_edu/components/text_field_container.dart';
import 'package:maths_edu/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = FontAwesomeIcons.solidUser,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
              icon: Icon(
                icon,
                color: kPrimaryColor,
              ),
              hintText: hintText,
              border: InputBorder.none)),
    );
  }
}
