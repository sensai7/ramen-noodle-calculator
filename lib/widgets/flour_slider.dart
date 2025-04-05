import 'package:flutter/material.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card_slider.dart';

import '../constants.dart';

class FlourSliderCard extends StatelessWidget {
  const FlourSliderCard({
    Key? key,
    required this.flourAPercentage,
    required this.onSliderChanged,
  }) : super(key: key);

  final int flourAPercentage;
  final Function(double) onSliderChanged;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      backgroundColor: kColorInactiveBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(flourAPercentage.toString(), style: kNumberTextStyle),
                  const Text("% ", style: kLabelTextStyle),
                  const Text("FLOUR A", style: kLabelTextStyle),
                ],
              ),
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text((100 - flourAPercentage).toString(), style: kNumberTextStyle),
                  const Text("% ", style: kLabelTextStyle),
                  const Text("FLOUR B", style: kLabelTextStyle),
                ],
              ),
            ],
          ),
          ReusableCardSlider(
            min: 0,
            max: 100,
            position: flourAPercentage,
            onSliderChanged: onSliderChanged,
          ),
        ],
      ),
    );
  }
}
