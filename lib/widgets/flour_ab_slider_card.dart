import 'package:flutter/material.dart';
import 'package:ramen_noodle_calc/widgets/flour_slider.dart';

class FlourABSliderCard extends StatelessWidget {
  const FlourABSliderCard({
    Key? key,
    required this.visible,
    required this.flourAPercentage,
    required this.onSliderChanged,
  }) : super(key: key);

  final bool visible;
  final int flourAPercentage;
  final Function(double) onSliderChanged;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: FlourSliderCard(
        flourAPercentage: flourAPercentage,
        onSliderChanged: onSliderChanged,
      ),
    );
  }
}
