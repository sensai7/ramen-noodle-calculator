import 'package:flutter/material.dart';
import '../constants.dart';

class ReusableCardSlider extends StatelessWidget {
  ReusableCardSlider({
    Key? key,
    required this.min,
    required this.max,
    required this.position,
    required this.onSliderChanged,
  }) : super(key: key);

  final int min;
  final int max;
  int position;
  final Function(double) onSliderChanged;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: kBarThumbRadius,
        ),
        overlayShape: const RoundSliderOverlayShape(
          overlayRadius: kBarOverlayRadius,
        ),
        activeTrackColor: kColorBarActiveTrack,
        inactiveTrackColor: kColorBarInactiveTrack,
        overlayColor: kColorBarOverlay,
        thumbColor: kColorBarThumb,
      ),
      child: Slider(
        value: position.toDouble(),
        min: min.toDouble(),
        max: max.toDouble(),
        onChanged: (newValue) {
          position = newValue.toInt();
          onSliderChanged(newValue);
        },
      ),
    );
  }
}

class ReusableCardDoubleSlider extends StatelessWidget {
  ReusableCardDoubleSlider({
    Key? key,
    required this.min,
    required this.max,
    required this.position,
    required this.onSliderChanged,
  }) : super(key: key);

  final double min;
  final double max;
  double position;
  final Function(double) onSliderChanged;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: kBarThumbRadius,
        ),
        overlayShape: const RoundSliderOverlayShape(
          overlayRadius: kBarOverlayRadius,
        ),
        activeTrackColor: kColorBarActiveTrack,
        inactiveTrackColor: kColorBarInactiveTrack,
        overlayColor: kColorBarOverlay,
        thumbColor: kColorBarThumb,
      ),
      child: Slider(
        value: position.toDouble(),
        min: min.toDouble(),
        max: max.toDouble(),
        onChanged: (newValue) {
          position = newValue.toDouble();
          onSliderChanged(newValue);
        },
      ),
    );
  }
}
