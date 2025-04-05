import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card_slider.dart';

import '../adjuncts.dart';
import '../constants.dart';

class AdjunctCard extends StatelessWidget {
  const AdjunctCard({
    Key? key,
    required this.amount,
    required this.adjunctIndex,
    required this.onDropdownChanged,
    required this.onSliderChanged,
    required this.onDeleted,
    required this.header,
  }) : super(key: key);

  final double amount;
  final int adjunctIndex;
  final Function(List) onSliderChanged;
  final Function(List) onDropdownChanged;
  final Function(int) onDeleted;
  final int header; //which adjunct it is 0~4

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> items = [];

    for (int i = 0; i < adjunctList.length; i++) {
      DropdownMenuItem<String> item = DropdownMenuItem(
          child: SizedBox(
            child: Text(
              adjunctList[i]["name"],
              style: kLabelTextStyle,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 2,
            ),
          ),
          value: adjunctList[i]["name"]);
      items.add(item);
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  value: adjunctList[adjunctIndex]["name"].toString(),
                  items: items,
                  onChanged: (newValue) {
                    if (kDebugMode) print("Adjunct change in position $header" " -> " + newValue!);
                    int index = adjunctList.indexWhere((map) => map['name'] == newValue);
                    onDropdownChanged([header, index]);
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
              flex: 1,
              child: Text(adjunctList[adjunctIndex]["protein"].toString(), style: kLabelTextStyle),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Text(adjunctList[adjunctIndex]["water"].toString(), style: kLabelTextStyle),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 36),
            Row(
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(amount.toStringAsFixed(1), style: kNumberTextStyle),
                const Text("%", style: kLabelTextStyle),
              ],
            ),
            const SizedBox(width: 4),
            Expanded(
              flex: 4,
              child: ReusableCardDoubleSlider(
                  min: 0.1,
                  max: 10,
                  position: amount,
                  onSliderChanged: (newValue) {
                    newValue = double.parse(newValue.toStringAsFixed(1));
                    if (kDebugMode) print("New value in adjunct [$header]: $newValue");
                    onSliderChanged([header, newValue]);
                  }),
            ),
            IconButton(
              onPressed: () {
                onDeleted(header);
              },
              icon: const Icon(
                FontAwesomeIcons.trash,
                color: kColorSecondary,
              ),
              splashColor: kColorSecondary,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ],
    );
  }
}
