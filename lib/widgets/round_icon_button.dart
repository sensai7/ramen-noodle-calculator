import 'package:flutter/material.dart';
import '../constants.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    Key? key,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      child: Icon(icon),
      elevation: 0,
      constraints: const BoxConstraints.tightFor(
        width: 35,
        height: 35,
      ),
      shape: const CircleBorder(),
      fillColor: kColorButton,
    );
  }
}
