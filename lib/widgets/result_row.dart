import 'package:flutter/material.dart';
import '../constants.dart';

class ResultRow extends StatelessWidget {
  const ResultRow({
    Key? key,
    required this.resultNumber,
    required this.name,
    required this.icon,
    required this.decimalPlaces,
    required this.suffix,
  }) : super(key: key);

  final double resultNumber;
  final String name;
  final IconData icon;
  final int decimalPlaces;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 30, color: kColorText),
            const SizedBox(width: 10),
            Text(
              name +
                  ": " +
                  (decimalPlaces == 0 ? resultNumber.toInt().toString() : resultNumber.toStringAsFixed(decimalPlaces)) +
                  suffix,
              style: kResultTextStyle,
            )
          ],
        ),
      ],
    );
  }
}
