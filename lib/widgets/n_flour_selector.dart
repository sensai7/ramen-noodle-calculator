// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../constants.dart';

class NFlourSelector extends StatelessWidget {
  const NFlourSelector({
    Key? key,
    required this.isSelected,
    required this.flourSelectorChanged,
  }) : super(key: key);

  final List<bool> isSelected;
  final Function(List) flourSelectorChanged;

  // output contains in order [selectedIndex, flourAPercentage, flourBPercentage, flourCPercentage]

  List flourSelector(int selectedIndex) {
    int flourAPercentage = 0;
    int flourBPercentage = 0;
    int flourCPercentage = 0;
    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
      if (buttonIndex == selectedIndex) {
        isSelected[buttonIndex] = true;
      } else {
        isSelected[buttonIndex] = false;
      }
    }
    if (isSelected[0]) {
      print("1 flour selected");
      flourAPercentage = 100;
      flourBPercentage = 0;
      flourCPercentage = 0;
    } else if (isSelected[1]) {
      print("2 flours selected");
      flourAPercentage = 50;
      flourBPercentage = 50;
      flourCPercentage = 0;
    } else if (isSelected[2]) {
      print("3 flours selected");
      flourAPercentage = 33;
      flourBPercentage = 33;
      flourCPercentage = 33;
    }
    return [selectedIndex, flourAPercentage, flourBPercentage, flourCPercentage];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          // const HelpIcon(popupID: kFlourMixText),
          const SizedBox(width: 10),
          const Text("Number of flours: ", style: kLabelTextStyle),
          const SizedBox(width: 20),
          ToggleButtonsTheme(
            data: kToggleButtonThemeData,
            child: ToggleButtons(
              children: const <Widget>[
                Text("1", style: kLabelTextStyle),
                Text("2", style: kLabelTextStyle),
                Text("3", style: kLabelTextStyle),
              ],
              onPressed: (index) {
                //print("index ${index}\n ${flourSelector(index)}");

                flourSelectorChanged(flourSelector(index));
              },
              isSelected: isSelected,
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import '../constants.dart';
//
// class NFlourSelector extends StatelessWidget {
//   const NFlourSelector({
//     Key? key,
//     required this.isSelected,
//     required this.flourSelectorChanged,
//   }) : super(key: key);
//
//   final List<bool> isSelected;
//   final Function(List) flourSelectorChanged;
//
//   // output contains in order [selectedIndex, flourAPercentage, flourBPercentage, flourCPercentage]
//
//   List flourSelector(int selectedIndex) {
//     List<int> flourPercentages = List<int>.filled(kMaxFlours, 0);
//
//     for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
//       if (buttonIndex == selectedIndex) {
//         isSelected[buttonIndex] = true;
//       } else {
//         isSelected[buttonIndex] = false;
//       }
//     }
//
// //     zerosList[0] = 100; // Change the first element to 100
// //
// // // Set all other elements to 0
// //     for (int i = 1; i < zerosList.length; i++) {
// //       zerosList[i] = 0;
// //     }
// //
//
//     if (isSelected[0]) {
//       if (kDebugMode) {
//         print("1 flour selected");
//       }
//       flourPercentages[0] = 100;
//       flourPercentages[1] = 0;
//       flourPercentages[0] = 0;
//       flourPercentages[0] = 0;
//     } else if (isSelected[1]) {
//       if (kDebugMode) {
//         print("2 flours selected");
//       }
//       flourAPercentage = 50;
//       flourBPercentage = 50;
//       flourCPercentage = 0;
//       flourDPercentage = 0;
//     } else {
//       if (kDebugMode) {
//         print("3/4 flours selected");
//       }
//       flourAPercentage = 33;
//       flourBPercentage = 33;
//       flourCPercentage = 33;
//       flourDPercentage = 0;
//     }
//     return [selectedIndex, flourAPercentage, flourBPercentage, flourCPercentage, flourDPercentage];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.baseline,
//         textBaseline: TextBaseline.alphabetic,
//         children: [
//           // const HelpIcon(popupID: kFlourMixText),
//           const SizedBox(width: 10),
//           const Text("Number of flours: ", style: kLabelTextStyle),
//           const SizedBox(width: 20),
//           ToggleButtonsTheme(
//             data: kToggleButtonThemeData,
//             child: ToggleButtons(
//               children: const <Widget>[
//                 Text("1", style: kLabelTextStyle),
//                 Text("2", style: kLabelTextStyle),
//                 Text("3", style: kLabelTextStyle),
//                 Text("4", style: kLabelTextStyle),
//               ],
//               onPressed: (index) {
//                 flourSelectorChanged(flourSelector(index));
//               },
//               isSelected: isSelected,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
