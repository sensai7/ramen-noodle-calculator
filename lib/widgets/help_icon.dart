import 'package:flutter/material.dart';
import 'package:ramen_noodle_calc/constants.dart';
import 'package:ramen_noodle_calc/widgets/popup_screen.dart';

class HelpIcon extends StatelessWidget {
  const HelpIcon({
    Key? key,
    required this.popupID,
    required this.isZoomable,
  }) : super(key: key);

  final String popupID;
  final bool isZoomable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (popupID != "") {
          showModalBottomSheet(
            isScrollControlled: true, //adjusts height to children size
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kReusableCardRadius),
                topRight: Radius.circular(kReusableCardRadius),
              ),
            ),
            context: context,
            builder: (context) => PopupScreen(
              info: kPopups[popupID]!,
              isZoomable: isZoomable,
            ),
          );
          //getPopup(context, kPopupIDs[popupID]).show();
        }
      },
      child: Row(
        children: const [
          SizedBox(width: 16),
          MouseRegion(cursor: SystemMouseCursors.click, child: Text('ⓘ', style: kLabelTextStyle)),
        ],
      ),
    );
  }
}
