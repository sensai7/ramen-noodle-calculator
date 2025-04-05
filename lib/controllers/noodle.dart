import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ramen_noodle_calc/adjuncts.dart';
import '../constants.dart';

class Noodle {
  int id;
  String name;
  int portions;
  int weight;
  int hydration;
  double kansui;
  int sodium;
  double salt;
  int flourAPercentage;
  int flourBPercentage;
  int flourCPercentage;
  int flourAIndex;
  int flourBIndex;
  int flourCIndex;
  String flourAName;
  String flourBName;
  String flourCName;
  double proteinPercentage;
  int flourFlagPosition;
  int flourSelectedPosition;
  int adjunctNumber;
  List<int> adjunctIndexes;
  List<double> adjunctPercentages;
  int cutSizeIndex;
  int cutShapeIndex;

  Noodle({
    this.id = 0,
    this.name = "",
    this.portions = defNRations,
    this.weight = defRationGrams,
    this.hydration = defHydration,
    this.kansui = defKansui,
    this.sodium = defSodium,
    this.salt = defSalt,
    this.flourAPercentage = 100,
    this.flourBPercentage = 0,
    this.flourCPercentage = 0,
    this.flourAIndex = 0,
    this.flourBIndex = 1,
    this.flourCIndex = 2,
    this.flourAName = "* Generic bread flour", //kFlourListGeneric[0]["name"],
    this.flourBName = "* Generic AP flour", //kFlourListGeneric[1]["name"],
    this.flourCName = "* Generic cake flour", //kFlourListGeneric[2]["name"],
    this.proteinPercentage = 13.0, //kFlourListGeneric[0]["protein"],
    this.flourFlagPosition = 0,
    this.flourSelectedPosition = 0,
    this.adjunctNumber = kAdjunctsStart,
    this.adjunctIndexes = kAdjunctDefaultIndexes,
    this.adjunctPercentages = kAdjunctDefaultPercentages,
    this.cutSizeIndex = 0,
    this.cutShapeIndex = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "portions": portions,
      "weight": weight,
      "hydration": hydration,
      "kansui": kansui,
      "sodium": sodium,
      "salt": salt,
      "flourAPercentage": flourAPercentage,
      "flourBPercentage": flourBPercentage,
      "flourCPercentage": flourCPercentage,
      "flourAIndex": flourAIndex,
      "flourBIndex": flourBIndex,
      "flourCIndex": flourCIndex,
      "flourAName": flourAName,
      "flourBName": flourBName,
      "flourCName": flourCName,
      "proteinPercentage": proteinPercentage,
      "flourFlagPosition": flourFlagPosition,
      "flourSelectedPosition": flourSelectedPosition,
      "adjunctNumber": adjunctNumber,
      "adjunctIndexes": adjunctIndexes.join(","),
      "adjunctPercentages": adjunctPercentages.join(","),
      "cutSizeIndex": cutSizeIndex,
      "cutShapeIndex": cutShapeIndex,
    };
  }

  // There's probably a bug in this function but it's never used:
  // the adjunctIndexes/adjunctPercentages are not treated as strings
  static Noodle fromMap(Map<String, dynamic> map) {
    return Noodle(
      id: map["id"],
      name: map['name'],
      portions: map['portions'],
      weight: map['weight'],
      hydration: map['hydration'],
      kansui: map['kansui'],
      sodium: map['sodium'],
      salt: map['salt'],
      flourAPercentage: map['flourAPercentage'],
      flourBPercentage: map['flourBPercentage'],
      flourCPercentage: map['flourCPercentage'],
      flourAIndex: map['flourAIndex'],
      flourBIndex: map['flourBIndex'],
      flourCIndex: map['flourCIndex'],
      flourAName: map['flourAName'],
      flourBName: map['flourBName'],
      flourCName: map['flourCName'],
      proteinPercentage: map['proteinPercentage'],
      flourFlagPosition: map['flourFlagPosition'],
      flourSelectedPosition: map['flourSelectedPosition'],
      adjunctNumber: map['adjunctNumber'],
      adjunctIndexes: map['adjunctIndexes'],
      adjunctPercentages: map['adjunctPercentages'],
      cutSizeIndex: map['cutSizeIndex'],
      cutShapeIndex: map['cutShapeIndex'],
    );
  }

