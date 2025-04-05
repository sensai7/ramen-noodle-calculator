import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:ramen_noodle_calc/widgets/plus_minus_card.dart';

class PlusMinusX4Panel extends StatelessWidget {
  const PlusMinusX4Panel({
    Key? key,
    required this.portions,
    required this.weight,
    required this.kansui,
    required this.salt,
    required this.onAnythingChanged,
  }) : super(key: key);

  final int portions;
  final int weight;
  final double kansui;
  final double salt;

  final Function(List) onAnythingChanged;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: <Widget>[
          Expanded(
            child: PlusMinusCard(
              title: "PORTIONS",
              suffix: "",
              popupID: "",
              increment: 1,
              min: 1,
              max: 1000,
              nDecimals: 0,
              startValue: portions.toDouble(),
              isTextField: false, //fixme it gets crazy and the value shows as a double
              callback: (newValue) {
                onAnythingChanged(["portions", newValue]);
              },
            ),
          ),
          Expanded(
            child: PlusMinusCard(
              title: "RATION WEIGHT",
              suffix: "g",
              popupID: "",
              increment: 10,
              min: 50,
              max: 500,
              nDecimals: 0,
              startValue: weight.toDouble(),
              callback: (newValue) {
                onAnythingChanged(["weight", newValue]);
              },
            ),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: PlusMinusCard(
              title: "KANSUI",
              suffix: "%",
              popupID: kKansuiText,
              increment: 0.1,
              min: 0.1,
              max: 4.9,
              nDecimals: 1,
              startValue: kansui,
              callback: (newValue) {
                onAnythingChanged(["kansui", newValue]);
              },
            ),
          ),
          Expanded(
            child: PlusMinusCard(
              title: "SALT",
              suffix: "%",
              popupID: kSaltText,
              increment: 0.1,
              min: 0.1,
              max: 4.9,
              nDecimals: 1,
              startValue: salt,
              callback: (newValue) {
                onAnythingChanged(["salt", newValue]);
              },
            ),
          ),
        ],
      ),
    ]);
  }
}
