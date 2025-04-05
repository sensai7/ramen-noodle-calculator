// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../constants.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    Key? key,
    required this.icon,
    required this.string,
  }) : super(key: key);

  final IconData icon;
  final String string;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: kIconSize),
        SizedBox(height: kIconTobBottomPadding),
        Text(string, style: kLabelTextStyle),
        SizedBox(height: kIconTobBottomPadding),
      ],
    );
  }
}