  //http://localhost:33513/?para1=flutter&para2=campus
  String shareURL() {
    String base = "https://sensai7.github.io/ramen_noodle_calc/?";
    String encodedName = "name=" + Uri.encodeComponent(name) + "&params=";
    String tail = portions.toString() +
        "|" +
        weight.toString() +
        "|" +
        hydration.toString() +
        "|" +
        kansui.toStringAsFixed(1) +
        "|" +
        sodium.toString() +
        "|" +
        salt.toStringAsFixed(1) +
        "|" +
        flourAPercentage.toString() +
        "|" +
        flourBPercentage.toString() +
        "|" +
        flourCPercentage.toString() +
        "|" +
        flourAIndex.toString() +
        "|" +
        flourBIndex.toString() +
        "|" +
        flourCIndex.toString() +
        "|" +
        proteinPercentage.toStringAsFixed(3) +
        "|" +
        flourFlagPosition.toString() +
        "|" +
        flourSelectedPosition.toString() +
        "|" +
        adjunctNumber.toString() +
        "|" +
        adjunctIndexes.toString().replaceAll(" ", "").replaceAll("[", "").replaceAll("]", "") +
        "|" +
        adjunctPercentages.toString().replaceAll(" ", "").replaceAll("[", "").replaceAll("]", "") +
        "|" +
        cutSizeIndex.toString() +
        "|" +
        cutShapeIndex.toString();

    if (kDebugMode) print("Original URL: \t" + base + encodedName + tail);

    String compressed = base64Encode(utf8.encode(tail));
    if (kDebugMode) {
      print("Final URL: \t\t" + base + encodedName + "params=" + compressed + "#/");
    }

    return base + encodedName + compressed + "#/";
  }

  void addAdjunct() {
    if (adjunctNumber < kAdjunctLimit) {
      changeAdjunctIndex(adjunctNumber, 0);
      changeAdjunctPercentage(adjunctNumber, 1.0);
      adjunctNumber += 1;
    }
  }

  void deleteAdjunct(int deleteIndex) {
    for (int i = deleteIndex; i < kAdjunctLimit - 2; i++) {
      changeAdjunctIndex(deleteIndex, adjunctIndexes[deleteIndex + 1]);
      changeAdjunctPercentage(deleteIndex, adjunctPercentages[deleteIndex + 1]);
    }
    adjunctNumber -= 1;
  }

  void changeAdjunctIndex(int header, int index) {
    List<int> newList = [];

    for (int i = 0; i < kAdjunctLimit; i++) {
      if (i == header) {
        newList.add(index);
      } else {
        newList.add(adjunctIndexes[i]);
      }
    }
    adjunctIndexes = newList;
  }

  void changeAdjunctPercentage(int header, double percentage) {
    List<double> newList = [];

    for (int i = 0; i < kAdjunctLimit; i++) {
      if (i == header) {
        newList.add(percentage);
      } else {
        newList.add(adjunctPercentages[i]);
      }
    }
    adjunctPercentages = newList;
  }

  void getProtein(flourList) {
    double proteinA = flourList[flourAIndex]["protein"];
    double proteinB = flourList[flourBIndex]["protein"];
    double proteinC = flourList[flourCIndex]["protein"];
    double flourProtein;

    // 1 flour
    if (flourSelectedPosition == 1) {
      flourProtein = proteinA * flourAPercentage / 100 + proteinB * flourBPercentage / 100;
      // 2 flours
    } else if (flourSelectedPosition == 2) {
      flourProtein =
          proteinA * flourAPercentage / 100 + proteinB * flourBPercentage / 100 + proteinC * flourCPercentage / 100;
      // 3 flours
    } else {
      flourProtein = proteinA;
    }

    // Adjuncts
    double flourWeight = weight / (1 + hydration / 100);
    double solidsWeight = weight / (1 + hydration / 100);
    int checkAdjunct = 0;
    while (checkAdjunct < adjunctNumber) {
      solidsWeight += (adjunctPercentages[checkAdjunct] / 100) * flourWeight;
      checkAdjunct++;
    }

    checkAdjunct = 0;
    List<double> sumElements = [flourWeight * flourProtein / solidsWeight];
    while (checkAdjunct < adjunctNumber) {
      double thisAdjunctWeight = (flourWeight * adjunctPercentages[checkAdjunct] / 100);
      double thisAdjunctProteinPercentage = adjunctList[adjunctIndexes[checkAdjunct]]["protein"];
      sumElements.add(thisAdjunctWeight * thisAdjunctProteinPercentage / solidsWeight);
      checkAdjunct++;
    }

    proteinPercentage = sumElements.reduce((a, b) => a + b);
  }

  void spit() {
    if (kDebugMode) {
      print("Noodle(");
      print('id: change_manually,');
      print('name: "$name",');
      print('hydration: $hydration,');
      print('kansui: $kansui,');
      print('salt: $salt,');
      print('sodium: $sodium,');
      print('weight: $weight,');
      print('portions: $portions,');
      print('flourAPercentage: $flourAPercentage,');
      print('flourBPercentage: $flourBPercentage,');
      print('flourCPercentage: $flourCPercentage,');
      print('flourAIndex: $flourAIndex,');
      print('flourBIndex: $flourBIndex,');
      print('flourCIndex: $flourCIndex,');
      print('proteinPercentage: $proteinPercentage,');
      print('flourFlagPosition: $flourFlagPosition,');
      print('flourSelectedPosition: $flourSelectedPosition,');
      print('adjunctNumber: $adjunctNumber,');
      print('adjunctIndexes: $adjunctIndexes,');
      print('adjunctPercentages: $adjunctPercentages,');
      print('cutSizeIndex: $cutSizeIndex,');
      print('cutShapeIndex: $cutShapeIndex,');
      print("),");
    }
  }
}

