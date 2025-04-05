import 'package:flutter/cupertino.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card_title.dart';
import '../constants.dart';
import 'help_icon.dart';

class ProteinPanel extends StatelessWidget {
  const ProteinPanel({
    Key? key,
    required this.protein,
  }) : super(key: key);

  final double protein;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      child: Stack(children: [
        const HelpIcon(
          popupID: kProteinText,
          isZoomable: true,
        ),
        Column(
          children: [
            const SizedBox(height: 10),
            const ReusableCardTitle(textContent: "PROTEIN"),
            const SizedBox(height: 5),
            Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(protein.toStringAsFixed(3), style: kNumberTextStyle),
                const Text("%", style: kLabelTextStyle),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
