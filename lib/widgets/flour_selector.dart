import 'package:flutter/material.dart';
import '../constants.dart';
import 'dropdown_row.dart';

class FlourSelector extends StatelessWidget {
  const FlourSelector({
    Key? key,
    required this.flourList,
    required this.selectedIndexes,
    required this.onDropdownChange,
    required this.nFlours,
    required this.flourAper,
  }) : super(key: key);

  final List<Map> flourList;
  final List<int> selectedIndexes;
  final Function(List) onDropdownChange;
  final int nFlours;
  final int flourAper;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> items = [];

    for (int i = 0; i < flourList.length; i++) {
      DropdownMenuItem<String> item = DropdownMenuItem(
          child: SizedBox(
            child: Text(
              flourList[i]["name"],
              style: kLabelTextStyle,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 2,
            ),
          ),
          value: flourList[i]["name"]);
      items.add(item);
    }
    return Column(
      children: [
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 8),
            const Expanded(flex: 1, child: Text("", style: kLabelTextStyle)),
            const SizedBox(width: 5),
            Expanded(
              flex: 4,
              child: Row(
                children: const [
                  SizedBox(width: 30),
                  Text("Flour name", style: kLabelTextStyle),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              flex: 1,
              child: Text("Protein", style: kLabelTextStyle),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        DropdownRow(
          flourList: flourList,
          header: "Flour A",
          itemList: items,
          index: selectedIndexes[0],
          onDropdownChange: (headerAndIndex) {
            onDropdownChange(headerAndIndex);
          },
        ),
        Visibility(
          visible: (nFlours > 0),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              DropdownRow(
                flourList: flourList,
                header: "Flour B",
                itemList: items,
                index: selectedIndexes[1],
                onDropdownChange: (headerAndIndex) {
                  onDropdownChange(headerAndIndex);
                },
              ),
              Visibility(
                visible: (nFlours > 1),
                child: Column(
                  children: [
                    const SizedBox(height: 8.0),
                    DropdownRow(
                      flourList: flourList,
                      header: "Flour C",
                      itemList: items,
                      index: selectedIndexes[2],
                      onDropdownChange: (headerAndIndex) {
                        onDropdownChange(headerAndIndex);
                      },
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
