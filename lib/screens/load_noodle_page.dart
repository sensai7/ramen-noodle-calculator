import 'package:flutter/material.dart';
import '../constants.dart';
import '../controllers/database_helper.dart';
import '../controllers/noodle.dart';
import '../widgets/row_noodle_name.dart';

class LoadNoodlePage extends StatefulWidget {
  const LoadNoodlePage({Key? key}) : super(key: key);

  @override
  State<LoadNoodlePage> createState() => _LoadNoodlePageState();
}

class _LoadNoodlePageState extends State<LoadNoodlePage> {
  Future<List> loadDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    NoodleDbProvider noodleDb = NoodleDbProvider();
    List<Noodle> noodleList = await noodleDb.fetchNoodles();
    List<Map> mapList = [];
    for (int i = 0; i < noodleList.length; i++) {
      mapList.add({"name": noodleList[i].name, "id": noodleList[i].id});
    }
    return mapList;
  }

  Future<bool> showExitPopup(int deleteID, String name) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: kColorBackground,
            title: Text(
              'Delete $name',
              style: const TextStyle(color: kColorText),
            ),
            content:
                const Text('Do you want really want to delete this saved recipe?', style: TextStyle(color: kColorText)),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kColorSecondary),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('No', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kColorSecondary),
                ),
                onPressed: () {
                  WidgetsFlutterBinding.ensureInitialized();
                  NoodleDbProvider noodleDb = NoodleDbProvider();
                  setState(() {
                    noodleDb.deleteNoodle(deleteID);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Yes', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadDB(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kColorSecondary,
              centerTitle: true,
              title: const Text(kTitle, style: TextStyle(color: Colors.white)),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: (snapshot.data as List).length,
                    itemBuilder: (context, index) {
                      return RowNoodleName(
                          name: (snapshot.data as List)[index]["name"],
                          id: (snapshot.data as List)[index]["id"],
                          onDelete: (id) {
                            showExitPopup(id, (snapshot.data as List)[index]["name"]);
                          });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
