import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../constants.dart';
import '../factory_data.dart';
import 'noodle.dart';

class NoodleDbProvider {
  //open the database or create a database if there isn't any
  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = join(directory.path, "noodles.db"); //create path to database

    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE Noodles(
                       id INTEGER PRIMARY KEY AUTOINCREMENT,
                       name VARCHAR(255),
                       portions INT,
                       weight INT,
                       hydration INT,
                       kansui DOUBLE,
                       sodium INT,
                       salt DOUBLE,
                       flourAPercentage INT,
                       flourBPercentage INT,
                       flourCPercentage INT,
                       flourAIndex INT,
                       flourBIndex INT,
                       flourCIndex INT,
                       flourAName VARCHAR(255),
                       flourBName VARCHAR(255),
                       flourCName VARCHAR(255),
                       proteinPercentage DOUBLE,
                       flourFlagPosition INT,
                       flourSelectedPosition INT,
                       adjunctNumber INT,
                       adjunctIndexes VARCHAR(255),
                       adjunctPercentages VARCHAR(255),
                       cutSizeIndex INT,
                       cutShapeIndex INT)""");
    });
  }

  //Insert: returns number of items inserted as an integer
  Future<int> addItem(Noodle item) async {
    final db = await init(); //open database
    if (item.id == 0) {
      item.id = Random().nextInt(maxInt + 100);
      if (kDebugMode) print("Saving noodle with ID ${item.id} into database.");
      return db.insert(
        "Noodles", item.toMap(), //toMap() function from Noodle
        conflictAlgorithm: ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
      );
    } else if (item.id < 100) {
      if (kDebugMode) print("Saving noodle with ID ${item.id} into database.");
      return db.insert(
        "Noodles", item.toMap(), //toMap() function from Noodle
        conflictAlgorithm: ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
      );
    } else {
      return updateNoodle(item.id, item);
    }
  }

  Future<List<Noodle>> fetchNoodles() async {
    //returns the noodles as a list (array)

    final db = await init();
    final maps = await db.query("Noodles"); //query all the rows in a table as an array of maps
    if (kDebugMode) print("Fetching list of noodles from database.");
    return List.generate(maps.length, (i) {
      String adjunctIndexesString = maps[i]['adjunctIndexes'] as String;
      List<int> adjunctIndexes = adjunctIndexesString.split(",").map(int.parse).toList();
      String adjunctPercentagesString = maps[i]['adjunctPercentages'] as String;
      List<double> adjunctPercentages = adjunctPercentagesString.split(",").map(double.parse).toList();

      return Noodle(
        id: maps[i]["id"] as int,
        name: maps[i]['name'] as String,
        portions: maps[i]['portions'] as int,
        weight: maps[i]['weight'] as int,
        hydration: maps[i]['hydration'] as int,
        kansui: maps[i]['kansui'] as double,
        sodium: maps[i]['sodium'] as int,
        salt: maps[i]['salt'] as double,
        flourAPercentage: maps[i]['flourAPercentage'] as int,
        flourBPercentage: maps[i]['flourBPercentage'] as int,
        flourCPercentage: maps[i]['flourCPercentage'] as int,
        flourAIndex: maps[i]['flourAIndex'] as int,
        flourBIndex: maps[i]['flourBIndex'] as int,
        flourCIndex: maps[i]['flourCIndex'] as int,
        flourAName: maps[i]['flourAName'] as String,
        flourBName: maps[i]['flourBName'] as String,
        flourCName: maps[i]['flourCName'] as String,
        proteinPercentage: maps[i]['proteinPercentage'] as double,
        flourFlagPosition: maps[i]['flourFlagPosition'] as int,
        flourSelectedPosition: maps[i]['flourSelectedPosition'] as int,
        adjunctNumber: maps[i]['adjunctNumber'] as int,
        adjunctIndexes: adjunctIndexes,
        adjunctPercentages: adjunctPercentages,
        cutSizeIndex: maps[i]['cutSizeIndex'] as int,
        cutShapeIndex: maps[i]['cutShapeIndex'] as int,
      );
    });
  }

  void showNoodleBrief() async {
    var noodleList = await fetchNoodles();
    if (noodleList.isEmpty) {
      if (kDebugMode) print("There are no entries.");
    } else {
      for (int i = 0; i < noodleList.length; i++) {
        if (kDebugMode) {
          print(
              "Noodle $i \tid=${noodleList[i].id} \tname=${noodleList[i].name} \cutter=${noodleList[i].cutSizeIndex}");
        }
      }
    }
  }

  void resetDatabase() async {
    var noodleList = await fetchNoodles();
    if (kDebugMode) print("Trying to delete the database.");
    if (noodleList.isEmpty) {
      if (kDebugMode) print("There are no entries.");
    } else {
      for (int i = 0; i < noodleList.length; i++) {
        deleteNoodle(noodleList[i].id);
      }
    }
  }

  Future<int> deleteNoodle(int id) async {
    //returns number of items deleted
    final db = await init();
    if (kDebugMode) print("Deleting noodle with ID $id from database.");
    int result = await db.delete("Noodles", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );
    //await db.close();
    return result;
  }

  Future<int> updateNoodle(int id, Noodle item) async {
    final db = await init();
    if (kDebugMode) print("Updating noodle with ID $id in database.");
    int result = await db.update("Noodles", item.toMap(), where: "id = ?", whereArgs: [id]);
    //await db.close();
    return result;
  }

  Future<bool> checkIfEntryExists(int id) async {
    final db = await init();
    final List<Map> result = await db.query(
      'Noodles',
      where: 'id = ?',
      whereArgs: [id],
    );
    //await db.close();
    // Return true if the entry was found, false otherwise
    return result.isNotEmpty;
  }

  Future<bool> checkIfEntryHasCutData(int id) async {
    final db = await init();
    final List<Map> result = await db.query(
      'Noodles',
      where: 'id = ?',
      whereArgs: [id],
    );
    //await db.close();

    // id=1 (tokyo style noodle) should have cutSizeIndex: 5, if not, this is the non-cut factory data
    if (result[0]["cutSizeIndex"] == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<Noodle> getNoodleByID(int id) async {
    final db = await init();
    final List<Map> result = await db.query(
      'Noodles',
      where: 'id = ?',
      whereArgs: [id],
    );

    String adjunctIndexesString = result[0]['adjunctIndexes'] as String;
    List<int> adjunctIndexes = adjunctIndexesString.split(",").map(int.parse).toList();
    String adjunctPercentagesString = result[0]['adjunctPercentages'] as String;
    List<double> adjunctPercentages = adjunctPercentagesString.split(",").map(double.parse).toList();
    //await db.close();
    return Noodle(
      id: result[0]["id"] as int,
      name: result[0]['name'] as String,
      portions: result[0]['portions'] as int,
      weight: result[0]['weight'] as int,
      hydration: result[0]['hydration'] as int,
      kansui: result[0]['kansui'] as double,
      sodium: result[0]['sodium'] as int,
      salt: result[0]['salt'] as double,
      flourAPercentage: result[0]['flourAPercentage'] as int,
      flourBPercentage: result[0]['flourBPercentage'] as int,
      flourCPercentage: result[0]['flourCPercentage'] as int,
      flourAIndex: result[0]['flourAIndex'] as int,
      flourBIndex: result[0]['flourBIndex'] as int,
      flourCIndex: result[0]['flourCIndex'] as int,
      flourAName: result[0]['flourAName'] as String,
      flourBName: result[0]['flourBName'] as String,
      flourCName: result[0]['flourCName'] as String,
      proteinPercentage: result[0]['proteinPercentage'] as double,
      flourFlagPosition: result[0]['flourFlagPosition'] as int,
      flourSelectedPosition: result[0]['flourSelectedPosition'] as int,
      adjunctNumber: result[0]['adjunctNumber'] as int,
      adjunctIndexes: adjunctIndexes,
      adjunctPercentages: adjunctPercentages,
      cutSizeIndex: result[0]['cutSizeIndex'] as int,
      cutShapeIndex: result[0]['cutShapeIndex'] as int,
    );
  }

  void factoryReset() async {
    if (!(await checkIfEntryExists(1))) {
      for (int i = 0; i < kFactoryNoodles.length; i++) {
        if (kDebugMode) print("inserting ${kFactoryNoodles[i].toString()}");
        addItem(kFactoryNoodles[i]);
      }
      //update with cutter data if the data was created before
    } else if (!(await checkIfEntryHasCutData(1))) {
      for (int i = 0; i < kFactoryNoodles.length; i++) {
        updateNoodle(i + 1, kFactoryNoodles[i]);
      }
    }
  }
}