List url2Noodle(String urlParam, String name) {
  name = Uri.decodeComponent(name);
  if (kDebugMode) print("Name:  \t\t\t" + name);

  String slashSeparated = utf8.decode(base64Decode(urlParam));
  if (kDebugMode) print("Param: \t\t\t" + slashSeparated);
  List<String> fields = slashSeparated.split("|");

  // [0]  portions
  // [1]  weight
  // [2]  hydration
  // [3]  kansui
  // [4]  sodium
  // [5]  salt
  // [6]  flourAPercentage
  // [7]  flourBPercentage
  // [8]  flourCPercentage
  // [9]  flourAIndex
  // [10] flourBIndex
  // [11] flourCIndex
  // [12] proteinPercentage
  // [13] flourFlagPosition
  // [14] flourSelectedPosition
  // [15] adjunctNumber
  // [16] adjunctIndexes
  // [17] adjunctPercentages

  // print("name: ${name}");
  // print("portions: ${int.parse(fields[0])}");
  // print("weight: ${int.parse(fields[1])}");
  // print("hydration: ${int.parse(fields[2])}");
  // print("kansui: ${double.parse(fields[3])}");
  // print("sodium: ${int.parse(fields[4])}");
  // print("salt: ${double.parse(fields[5])}");
  // print("flourAPercentage: ${int.parse(fields[6])}");
  // print("flourBPercentage: ${int.parse(fields[7])}");
  // print("flourCPercentage: ${int.parse(fields[8])}");
  // print("flourAIndex: ${int.parse(fields[9])}");
  // print("flourBIndex: ${int.parse(fields[10])}");
  // print("flourCIndex: ${int.parse(fields[11])}");
  // print("proteinPercentage: ${double.parse(fields[12])}");
  // print("flourFlagPosition: ${int.parse(fields[13])}");
  // print("flourSelectedPosition: ${int.parse(fields[14])}");
  // print("adjunctNumber: ${int.parse(fields[15])}");
  // print("adjunctIndexes: ${fields[16].split(',').map(int.parse).toList()}");
  // print("adjunctPercentages: ${fields[17].split(',').map(double.parse).toList()}");

  if (fields.length > 18) {
    if (kDebugMode) {
      print("This is a >18 param URL (includes cutter size and shape)");
    }
    return [
      Noodle(
        name: name,
        portions: int.parse(fields[0]),
        weight: int.parse(fields[1]),
        hydration: int.parse(fields[2]),
        kansui: double.parse(fields[3]),
        sodium: int.parse(fields[4]),
        salt: double.parse(fields[5]),
        flourAPercentage: int.parse(fields[6]),
        flourBPercentage: int.parse(fields[7]),
        flourCPercentage: int.parse(fields[8]),
        flourAIndex: int.parse(fields[9]),
        flourBIndex: int.parse(fields[10]),
        flourCIndex: int.parse(fields[11]),
        proteinPercentage: double.parse(fields[12]),
        flourFlagPosition: int.parse(fields[13]),
        flourSelectedPosition: int.parse(fields[14]),
        adjunctNumber: int.parse(fields[15]),
        adjunctIndexes: fields[16].split(",").map(int.parse).toList(),
        adjunctPercentages: fields[17].split(",").map(double.parse).toList(),
        cutSizeIndex: int.parse(fields[18]),
        cutShapeIndex: int.parse(fields[19]),
      ),
      int.parse(fields[13]),
      name
    ];
  } else {
    print("This is an original length URL (up to adjuncts)");
    return [
      Noodle(
        name: name,
        portions: int.parse(fields[0]),
        weight: int.parse(fields[1]),
        hydration: int.parse(fields[2]),
        kansui: double.parse(fields[3]),
        sodium: int.parse(fields[4]),
        salt: double.parse(fields[5]),
        flourAPercentage: int.parse(fields[6]),
        flourBPercentage: int.parse(fields[7]),
        flourCPercentage: int.parse(fields[8]),
        flourAIndex: int.parse(fields[9]),
        flourBIndex: int.parse(fields[10]),
        flourCIndex: int.parse(fields[11]),
        proteinPercentage: double.parse(fields[12]),
        flourFlagPosition: int.parse(fields[13]),
        flourSelectedPosition: int.parse(fields[14]),
        adjunctNumber: int.parse(fields[15]),
        adjunctIndexes: fields[16].split(",").map(int.parse).toList(),
        adjunctPercentages: fields[17].split(",").map(double.parse).toList(),
      ),
      int.parse(fields[13]),
      name
    ];
  }
}
