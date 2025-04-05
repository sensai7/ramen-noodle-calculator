import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/calculator_brain.dart';
import '../controllers/database_helper.dart';
import '../controllers/noodle.dart';
import '../screens/results_page.dart';
import '../widgets/adjunct_header.dart';
import '../widgets/cut_panel.dart';
import '../widgets/flour_panel.dart';
import '../widgets/hydration_card.dart';
import '../widgets/kansui_card.dart';
import '../widgets/bottom_button.dart';
import '../widgets/name_card.dart';
import '../widgets/plus_minus_x4_cards.dart';
import '../widgets/protein_meter.dart';
import '../widgets/top_menu_button.dart';
import '../constants.dart';
import '../flour.dart';
// import 'dart:html'; // fixme uncomment for web

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  late Noodle noodle; // initialized in initState() or setLoaded()
  dynamic flourList;
  bool scrollable = true;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  double ternaryPlotX = kTernaryStartX;
  double ternaryPlotY = kTernaryStartY;

  void setDefault() {
    noodle = Noodle();
    ternaryPlotX = kTernaryStartX;
    ternaryPlotY = kTernaryStartY;
    textController.text = "";
    flourList = getAllFlourNames();
  }

  void setLoaded(Noodle loadedNoodle) {
    noodle = loadedNoodle;
    ternaryPlotX = (noodle.flourCPercentage + noodle.flourAPercentage / 2) * 3;
    ternaryPlotY = noodle.flourAPercentage / 100 * kTernaryPlotHeight;
    textController.text = loadedNoodle.name;
    flourList = flagPositionToList(noodle.flourFlagPosition);
    scrollController.jumpTo(0);
  }

  @override
  void initState() {
    if (!kIsWeb) {
      WidgetsFlutterBinding.ensureInitialized();
      NoodleDbProvider noodleDb = NoodleDbProvider();
      noodleDb.factoryReset();
      setDefault();
    } else {
      // fixme uncomment for web build
      // if (kDebugMode) print("URL: " + window.location.href);
      // final Uri? uri = Uri.tryParse(window.location.href);
      // if (uri != null) {
      //   String? param1 = uri.queryParameters['name'];
      //   String? param2 = uri.queryParameters['params'];
      //   if (param1 != null && param2 != null) {
      //     if (kDebugMode) print("param1: " + param1);
      //     if (kDebugMode) print("param2: " + param2);
      //     param2 = param2.replaceAll("#", "").replaceAll("/", "");
      //     var noodleAndFlagAndName = url2Noodle(param2, param1);
      //     noodle = noodleAndFlagAndName[0];
      //     flourList = flagPositionToList(noodleAndFlagAndName[1]);
      //     ternaryPlotX = (noodle.flourCPercentage + noodle.flourAPercentage / 2) * 3;
      //     ternaryPlotY = noodle.flourAPercentage / 100 * kTernaryPlotHeight;
      //     textController.text = noodleAndFlagAndName[2];
      //   } else {
      //     if (kDebugMode) print("URL doesn't have params");
      //     setDefault();
      //   }
      // }
      // fixme uncomment until here
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(kTitle, style: kAppbarTextStyle),
        actions: <Widget>[
          TopMenuButton(
              noodle: noodle,
              setDefaultCallback: () {
                setState(() {
                  setDefault();
                });
              },
              loadNoodleCallback: (loadNoodle) {
                setState(() {
                  setLoaded(loadNoodle);
                });
              })
        ],
      ),
      body: ListView(
        controller: scrollController,
        physics: scrollable ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
        children: <Widget>[
          NamePanel(
            onChanged: (newName) {
              noodle.name = newName;
              if (kDebugMode) print("Name changed to: " + noodle.name);
            },
            controller: textController,
            savedNoodle: noodle,
          ),
          HydrationPanel(
            hydration: noodle.hydration,
            onSliderChanged: (newHydration) {
              setState(() {
                noodle.hydration = newHydration.toInt();
                if (kDebugMode) print("New hydration: " + newHydration.toString());
              });
            },
          ),
          FlourPanel(
            noodle: noodle,
            flourList: flourList,
            ternaryPlotCoordinates: [ternaryPlotX, ternaryPlotY],
            onChangeFlourSelector: (callbackOutput) {
              setState(() {
                noodle.flourSelectedPosition = callbackOutput[0];
                noodle.flourAPercentage = callbackOutput[1];
                noodle.flourBPercentage = callbackOutput[2];
                noodle.flourCPercentage = callbackOutput[3];
                noodle.getProtein(flourList);
              });
            },
            onChangeFlag: (outputList) {
              setState(() {
                noodle.flourAIndex = 0;
                noodle.flourBIndex = 1;
                noodle.flourCIndex = 2;
                noodle.flourFlagPosition = outputList[0];
                flourList = outputList[1];
                noodle.getProtein(flourList);
              });
              if (kDebugMode) print(flourList.length.toString() + " flours loaded");
            },
            onChangeDropdown: (idAndIndex) {
              setState(() {
                String changeId = idAndIndex[0];
                if (changeId == "Flour A") {
                  noodle.flourAIndex = idAndIndex[1];
                } else if (changeId == "Flour B") {
                  noodle.flourBIndex = idAndIndex[1];
                } else if (changeId == "Flour C") {
                  noodle.flourCIndex = idAndIndex[1];
                }
                noodle.getProtein(flourList);
              });
            },
            onChangeSlider: (newValue) {
              setState(() {
                noodle.flourAPercentage = newValue.toInt();
                noodle.flourBPercentage = 100 - noodle.flourAPercentage;
                noodle.getProtein(flourList);
              });
            },
            onChangeTernary: (floursAndOffset) {
              setState(() {
                noodle.flourAPercentage = floursAndOffset[0];
                noodle.flourBPercentage = floursAndOffset[1];
                noodle.flourCPercentage = floursAndOffset[2];
                noodle.getProtein(flourList);
                ternaryPlotX = floursAndOffset[3].dx;
                ternaryPlotY = floursAndOffset[3].dy;
              });
            },
            onTapTernary: (allowScroll) {
              setState(() {
                scrollable = allowScroll; // sin setstate no funciona como deberia.
              });
            },
          ),
          ProteinPanel(protein: noodle.proteinPercentage),
          AdjunctPanel(
            adjunctIndexes: noodle.adjunctIndexes,
            adjunctPercentages: noodle.adjunctPercentages,
            adjunctNumber: noodle.adjunctNumber,
            onDropdownChanged: (headerAndIndex) {
              setState(() {
                noodle.changeAdjunctIndex(headerAndIndex[0], headerAndIndex[1]);
                noodle.getProtein(flourList);
              });
            },
            onSliderChanged: (headerAndValue) {
              setState(() {
                noodle.changeAdjunctPercentage(headerAndValue[0], headerAndValue[1]);
                noodle.getProtein(flourList);
              });
            },
            onButtonPressed: () {
              setState(() {
                noodle.addAdjunct();
                noodle.getProtein(flourList);
              });
            },
            onDeleted: (header) {
              setState(() {
                noodle.deleteAdjunct(header);
                noodle.getProtein(flourList);
              });
            },
          ),
          PlusMinusX4Panel(
            portions: noodle.portions,
            weight: noodle.weight,
            kansui: noodle.kansui,
            salt: noodle.salt,
            onAnythingChanged: (idAndAmount) {
              setState(() {
                if (idAndAmount[0] == "portions") {
                  noodle.portions = idAndAmount[1].toInt();
                  if (kDebugMode) print("New portions: " + idAndAmount[1].toString());
                } else if (idAndAmount[0] == "weight") {
                  noodle.weight = idAndAmount[1].toInt();
                  if (kDebugMode) print("New weight: " + idAndAmount[1].toString());
                } else if (idAndAmount[0] == "kansui") {
                  noodle.kansui = idAndAmount[1];
                  if (kDebugMode) print("New kansui %: " + idAndAmount[1].toString());
                } else if (idAndAmount[0] == "salt") {
                  noodle.salt = idAndAmount[1];
                  if (kDebugMode) print("New salt %: " + idAndAmount[1].toString());
                }
              });
            },
          ),
          KansuiPanel(
            sodium: noodle.sodium,
            onSliderChanged: (newSodium) {
              setState(() {
                noodle.sodium = newSodium.toInt();
                if (kDebugMode) print("Kansui composition changed to: " + newSodium.toString());
              });
            },
          ),
          CutPanel(
            sizeIndex: noodle.cutSizeIndex,
            shapeIndex: noodle.cutShapeIndex,
            onDropdownChanged: (whichAndIndex) {
              setState(() {
                whichAndIndex[0] == "Size"
                    ? noodle.cutSizeIndex = whichAndIndex[1]
                    : noodle.cutShapeIndex = whichAndIndex[1];
              });
            },
          ),
          BottomButton(
            string: kCalculateText,
            topMargin: kButtonTopMargin,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              CalculatorBrain brain = CalculatorBrain(noodle: noodle, flourList: flourList);
              brain.calculate();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ResultsPage(brain: brain);
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
