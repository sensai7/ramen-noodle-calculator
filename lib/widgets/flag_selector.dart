// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../constants.dart';
import '../flour.dart';

class FlagSelector extends StatelessWidget {
  const FlagSelector({
    Key? key,
    required this.isFlagSelected,
    required this.onFlagChange,
  }) : super(key: key);

  final List<bool> isFlagSelected;
  final Function(List) onFlagChange;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtonsTheme(
        data: kToggleButtonThemeData,
        child: ToggleButtons(
          isSelected: isFlagSelected,
          children: const <Widget>[
            Text("✳", style: kLabelTextStyle),
            Text("🇮🇹", style: kLabelTextStyle),
            Text("🇪🇸", style: kLabelTextStyle),
            Text("🇩🇪", style: kLabelTextStyle),
            Text("🇦🇹", style: kLabelTextStyle),
            Text("🇺🇸", style: kLabelTextStyle),
            Text("🇯🇵", style: kLabelTextStyle),
          ],
          onPressed: (int index) {
            dynamic newFlourList;
            newFlourList = flagPositionToList(index);
            onFlagChange([index, newFlourList]);
          },
        ),
      ),
    );
  }
}
