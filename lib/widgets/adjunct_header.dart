import 'package:flutter/material.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card.dart';
import 'package:ramen_noodle_calc/widgets/adjunct_card.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card_title.dart';
import '../constants.dart';
import 'help_icon.dart';

class AdjunctPanel extends StatelessWidget {
  const AdjunctPanel({
    Key? key,
    required this.adjunctPercentages,
    required this.adjunctIndexes,
    required this.adjunctNumber,
    required this.onSliderChanged,
    required this.onDropdownChanged,
    required this.onButtonPressed,
    required this.onDeleted,
  }) : super(key: key);

  final List<double> adjunctPercentages;
  final List<int> adjunctIndexes;
  final int adjunctNumber;
  final Function(List) onSliderChanged;
  final Function(List) onDropdownChanged;
  final VoidCallback onButtonPressed;
  final Function(int) onDeleted;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      child: Stack(
        children: [
          const HelpIcon(
            popupID: kAdjunctsText,
            isZoomable: false,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const ReusableCardTitle(textContent: kAdjunctsText),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      onButtonPressed();
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kColorButton)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          const Icon(Icons.add, color: Colors.white),
                          const SizedBox(width: 10),
                          Text("Add", style: kLabelTextStyle.copyWith(color: Colors.white)),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
                  // Todo custom adjuncts
                  // const SizedBox(width: 20),
                  // TextButton(
                  //   onPressed: () {},
                  //   style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kColorButton)),
                  //   child: Container(
                  //     margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  //     child: Row(
                  //       children: [
                  //         const SizedBox(width: 20),
                  //         const Icon(Icons.add, color: Colors.white),
                  //         const SizedBox(width: 10),
                  //         Text("Add custom", style: kLabelTextStyle.copyWith(color: Colors.white)),
                  //         const SizedBox(width: 20),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 20),
                  Text("$adjunctNumber/5", style: kLabelTextStyle),
                ],
              ),

              Visibility(
                visible: adjunctNumber > 0,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //SizedBox(width: 8),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: const [
                              SizedBox(width: 36),
                              Text("Adjunct name", style: kLabelTextStyle),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          flex: 1,
                          child: Text("Protein", style: kLabelTextStyle),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          flex: 1,
                          child: Text("Water", style: kLabelTextStyle),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              if (adjunctNumber > 0)
                AdjunctCard(
                  header: 0,
                  amount: adjunctPercentages[0],
                  adjunctIndex: adjunctIndexes[0],
                  onSliderChanged: onSliderChanged,
                  onDropdownChanged: onDropdownChanged,
                  onDeleted: (header) {
                    onDeleted(header);
                  },
                ),
              if (adjunctNumber > 1)
                AdjunctCard(
                  header: 1,
                  amount: adjunctPercentages[1],
                  adjunctIndex: adjunctIndexes[1],
                  onSliderChanged: onSliderChanged,
                  onDropdownChanged: onDropdownChanged,
                  onDeleted: (header) {
                    onDeleted(header);
                  },
                ),
              if (adjunctNumber > 2)
                AdjunctCard(
                  header: 2,
                  amount: adjunctPercentages[2],
                  adjunctIndex: adjunctIndexes[2],
                  onSliderChanged: onSliderChanged,
                  onDropdownChanged: onDropdownChanged,
                  onDeleted: (header) {
                    onDeleted(header);
                  },
                ),
              if (adjunctNumber > 3)
                AdjunctCard(
                  header: 3,
                  amount: adjunctPercentages[3],
                  adjunctIndex: adjunctIndexes[3],
                  onSliderChanged: onSliderChanged,
                  onDropdownChanged: onDropdownChanged,
                  onDeleted: (header) {
                    onDeleted(header);
                  },
                ),
              if (adjunctNumber > 4)
                AdjunctCard(
                  header: 4,
                  amount: adjunctPercentages[4],
                  adjunctIndex: 4,
                  onSliderChanged: onSliderChanged,
                  onDropdownChanged: onDropdownChanged,
                  onDeleted: (header) {
                    onDeleted(header);
                  },
                ),

              // const AdjunctCard(),
              const SizedBox(height: 8.0),
            ],
          ),
        ],
      ),
    );
  }
}
