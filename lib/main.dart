import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:ramen_noodle_calc/screens/input_page.dart';
import 'constants.dart';

void main() => runApp(const NoodleCalc());

class NoodleCalc extends StatelessWidget {
  const NoodleCalc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // backup
    return FlutterWebFrame(
      builder: (context) {
        return MaterialApp(
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: kColorBackground,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: kColorActiveCard,
              secondary: kColorSecondary,
            ),
            dialogTheme: DialogTheme(
              backgroundColor: const Color(0xff424242),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kReusableCardRadius)),
              elevation: 5,
              //contentTextStyle: kLabelTextStyle,
              //titleTextStyle: TextStyle(color: Colors.blue),
            ),
          ),
          home: const InputPage(),
        );
      },
      //clipBehavior: Clip.hardEdge,
      maximumSize: const Size(775.0, 812.0), // Maximum size
      enabled: kIsWeb, // default is enable, when disable content is full size
      backgroundColor: kColorBackground, // Background color/white space
    );
  }
}
