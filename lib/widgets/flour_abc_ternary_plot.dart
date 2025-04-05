import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_2d_slider/main.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card.dart';

import '../constants.dart';

class FlourABCTernaryPlot extends StatelessWidget {
  const FlourABCTernaryPlot({
    Key? key,
    required this.visible,
    required this.flourPercentages,
    required this.onChanged,
    required this.onTapChange,
    required this.offset,
    required this.ternaryPlotCoordinates,
  }) : super(key: key);

  final bool visible;
  final List<int> flourPercentages;
  final Function(List<dynamic>) onChanged;
  final Offset offset;
  final List<double> ternaryPlotCoordinates;
  final Function(bool) onTapChange;

  List<double> calculateTernary(xNorm, yNorm) {
    double a = 2 * yNorm / sqrt(3);
    double c = xNorm - a / 2;
    double b = 1 - a - c;
    return [a, b, c];
  }

  @override
  Widget build(BuildContext context) {
    int flourAPercentage = flourPercentages[0];
    int flourBPercentage = flourPercentages[1];
    int flourCPercentage = flourPercentages[2];
    double X = ternaryPlotCoordinates[0];
    double Y = ternaryPlotCoordinates[1];

    return Visibility(
      visible: visible,
      child: ReusableCard(
        backgroundColor: kColorInactiveBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            const Text("FLOUR A", style: kLabelTextStyle),
            Row(
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(flourAPercentage.toString(), style: kNumberTextStyle),
                const Text("%", style: kLabelTextStyle),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover, image: AssetImage('images/semiblank.png')),
              ),
              width: kTernaryPlotWidth,
              height: kTernaryPlotHeight,
              child: Slider2D(
                offset: offset,
                onChange: (inputOffset) {
                  bool isInside = false;
                  double x = inputOffset.dx;
                  double y = inputOffset.dy;
                  if (x >= (kTernaryPlotWidth / 2 - y / sqrt(3)) && x <= (kTernaryPlotWidth / 2 + y / sqrt(3))) {
                    isInside = true;
                  }
                  Offset newOffset = inputOffset;
                  if (isInside) {
                    X = inputOffset.dx;
                    Y = inputOffset.dy;
                    double xNorm = X / kTernaryPlotWidth;
                    Y = kTernaryPlotHeight - Y;
                    double yNorm = Y / kTernaryPlotWidth;
                    List<double> ternaryPoints = calculateTernary(xNorm, yNorm);
                    flourAPercentage = (ternaryPoints[0] * 100).round();
                    flourBPercentage = (ternaryPoints[1] * 100).round();
                    flourCPercentage = 100 - flourAPercentage - flourBPercentage;
                  } else {
                    double newX;
                    if (inputOffset.dx < kTernaryPlotWidth / 2) {
                      //left
                      newX = (kTernaryPlotHeight - inputOffset.dy) / sqrt(3);
                    } else {
                      //right
                      newX = kTernaryPlotWidth - (kTernaryPlotHeight - inputOffset.dy) / sqrt(3);
                    }
                    newOffset = Offset(newX, inputOffset.dy);
                    //offset = newOffset;
                    X = newOffset.dx;
                    Y = newOffset.dy;
                    double xNorm = X / kTernaryPlotWidth;
                    Y = kTernaryPlotHeight - Y;
                    double yNorm = Y / kTernaryPlotWidth;

                    List<double> ternaryPoints = calculateTernary(xNorm, yNorm);
                    flourAPercentage = (ternaryPoints[0] * 100).round();
                    flourBPercentage = (ternaryPoints[1] * 100).round();
                    flourCPercentage = 100 - flourAPercentage - flourBPercentage;
                  }

                  onChanged([
                    flourAPercentage,
                    flourBPercentage,
                    flourCPercentage,
                    newOffset,
                  ]);
                },
                thumbSize: 35,
                thumbWidget: Listener(
                  onPointerDown: (_) {
                    onTapChange(false);
                  },
                  onPointerUp: (_) {
                    onTapChange(true);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kColorSecondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      flourBPercentage.toString(),
                      style: kNumberTextStyle,
                    ),
                    const Text(
                      kBFlourText,
                      style: kLabelTextStyle,
                    ),
                  ],
                ),
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    const Text(
                      kCFlourText + " ",
                      style: kLabelTextStyle,
                    ),
                    Text(
                      flourCPercentage.toString(),
                      style: kNumberTextStyle,
                    ),
                    const Text(
                      "%",
                      style: kLabelTextStyle,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
