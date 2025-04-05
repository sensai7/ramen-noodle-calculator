import 'package:flutter/material.dart';
import 'package:ramen_noodle_calc/constants.dart';
import 'package:ramen_noodle_calc/widgets/zoomable_image.dart';

class PopupScreen extends StatelessWidget {
  const PopupScreen({
    Key? key,
    required this.info,
    required this.isZoomable,
  }) : super(key: key);

  final Map<String, String> info; // received kPopupIDs[popupID]
  final bool isZoomable;

  Widget generateAdLink(id) {
    if (id == 3) {
      return ElevatedButton(
        child: const Text("RAMEN SUPPLY COMPANY"),
        onPressed: () => openURL(rscURL),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kColorBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kReusableCardRadius),
          topRight: Radius.circular(kReusableCardRadius),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            isZoomable ? ZoomableImage(imageURL: info["imgRoute"]!) : Image(image: AssetImage(info["imgRoute"]!)),
            const SizedBox(height: 15),
            Text(info["description"]!, style: kPopupBodyTextStyle),
            const SizedBox(height: 15),
            Text(info["footer"]!, style: kPopupFooterTextStyle),
            const SizedBox(height: 15),
            // generateAdLink(infoID),
          ],
        ),
      ),
    );
  }
}
