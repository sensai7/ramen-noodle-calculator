import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const kLabelTextStyle = TextStyle(
  fontSize: 16,
  color: kColorText,
  fontWeight: FontWeight.w600,
);

const kLinkTextStyle = TextStyle(
  fontSize: 16,
  color: Color(0xff4b97ff),
  fontWeight: FontWeight.w600,
);

const kResultTextStyle = TextStyle(
  fontSize: 20,
  color: kColorText,
);

const kNumberTextStyle = TextStyle(
  fontSize: 30,
  color: kColorText,
  fontWeight: FontWeight.w900,
);

const kButtonTextStyle = TextStyle(
  fontSize: 25,
  color: Colors.white,
  fontWeight: FontWeight.w900,
);

const kAppbarTextStyle = TextStyle(
  //fontSize: 25,
  color: Colors.white,
  //fontWeight: FontWeight.w900,
);

const kPopupBodyTextStyle = kLabelTextStyle;
const kPopupFooterTextStyle = TextStyle(
  fontSize: 12,
  color: kColorText,
  fontStyle: FontStyle.italic,
);

const kToggleButtonThemeData = ToggleButtonsThemeData(
  borderRadius: BorderRadius.all(
    Radius.circular(kReusableCardRadius),
  ),
  // borderColor: Colors.transparent,
  // selectedBorderColor: Colors.transparent,
  // borderColor: kColorSecondary,
  // selectedBorderColor: kColorSecondary,
  selectedColor: kColorInactiveBackground,
);

const dotMenuItemsApp = <String>[
  'Default values',
  //'DEBUG: Show brief',
  //'DEBUG: Delete database',
  'Load noodle',
  'About',
  //'DEBUG: Spit noodle'
];

const dotMenuItemsWeb = <String>[
  'Default values',
  'This app in Play Store',
  'About',
];

String bookURL = 'https://docs.google.com/document/d/1qLPoLxek3WLQJDtU6i3300_0nNioqeYXi7vESrtNvjQ/edit';
// String kofiURL = 'https://ko-fi.com/gonya';
String profileUrl = 'https://sensai7.github.io/my-projects/#/';
String rscURL = 'https://ramensupply.co';

Future<void> openURL(String url) async {
  // if (await canLaunchUrl(Uri(path: url))) {
  await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
}

double kTernaryPlotWidth = 300;
double kTernaryPlotHeight = 300 * 0.86602540378;
double kTernaryPlotXNorm = 0;
double kTernaryPlotYNorm = 0;
double kTernaryStartX = kTernaryPlotWidth / 2;
double kTernaryStartY = (kTernaryPlotHeight * 2 / 3);

const double kBottomContainerHeight = 70;
const Color kColorBackground = Color(0xfffff7de);
const Color kColorActiveCard = Color(0xffff9b41);
const Color kColorSecondary = Color(0xffff9b41);
const Color kColorInactiveCard = Color(0x20ff8e00);
const Color kColorInactiveBackground = Color(0xffffeac2);
const Color kColorBarActiveTrack = Color(0xffff9b41);
const Color kColorBarInactiveTrack = Color(0xffff9b41);
const Color kColorBarOverlay = Color(0x30ff9b41);
const Color kColorBarThumb = Color(0xffff9b41);
const Color kColorButton = Color(0xffff9b41);
const Color kColorText = Color(0xFF340606);
const Color kSelectedColor = Color(0xffffe1b2);

const double kButtonTopMargin = 10;
const double kBarThumbRadius = 14;
const double kBarOverlayRadius = 24;
const double kReusableCardMargin = 5;
const double kReusableCardRadius = 10;
const double kIconSize = 60;
const double kIconTobBottomPadding = 5;
const double kPlusMinusCardMinHeight = 134;

const String kTitle = 'RAMEN NOODLE CALCULATOR';
const String kHydrationText = "HYDRATION";
const String kFlourMixText = "FLOUR MIX";
const String kAdjunctsText = "ADJUNCTS";
const String kBreadFlourText = "% BREAD FLOUR";
const String kOtherFlourText = "% OTHER FLOUR";
const String kAFlourText = "% FLOUR A";
const String kBFlourText = "% FLOUR B";
const String kCFlourText = "FLOUR C";
const String kRationsText = "PORTIONS";
const String kProteinText = "PROTEIN";
const String kRationWeightText = "RATION WEIGHT";
const String kKansuiText = "KANSUI";
const String kSaltText = "SALT";
const String kCuttingText = "CUTTER";
const String kCalculateText = "CALCULATE";
const String kKansuiComp = "KANSUI COMPOSITION";
const String kKansuiSodium = "SODIUM";
const String kKansuiPotassium = "POTASSIUM";
const String kNoodleName = 'Noodle name:';
const kMaxFlours = 3;
const kMaxFlags = 7;
const flagDefaultStatus = [true, false, false, false, false, false, false];
const flourSelectedDefaultStatus = [true, false, false];

