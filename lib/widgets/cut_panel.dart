import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card_title.dart';
import 'package:ramen_noodle_calc/painters/trapezoid_painter.dart';

import '../constants.dart';
import '../cut.dart';
import 'help_icon.dart';

class CutPanel extends StatelessWidget {
  const CutPanel({
    Key? key,
    required this.sizeIndex,
    required this.shapeIndex,
    required this.onDropdownChanged,
  }) : super(key: key);

  final int sizeIndex;
  final int shapeIndex;
  final Function(List) onDropdownChanged;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> itemsSize = [];
    List<DropdownMenuItem<String>> itemsShape = [];

    for (int i = 0; i < kCutSizeList.length; i++) {
      DropdownMenuItem<String> item = DropdownMenuItem(
          child: SizedBox(
            child: Text(
              kCutSizeList[i]["name"],
              style: kLabelTextStyle,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 2,
            ),
          ),
          value: kCutSizeList[i]["name"]);
      itemsSize.add(item);
    }

    for (int i = 0; i < kCutShapeList.length; i++) {
      DropdownMenuItem<String> item = DropdownMenuItem(
          child: SizedBox(
            child: Text(
              kCutShapeList[i],
              style: kLabelTextStyle,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 2,
            ),
          ),
          value: kCutShapeList[i]);
      itemsShape.add(item);
    }

    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final heightInLogicalPixels = kCutSizeList[sizeIndex]["size"] * devicePixelRatio;

    return ReusableCard(
      child: Stack(children: [
        const HelpIcon(
          popupID: kCuttingText,
          isZoomable: false,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const ReusableCardTitle(textContent: kCuttingText),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 16),
                const Expanded(flex: 1, child: Text("Size", style: kLabelTextStyle)),
                const SizedBox(width: 5),
                Expanded(
                  flex: 4,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      value: kCutSizeList[sizeIndex]["name"].toString(),
                      items: itemsSize,
                      onChanged: (newValue) {
                        if (kDebugMode) print("Change in noodle size" " -> " + newValue!);
                        int index = kCutSizeList.indexWhere((map) => map['name'] == newValue);
                        onDropdownChanged(["Size", index]);
                      },
                      icon: const Icon(Icons.arrow_forward_ios_outlined),
                      iconOnClick: const Icon(Icons.arrow_downward_outlined),
                      itemHighlightColor: kSelectedColor,
                      itemSplashColor: kColorSecondary,
                      iconSize: 14,
                      iconEnabledColor: kColorSecondary,
                      iconDisabledColor: Colors.grey,
                      barrierColor: const Color.fromARGB(40, 0, 0, 0),
                      buttonHeight: 45,
                      buttonPadding: const EdgeInsets.only(left: 4, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: kSelectedColor,
                      ),
                      buttonElevation: 0,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 300,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: kColorInactiveBackground,
                      ),
                      dropdownElevation: 3,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: kColorText,
                    height: heightInLogicalPixels,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 16),
                const Expanded(flex: 1, child: Text("Shape", style: kLabelTextStyle)),
                const SizedBox(width: 5),
                Expanded(
                  flex: 4,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      value: kCutShapeList[shapeIndex].toString(),
                      items: itemsShape,
                      onChanged: (newValue) {
                        if (kDebugMode) print("Change in noodle shape" " -> " + newValue!);
                        int index = kCutShapeList.indexOf(newValue!);
                        onDropdownChanged(["Shape", index]);
                      },
                      icon: const Icon(Icons.arrow_forward_ios_outlined),
                      iconOnClick: const Icon(Icons.arrow_downward_outlined),
                      itemHighlightColor: kSelectedColor,
                      itemSplashColor: kColorSecondary,
                      iconSize: 14,
                      iconEnabledColor: kColorSecondary,
                      iconDisabledColor: Colors.grey,
                      barrierColor: const Color.fromARGB(40, 0, 0, 0),
                      buttonHeight: 45,
                      buttonPadding: const EdgeInsets.only(left: 4, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: kSelectedColor,
                      ),
                      buttonElevation: 0,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 300,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: kColorInactiveBackground,
                      ),
                      dropdownElevation: 3,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: FractionallySizedBox(
                    widthFactor: 0.2,
                    //child: Image(image: AssetImage("images/square.png")),
                    child: shapeIndex == 0
                        ? Container(
                            height: 30,
                            width: 30,
                            color: kColorText,
                          )
                        : shapeIndex == 1
                            ? SizedBox(
                                width: 50,
                                height: 30,
                                child: ClipOval(
                                  child: Container(
                                    color: kColorText,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 30,
                                height: 30,
                                child: CustomPaint(
                                  painter: TrapezoidPainter(),
                                ),
                              ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
