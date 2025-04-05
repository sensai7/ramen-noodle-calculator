import 'package:flutter/material.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card_title.dart';

import '../constants.dart';
import '../controllers/noodle.dart';
import 'flag_selector.dart';
import 'flour_ab_slider_card.dart';
import 'flour_abc_ternary_plot.dart';
import 'flour_selector.dart';
import 'help_icon.dart';
import 'n_flour_selector.dart';

class FlourPanel extends StatelessWidget {
  const FlourPanel({
    Key? key,
    required this.noodle,
    required this.flourList,
    required this.ternaryPlotCoordinates,
    required this.onChangeFlourSelector,
    required this.onChangeFlag,
    required this.onChangeDropdown,
    required this.onChangeSlider,
    required this.onChangeTernary,
    required this.onTapTernary,
  }) : super(key: key);

  final Noodle noodle;
  final dynamic flourList;
  final List<double> ternaryPlotCoordinates;

  final Function(List) onChangeFlourSelector;
  final Function(List) onChangeFlag;
  final Function(List) onChangeDropdown;
  final Function(double) onChangeSlider;
  final Function(List) onChangeTernary;
  final Function(bool) onTapTernary;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      child: Stack(
        children: [
          const HelpIcon(
            popupID: kFlourMixText,
            isZoomable: false,
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              const ReusableCardTitle(textContent: "FLOUR"),
              NFlourSelector(
                  isSelected: getBoolList(noodle.flourSelectedPosition, kMaxFlours), //* noodle
                  flourSelectorChanged: (callbackOutput) {
                    onChangeFlourSelector(callbackOutput);
                  }),
              FlagSelector(
                isFlagSelected: getBoolList(noodle.flourFlagPosition, kMaxFlags), //* noodle
                onFlagChange: (outputList) {
                  onChangeFlag(outputList);
                },
              ),
              FlourSelector(
                nFlours: noodle.flourSelectedPosition, //* noodle
                flourList: flourList,
                flourAper: noodle.flourAPercentage, //* noodle
                selectedIndexes: [noodle.flourAIndex, noodle.flourBIndex, noodle.flourCIndex], //* noodle
                onDropdownChange: (idAndIndex) {
                  onChangeDropdown(idAndIndex);
                },
              ),
              FlourABSliderCard(
                visible: noodle.flourSelectedPosition == 1, //* noodle
                flourAPercentage: noodle.flourAPercentage, //* noodle
                onSliderChanged: (newValue) {
                  onChangeSlider(newValue);
                },
              ),
              FlourABCTernaryPlot(
                visible: noodle.flourSelectedPosition == 2, //* noodle
                flourPercentages: [
                  noodle.flourAPercentage,
                  noodle.flourBPercentage,
                  noodle.flourCPercentage
                ], //* noodle
                ternaryPlotCoordinates: ternaryPlotCoordinates,
                onChanged: (floursAndOffset) {
                  onChangeTernary(floursAndOffset);
                },
                onTapChange: (allowScroll) {
                  onTapTernary(allowScroll);
                },
                offset: Offset(ternaryPlotCoordinates[0], ternaryPlotCoordinates[1]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
