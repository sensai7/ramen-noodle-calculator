// ignore_for_file: avoid_print

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class DropdownRow extends StatelessWidget {
  const DropdownRow({
    Key? key,
    required this.flourList,
    required this.itemList,
    required this.index,
    required this.header,
    required this.onDropdownChange,
  }) : super(key: key);

  final dynamic flourList;
  final List<DropdownMenuItem<String>> itemList;
  final int index;
  final String header;
  final Function(List) onDropdownChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 16),
        Expanded(flex: 1, child: Text(header, style: kLabelTextStyle)),
        const SizedBox(width: 5),
        Expanded(
          flex: 4,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              value: flourList[index]["name"].toString(),
              items: itemList,
              onChanged: (value) {
                print(header + " -> " + value!);
                int index = flourList.indexWhere((map) => map['name'] == value);
                onDropdownChange([header, index]);
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
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
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
          child: Text(
            "${flourList[index]["protein"]}%",
            style: kLabelTextStyle,
          ),
        ),
        //const SizedBox(width: 10),
      ],
    );
  }
}
