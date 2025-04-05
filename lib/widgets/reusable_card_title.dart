import 'package:flutter/material.dart';
import '../constants.dart';

class ReusableCardTitle extends StatelessWidget {
  const ReusableCardTitle({
    Key? key,
    required this.textContent,
  }) : super(key: key);

  final String textContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(textContent, style: kLabelTextStyle),
        const SizedBox(height: 8),
      ],
    );
  }
}
