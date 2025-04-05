import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card.dart';
import 'package:ramen_noodle_calc/widgets/round_icon_button.dart';
import '../constants.dart';
import 'help_icon.dart';

class PlusMinusCard extends StatelessWidget {
  const PlusMinusCard({
    Key? key,
    required this.title,
    required this.popupID,
    required this.startValue,
    required this.increment,
    required this.max,
    required this.min,
    required this.nDecimals,
    required this.suffix,
    required this.callback,
    this.isTextField = false,
  }) : super(key: key);

  final String title;
  final String popupID;
  final double startValue;
  final double increment;
  final double max;
  final double min;
  final int nDecimals;
  final String suffix;
  final Function callback;
  final bool isTextField;

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    textController.text = startValue.toString();
    textController.selection = TextSelection.collapsed(offset: textController.text.length);
    Column mainBody = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: kLabelTextStyle,
        ),
        isTextField
            ? TextFormField(
                style: kNumberTextStyle,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //initialValue: widget.startValue.toString(),
                controller: textController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: kIsWeb ? 8.0 : 0.0),
                  isDense: true,
                  border: InputBorder.none,
                ),
                minLines: 1,
                maxLines: 1,
                //onEditingComplete: ,
                onChanged: (value) {
                  int intValue = 1;
                  if (value == "") {
                    callback(intValue);
                    textController.text = "1";
                  } else {
                    intValue = int.parse(value);
                    textController.text = intValue.toString();
                  }
                  callback(intValue);
                },
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    nDecimals == 0 ? startValue.toInt().toString() : startValue.toStringAsFixed(nDecimals),
                    style: kNumberTextStyle,
                  ),
                  Text(
                    suffix,
                    style: kLabelTextStyle,
                  ),
                ],
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundIconButton(
              icon: FontAwesomeIcons.minus,
              onPress: () {
                if (startValue > min) {
                  var newValue = startValue - increment;
                  textController.text = newValue.toInt().toString();
                  callback(newValue);
                }
              },
            ),
            const SizedBox(
              width: 8,
            ),
            RoundIconButton(
              icon: FontAwesomeIcons.plus,
              onPress: () {
                if (startValue < max) {
                  var newValue = startValue + increment;
                  textController.text = newValue.toInt().toString();
                  callback(newValue);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );

    if (popupID == "") {
      return ReusableCard(child: mainBody);
    } else {
      return ReusableCard(
        child: Stack(
          children: [
            HelpIcon(
              popupID: popupID,
              isZoomable: false,
            ),
            mainBody,
          ],
        ),
      );
    }
  }
}
