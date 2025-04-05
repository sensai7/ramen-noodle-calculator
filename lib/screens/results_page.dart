import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ramen_noodle_calc/controllers/calculator_brain.dart';
import 'package:ramen_noodle_calc/widgets/cut_result_row.dart';
import '../constants.dart';
import 'package:flutter/material.dart';
import '../widgets/adjunct_result_row.dart';
import '../widgets/bottom_button.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/multi_result_row.dart';
import '../widgets/result_row.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage({Key? key, required this.brain}) : super(key: key);

  final CalculatorBrain brain;
  final GlobalKey _globalKey = GlobalKey();

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    if (kDebugMode) print(info);
  }

  _saveScreen(context, name) async {
    String fileName;

    if (name == "") {
      fileName = "NoodleCalc_" + DateTime.now().millisecondsSinceEpoch.toString();
    } else {
      fileName = name.replaceAllMapped(RegExp(r'[\<|\>|\:|\"|\/|\\|\||\?|\*]'), (match) {
        return ' ';
      });
    }

    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 2.5); //default is 1 and it's crappy quality
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png)); //error here
    if (byteData != null) {
      final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List(),
          quality: 100, //default is 80 and it's crappy too
          name: "$fileName.png");
      if (result["isSuccess"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Screenshot saved to gallery."),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Screenshot couldn't be saved.\nError msg: ${result.errorMessage}"),
        ));
      }
      if (kDebugMode) {
        print(result);
      }
    }
  }

  String num2Ramen(int rations) {
    String result = "";

    for (var i = 0; i < rations; i++) {
      result = result + "🍜 ";
    }
    return result;
  }

  nonZero(List list) {
    for (var item in list) {
      if (item > 0.0) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> brainMap = brain.map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorSecondary,
        centerTitle: true,
        title: const Text(
          kTitle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: RepaintBoundary(
              key: _globalKey,
              child: Container(
                margin: const EdgeInsets.all(kReusableCardMargin),
                decoration: BoxDecoration(
                  color: kColorInactiveBackground,
                  borderRadius: BorderRadius.circular(kReusableCardRadius),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      brainMap["name"] != ""
                          ? Text(brainMap["name"], style: kResultTextStyle)
                          : const Text("Ingredient weights:", style: kResultTextStyle),
                      MultiResultRow(
                        icon: FontAwesomeIcons.jarWheat,
                        decimalPlaces: 0,
                        name: "FLOUR A",
                        percentage: brainMap["flourAPercentage"].toDouble(),
                        resultNumber: brainMap["flourAGrams"],
                        flourName: brainMap["flourAName"],
                        suffix: '',
                        percentageDecimalPlaces: 0,
                      ),
                      if (brainMap["flourSelected"] > 0)
                        MultiResultRow(
                          icon: FontAwesomeIcons.jarWheat,
                          decimalPlaces: 0,
                          suffix: '',
                          name: "FLOUR B",
                          percentage: brainMap["flourBPercentage"].toDouble(),
                          resultNumber: brainMap["flourBGrams"],
                          flourName: brainMap["flourBName"],
                          percentageDecimalPlaces: 0,
                        ),
                      if (brainMap["flourSelected"] > 1)
                        MultiResultRow(
                          icon: FontAwesomeIcons.jarWheat,
                          decimalPlaces: 0,
                          suffix: '',
                          name: "FLOUR C",
                          percentage: brainMap["flourCPercentage"].toDouble(),
                          resultNumber: brainMap["flourCGrams"],
                          flourName: brainMap["flourCName"],
                          percentageDecimalPlaces: 0,
                        ),
                      // ResultRow(
                      //   icon: FontAwesomeIcons.link,
                      //   decimalPlaces: 3,
                      //   name: "PROTEIN",
                      //   resultNumber: brainMap["proteinPercentage"],
                      //   suffix: "%",
                      // ),
                      MultiResultRow(
                        percentage: brainMap["proteinPercentage"],
                        icon: FontAwesomeIcons.link,
                        decimalPlaces: 1,
                        percentageDecimalPlaces: 3,
                        name: "PROTEIN",
                        resultNumber: brainMap["proteinGrams"] / brainMap["portions"],
                        flourName: 'Including water: ${brainMap["wetProteinPercentage"].toStringAsFixed(3)}%',
                        suffix: " / portion",
                      ),

                      MultiResultRow(
                        icon: FontAwesomeIcons.glassWaterDroplet,
                        decimalPlaces: 0,
                        name: "WATER",
                        resultNumber: brainMap["waterGrams"],
                        percentage: double.parse(brainMap["hydration"].toString()),
                        flourName: brainMap["waterAdjusted"] ? "Water adjusted due to wet adjuncts" : "",
                        suffix: '',
                        percentageDecimalPlaces: 0,
                      ),
                      MultiResultRow(
                        icon: FontAwesomeIcons.shareNodes,
                        percentageDecimalPlaces: 1,
                        decimalPlaces: 2,
                        name: "KANSUI",
                        suffix: '',
                        percentage: brainMap["kansuiPercentage"],
                        resultNumber: brainMap["kansuiGrams"],
                        flourName: "Na (" +
                            brainMap['sodiumPercentage'].toStringAsFixed(0) +
                            "%): " +
                            brainMap['kansuiSodiumGrams'].toStringAsFixed(2) +
                            "g" +
                            " — K (" +
                            (100 - brainMap['sodiumPercentage']).toStringAsFixed(0) +
                            "%): " +
                            (brainMap['kansuiGrams'] - brainMap['kansuiSodiumGrams']).toStringAsFixed(2) +
                            "g",
                      ),
                      ResultRow(
                        icon: FontAwesomeIcons.gripVertical,
                        decimalPlaces: 2,
                        name: "SALT (" + (brainMap["saltPercentage"].toStringAsFixed(1) + "%)"),
                        resultNumber: brainMap["saltGrams"],
                        suffix: "g",
                      ),
                      if (brainMap["nAdjuncts"] > 0)
                        AdjunctResultRow(
                          nameList: brainMap["adjunctNameList"],
                          gramsList: brainMap["adjunctGramList"],
                          percentagesList: brainMap["adjunctPercentageList"],
                        ),
                      CutResultRow(
                        cutterIndex: brainMap["cutSizeIndex"],
                        shapeIndex: brainMap["cutShapeIndex"],
                        icon: FontAwesomeIcons.scissors,
                      ),
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            brainMap["weight"].toString() + "g x",
                            style: kResultTextStyle,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          brainMap["portions"] <= 60
                              ? Flexible(
                                  child: Text(
                                    num2Ramen(brainMap["portions"]),
                                    style: TextStyle(fontSize: (30 - (brainMap["portions"]) / 3).toDouble()),
                                  ),
                                )
                              : Text(
                                  "${brainMap["portions"]} portions.",
                                  style: kResultTextStyle,
                                )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          kIsWeb
              ? BottomButton(
                  topMargin: kButtonTopMargin,
                  string: "RE-CALCULATE",
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              : BottomButton(
                  topMargin: kButtonTopMargin,
                  string: "SAVE SCREENSHOT",
                  onTap: () {
                    _requestPermission();
                    _saveScreen(context, brainMap["name"]);
                  },
                ),
        ],
      ),
    );
  }
}
