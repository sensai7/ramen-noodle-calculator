import 'package:flutter/material.dart';
import '../constants.dart';

class MultiResultRow extends StatelessWidget {
  const MultiResultRow({
    Key? key,
    required this.resultNumber,
    required this.name,
    required this.icon,
    required this.decimalPlaces,
    required this.flourName,
    required this.percentage,
    required this.suffix,
    required this.percentageDecimalPlaces,
  }) : super(key: key);

  final double resultNumber;
  final String name;
  final IconData icon;
  final int decimalPlaces;
  final String flourName;
  final double percentage;
  final String suffix;
  final int percentageDecimalPlaces;

  @override
  Widget build(BuildContext context) {
    String firstRow = '';
    String per, amt = '';
    if (percentageDecimalPlaces == 0) {
      per = " (" + percentage.round().toString() + "%)";
    } else {
      per = " (" + percentage.toStringAsFixed(percentageDecimalPlaces) + "%)";
    }
    if (decimalPlaces == 0) {
      amt = ": " + resultNumber.round().toString() + "g" + suffix;
    } else {
      amt = ": " + resultNumber.toStringAsFixed(decimalPlaces) + "g" + suffix;
    }

    firstRow = name + per + amt;

    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 30, color: const Color(0xFF340606)),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstRow,
                    style: kResultTextStyle,
                  ),
                  ((resultNumber != 0) && flourName != "")
                      ? Text(flourName,
                          style: kLabelTextStyle, overflow: TextOverflow.ellipsis, softWrap: false, maxLines: 1)
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
