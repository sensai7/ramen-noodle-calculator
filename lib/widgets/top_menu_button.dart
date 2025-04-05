import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../controllers/database_helper.dart';
import '../controllers/noodle.dart';
import '../screens/load_noodle_page.dart';

class TopMenuButton extends StatelessWidget {
  const TopMenuButton({
    Key? key,
    required this.setDefaultCallback,
    required this.noodle,
    required this.loadNoodleCallback,
  }) : super(key: key);

  final VoidCallback setDefaultCallback;

  final Noodle noodle; // todo this probably takes a lot of resources but its useful to generate factory data. delete
  // once the default recipes are ready
  final Function(Noodle) loadNoodleCallback;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu),
      color: kColorInactiveBackground,
      itemBuilder: (BuildContext context) {
        return !kIsWeb
            ? dotMenuItemsApp.map((String choice) {
                return PopupMenuItem<String>(
                  child: Text(
                    choice,
                    style: kLabelTextStyle,
                  ),
                  value: choice,
                );
              }).toList()
            : dotMenuItemsWeb.map((String choice) {
                return PopupMenuItem<String>(
                  child: Text(
                    choice,
                    style: kLabelTextStyle,
                  ),
                  value: choice,
                );
              }).toList();
      },
      onSelected: (item) {
        switch (item) {
          case 'Default values':
            setDefaultCallback();
            FocusManager.instance.primaryFocus?.unfocus();
            break;
          case 'About':
            //openURL(profileUrl);
            showAboutDialog(
              context: context,
              applicationName: 'Ramen Noodle Calculator',
              applicationVersion: '1.3.0',
              //textStyle: TextStyle(color: Colors.red),
              applicationIcon: Image.asset('images/appstore.png'),
              //applicationLegalese: '© 2023 Gonzalo ',
              children: <Widget>[
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      String link = "https://sensai7.github.io/my-projects/#/";
                      openURL(link);
                    },
                    child: const Text("Check out my other stuff", style: kLinkTextStyle),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [Text('Made with Flutter '), FlutterLogo()],
                ),
              ],
            );
            break;
          case 'DEBUG: Show brief':
            WidgetsFlutterBinding.ensureInitialized();
            NoodleDbProvider noodleDb = NoodleDbProvider();
            noodleDb.showNoodleBrief();
            FocusManager.instance.primaryFocus?.unfocus();
            break;
          case 'DEBUG: Delete database':
            WidgetsFlutterBinding.ensureInitialized();
            NoodleDbProvider noodleDb = NoodleDbProvider();
            noodleDb.resetDatabase();
            FocusManager.instance.primaryFocus?.unfocus();
            break;
          case 'DEBUG: Spit noodle':
            noodle.spit();

            break;
          case 'Load noodle':
            _navigateAndDisplaySelection(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) {
            //     return LoadNoodlePage();
            //   }),
            // );

            break;
          case 'This app in Play Store':
            String url = 'https://play.google.com/store/apps/details?id=com.gonya707.noodlecalc';
            openURL(url);
            break;
        }
      },
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final id = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoadNoodlePage()),
    );
    if (id != null) {
      if (kDebugMode) print("Loading noodle with id=$id");
      WidgetsFlutterBinding.ensureInitialized();
      NoodleDbProvider noodleDb = NoodleDbProvider();
      Noodle loadNoodle = await noodleDb.getNoodleByID(id);
      loadNoodleCallback(loadNoodle);
    }
  }
}
