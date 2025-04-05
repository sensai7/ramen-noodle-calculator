import 'package:flutter/material.dart';
import 'package:ramen_noodle_calc/cut.dart';
import '../constants.dart';
import '../painters/trapezoid_painter.dart';

class CutResultRow extends StatelessWidget {
  const CutResultRow({
    Key? key,
    required this.cutterIndex,
    required this.shapeIndex,
    required this.icon,
  }) : super(key: key);

  final IconData icon;
  final int cutterIndex;
  final int shapeIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 30, color: kColorText),
            const SizedBox(width: 10),
            Row(
              children: [
                Text(
                  "CUTTER: ${kCutSizeList[cutterIndex]["name"]}",
                  style: kResultTextStyle,
                ),
                const SizedBox(width: 20),
                shapeIndex == 0
                    ? Container(
                        height: 30,
                        width: 30,
                        color: kColorText,
                      )
                    : shapeIndex == 1
                        ? SizedBox(
                            width: 25,
                            height: 30,
                            child: ClipOval(
                              child: Container(
                                color: kColorText,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 35,
                            height: 30,
                            child: CustomPaint(
                              painter: TrapezoidPainter(),
                            ),
                          ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
