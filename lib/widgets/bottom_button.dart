import 'package:flutter/material.dart';

import '../constants.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
    required this.string,
    required this.onTap,
    required this.topMargin,
  }) : super(key: key);

  final VoidCallback onTap;
  final String string;
  final double topMargin;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: kColorSecondary,
          margin: EdgeInsets.only(top: topMargin),
          width: double.infinity,
          height: kBottomContainerHeight,
          child: Center(
            child: Text(
              string,
              style: kButtonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