const int defNRations = 2;
const int defRationGrams = 100;
const int defHydration = 35;
const int defBreadFlourPer = 90;
const double defKansui = 1.0;
const double defSalt = 1.0;
const int defSodium = 40;

const int kAdjunctLimit = 5;
const int kAdjunctsStart = 0;
const List<int> kAdjunctDefaultIndexes = [0, 0, 0, 0, 0];
const List<double> kAdjunctDefaultPercentages = [1.0, 1.0, 1.0, 1.0, 1.0];
const List<bool> kAdjunctDefaultIsOn = [false, false, false, false, false];

const int maxInt = 900712401;

List<bool> getBoolList(int truePosition, int len) {
  List<bool> result = List.filled(len, false);
  for (int buttonIndex = 0; buttonIndex < len; buttonIndex++) {
    if (buttonIndex == truePosition) {
      result[buttonIndex] = true;
      break;
    } else {
      result[buttonIndex] = false;
    }
  }
  return result;
}

const kPopups = {
  kHydrationText: {
    "description": "Ramen noodles are distinct from other doughs in that the amount of water added to them (described"
        " as the “hydration” or “hydration percentage”), is noticeably low. In most ramen applications, hydration spans "
        "anywhere from 22% to 42% the weight of the dry flour solids. By contrast, most bread doughs start at about 60% "
        "hydration.",
    "footer": "From The Ramen_Lord Book of Ramen, p12",
    "imgRoute": "images/water.png",
  },
  kFlourMixText: {
    "description": "Wheat flour is the primary source of starch and protein in all ramen noodles and is a requirement"
        " for ramen to exist. To start, keep it simple; bread flour works very well. I like to use King Arthur bread"
        " flour because the protein content is around 12.7% the weight of the flour, and the flour gives consistent "
        "results. As you get more comfortable, feel free to adjust flours.",
    "footer": "From The Ramen_Lord Book of Ramen, p9",
    "imgRoute": "images/flour.png",
  },
  kKansuiText: {
    "description": "Kansui is a catchall term for the alkaline salts used to increase the pH of the water and impact "
        "the gluten and structure of the noodle. Several different salts can be considered kansui. In American "
        "kitchens, the most common salts are sodium carbonate and potassium carbonate. \nSodium carbonate will "
        "produce a softer, chewier noodle while potassium carbonate will produce a snappier more brittle noodle. You "
        "can always blend the two types of kansui together to make a ratio that produces the kind of effects that you"
        " want.",
    "footer": "From The Ramen_Lord Book of Ramen, p11 & Way of Ramen's 'The Science Behind a Perfect Ramen Noodle'",
    "imgRoute": "images/kansui.png",
  },
  kSaltText: {
    "description": "Salt performs a similar, but different, function to alkaline salts on the structure of the dough."
        " Sodium ions from the salt help the gluten retain rigidity, prevent overhydration, and increase your "
        "ability to mix the dough without over-developing gluten. Sodium carbonate would also contribute to this by "
        "providing sodium, but it being alkaline salt it serves a different chemical function. Salt also adds flavor"
        " to the dough.",
    "footer": "From The Ramen_Lord Book of Ramen, p14",
    "imgRoute": "images/salt.png",
  },
  kProteinText: {
    "description": "The protein content is primarily derived from wheat gluten and contributes to the noodle's "
        "consistency. The higher the protein content, the more chewiness and \"snap\".\nThe protein amount is "
        "calculated over the dough's solids, i.e. flour and adjuncts.",
    "footer": "Chart information from yamatonoodle.com",
    "imgRoute": "images/protein.png",
  },
  kAdjunctsText: {
    "description": "An adjunct is anything you can add to your dough to enhance the characteristics of the core "
        "ingredients.",
    "footer": "From Way of Ramen's 'The Science Behind a Perfect Ramen Noodle",
    "imgRoute": "images/adjuncts.png",
  },
  kCuttingText: {
    "description": "There is a standard numbering system for size (width) of slitter cutters. The size (width) is "
        "determined by a number/size. For example, if we have a cutter that is No. 20. This number means we can get "
        "20 noodle strands out of 30mm-width of dough sheet. This number means “how many noodle strands we can get out "
        "of 30mm-width of dough sheet?” Then, the width of each noodle strand cut with a No. 20 cutter is 1.5mm "
        "(30mm/20 noodle strands).",
    "footer": "From yamatonoodle.com",
    "imgRoute": "images/cut.png",
  }
};
