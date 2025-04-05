import 'package:flutter/material.dart';
import 'package:ramen_noodle_calc/widgets/reusable_card.dart';

import '../constants.dart';

class RowNoodleName extends StatelessWidget {
  const RowNoodleName({
    Key? key,
    required this.name,
    required this.id,
    required this.onDelete,
  }) : super(key: key);

  final String name;
  final int id;
  final Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop(id);
          },
          child: ElevatedReusableCard(
            backgroundColor: kColorInactiveBackground,
            child: ListTile(
              //title: Text("(id=" + id.toString() + ") " + name, style: kLabelTextStyle),
              title: Text(name, style: kLabelTextStyle),
              trailing: Visibility(
                visible: (id > 100), //factory noodles can't be deleted
                child: GestureDetector(
                  onTap: () {
                    onDelete(id);
                  },
                  child: const Icon(Icons.delete, color: kColorSecondary),
                ),
              ),
            ),
          ),
        ),
        //Divider(color: kTextColor),
      ],
    );
  }
}
