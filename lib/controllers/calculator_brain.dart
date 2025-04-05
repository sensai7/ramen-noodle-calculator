import 'package:ramen_noodle_calc/controllers/noodle.dart';

import '../adjuncts.dart';

class CalculatorBrain {
  CalculatorBrain({
    required this.noodle,
    required this.flourList,
  });

  final Noodle noodle;
  final dynamic flourList;

  double waterGrams = 0;
  double kansuiGrams = 0;
  double kansuiSodiumGrams = 0;
  double saltGrams = 0;
  double flourA = 0;
  double flourB = 0;
  double flourC = 0;
  String flourAName = "";
  String flourBName = "";
  String flourCName = "";
  int nAdjuncts = 0;
  List<String> adjunctNameList = [];
  List<double> adjunctGramList = [];
  List<double> adjunctPercentageList = [];
  bool waterAdjusted = false;
  double wetProteinPercentage = 0;
  double proteinGrams = 0;

  void calculate() {
    flourAName = flourList[noodle.flourAIndex]["name"];
    flourBName = flourList[noodle.flourBIndex]["name"];
    flourCName = flourList[noodle.flourCIndex]["name"];
    double flourWeight = noodle.weight / (1 + noodle.hydration / 100) * noodle.portions;
    flourA = noodle.flourAPercentage / 100 * flourWeight;
    flourB = noodle.flourBPercentage / 100 * flourWeight;
    flourC = noodle.flourCPercentage / 100 * flourWeight;
    waterGrams = flourWeight * noodle.hydration / 100;
    kansuiGrams = flourWeight * noodle.kansui / 100;
    kansuiSodiumGrams = kansuiGrams * noodle.sodium / 100;
    saltGrams = flourWeight * noodle.salt / 100;
    nAdjuncts = noodle.adjunctNumber;

    double adjunctWeight = 0;
    for (int i = 0; i < nAdjuncts; i++) {
      String thisAdjunctName = adjunctList[noodle.adjunctIndexes[i]]["name"];
      double thisAdjunctPercentage = noodle.adjunctPercentages[i];
      double thisAdjunctGrams = noodle.adjunctPercentages[i] * flourWeight / 100;
      double thisAdjunctWaterPer = adjunctList[noodle.adjunctIndexes[i]]["water"];
      double thisAdjunctWater = thisAdjunctWaterPer / 100 * thisAdjunctGrams;
      adjunctNameList.add(thisAdjunctName);
      adjunctGramList.add(thisAdjunctGrams);
      adjunctPercentageList.add(thisAdjunctPercentage);
      adjunctWeight += thisAdjunctGrams;
      if (thisAdjunctWater > 0) {
        waterAdjusted = true;
        waterGrams -= thisAdjunctWater;
      }
    }
    double dryWeight = flourWeight + adjunctWeight;
    proteinGrams = noodle.proteinPercentage / 100 * dryWeight;
    wetProteinPercentage = proteinGrams / (waterGrams + dryWeight) * 100;
  }

  Map<String, dynamic> get map {
    return {
      "name": noodle.name,
      "weight": noodle.weight,
      "saltPercentage": noodle.salt,
      "sodiumPercentage": noodle.sodium,
      "portions": noodle.portions,
      "hydration": noodle.hydration,
      "waterGrams": waterGrams,
      "kansuiPercentage": noodle.kansui,
      "kansuiGrams": kansuiGrams,
      "kansuiSodiumGrams": kansuiSodiumGrams,
      "saltGrams": saltGrams,
      "flourAGrams": flourA,
      "flourBGrams": flourB,
      "flourCGrams": flourC,
      "flourAPercentage": noodle.flourAPercentage,
      "flourBPercentage": noodle.flourBPercentage,
      "flourCPercentage": noodle.flourCPercentage,
      "proteinPercentage": noodle.proteinPercentage,
      "proteinGrams": proteinGrams,
      "wetProteinPercentage": wetProteinPercentage,
      "flourSelected": noodle.flourSelectedPosition,
      "flourAName": flourAName,
      "flourBName": flourBName,
      "flourCName": flourCName,
      "nAdjuncts": nAdjuncts,
      "adjunctNameList": adjunctNameList,
      "adjunctGramList": adjunctGramList,
      "adjunctPercentageList": adjunctPercentageList,
      "waterAdjusted": waterAdjusted,
      "cutSizeIndex": noodle.cutSizeIndex,
      "cutShapeIndex": noodle.cutShapeIndex,
    };
  }
}
