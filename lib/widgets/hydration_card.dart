import 'package:flutter/material.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card_percentage.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card_slider.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card_title.dart';

import '../constants.dart';
import 'help_icon.dart';

class HydrationPanel extends StatelessWidget {
  const HydrationPanel({
    Key? key,
    required this.hydration,
    required this.onSliderChanged,
  }) : super(key: key);

  final int hydration;
  final Function(double) onSliderChanged;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      child: Stack(children: [
        const HelpIcon(
          popupID: kHydrationText,
          isZoomable: false,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const ReusableCardTitle(textContent: kHydrationText),
            ReusableCardPercentage(value: hydration),
            ReusableCardSlider(
              min: 20,
              max: 50,
              position: hydration,
              onSliderChanged: onSliderChanged,
            ),
          ],
        ),
      ]),
    );
  }
}
