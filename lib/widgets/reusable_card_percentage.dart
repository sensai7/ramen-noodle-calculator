import 'package:flutter/material.dart';
import '../constants.dart';

class ReusableCardPercentage extends StatelessWidget {
  const ReusableCardPercentage({
    Key? key,
    required this.value,
  }) : super(key: key);

  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Text(
          value.toString(),
          style: kNumberTextStyle,
        ),
        const Text(
          "%",
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
