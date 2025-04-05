import 'package:flutter/material.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card_percentage.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card_slider.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card_title.dart';

import '../constants.dart';
import 'help_icon.dart';

class KansuiPanel extends StatelessWidget {
  const KansuiPanel({
    Key? key,
    required this.sodium,
    required this.onSliderChanged,
  }) : super(key: key);

  final int sodium;
  final Function(double) onSliderChanged;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      child: Stack(children: [
        const HelpIcon(
          popupID: kKansuiText,
          isZoomable: false,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const ReusableCardTitle(textContent: kKansuiComp),
            Row(
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    ReusableCardPercentage(value: sodium),
                    const SizedBox(width: 4),
                    const ReusableCardTitle(textContent: kKansuiSodium),
                  ],
                ),
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    ReusableCardPercentage(value: 100 - sodium),
                    const SizedBox(width: 4),
                    const ReusableCardTitle(textContent: kKansuiPotassium),
                  ],
                ),
              ],
            ),
            ReusableCardSlider(
              min: 0,
              max: 100,
              position: sodium,
              onSliderChanged: onSliderChanged,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ]),
    );
  }
}
