import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ramen_noodle_calc/controllers/noodle.dart';
import '../constants.dart';
import '../controllers/database_helper.dart';

class NamePanel extends StatelessWidget {
  const NamePanel({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.savedNoodle,
  }) : super(key: key);

  final Function(String) onChanged;
  final TextEditingController controller;
  final Noodle savedNoodle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Container(
          margin: const EdgeInsets.all(kReusableCardMargin),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: TextInputType.name,
            style: kLabelTextStyle.copyWith(fontSize: 18),
            maxLines: 1,
            textCapitalization: TextCapitalization.sentences,
            maxLength: 120,
            decoration: InputDecoration(
              labelStyle: kLabelTextStyle.copyWith(fontSize: 20),
              filled: true,
              errorStyle: const TextStyle(height: 0.7),
              fillColor: kColorInactiveBackground,
              focusColor: kColorInactiveBackground,
              labelText: kNoodleName,
              suffixIcon: !kIsWeb
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            if (savedNoodle.name == "") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: Text("Add a name before saving.")));
                              //url2Noodle(savedNoodle.shareURL());
                            } else {
                              String url = savedNoodle.shareURL();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: SelectableText("Url copied to clipboard.")));
                              //print(url);
                              await Clipboard.setData(ClipboardData(text: url));
                            }
                          },
                          icon: const Icon(Icons.share),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (savedNoodle.name == "") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: Text("Add a name before saving.")));
                            } else {
                              if ((savedNoodle.id < 100) && (savedNoodle.id != 0)) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Factory recipes "
                                        "can't be overwritten.")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saving...")));
                                WidgetsFlutterBinding.ensureInitialized();
                                NoodleDbProvider noodleDb = NoodleDbProvider();
                                await noodleDb.addItem(savedNoodle);
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                            }
                          },
                          icon: const Icon(Icons.save, color: kColorSecondary),
                        ),
                      ],
                    )
                  : IconButton(
                      onPressed: () async {
                        if (savedNoodle.name == "") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text("Add a name before saving.")));
                          //url2Noodle(savedNoodle.shareURL());
                        } else {
                          String url = savedNoodle.shareURL();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: SelectableText("Url copied to clipboard.")));
                          //print(url);
                          await Clipboard.setData(ClipboardData(text: url));
                        }
                      },
                      icon: const Icon(Icons.share),
                    ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(kReusableCardRadius)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(kReusableCardRadius)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(kReusableCardRadius)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
