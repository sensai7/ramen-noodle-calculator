import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';

class AdjunctResultRow extends StatelessWidget {
  const AdjunctResultRow({
    Key? key,
    required this.nameList,
    required this.percentagesList,
    required this.gramsList,
  }) : super(key: key);

  final List nameList;
  final List percentagesList;
  final List gramsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(FontAwesomeIcons.mortarPestle, size: 30, color: kColorText),
            SizedBox(width: 10),
            Text("ADJUNCTS: ", style: kResultTextStyle)
          ],
        ),
        for (int i = 0; i < nameList.length; i++)
          if (nameList[i] != "" && percentagesList[i] != 0.0)
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: Text(
                "\u2022 ${nameList[i]} (${percentagesList[i].toStringAsFixed(1)}%): "
                "${gramsList[i].toStringAsFixed(2)}g",
                style: kLabelTextStyle,
              ),
            ),
      ],
    );
  }
}
