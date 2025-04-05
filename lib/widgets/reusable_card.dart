import 'package:flutter/material.dart';

import '../constants.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    Key? key,
    required this.child,
    this.backgroundColor = kColorInactiveCard,
  }) : super(key: key);

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 10),
          child,
          const SizedBox(height: 10),
        ],
      ),
      margin: const EdgeInsets.all(kReusableCardMargin),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(kReusableCardRadius),
      ),
    );
  }
}

class ExpandedReusableCard extends StatelessWidget {
  const ExpandedReusableCard({
    Key? key,
    required this.child,
    this.backgroundColor = kColorInactiveCard,
  }) : super(key: key);

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 10),
          child,
          const SizedBox(height: 10),
        ],
      ),
      margin: const EdgeInsets.all(kReusableCardMargin),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(kReusableCardRadius),
      ),
    );
  }
}

class ElevatedReusableCard extends StatelessWidget {
  const ElevatedReusableCard({
    Key? key,
    required this.child,
    this.backgroundColor = kColorInactiveCard,
  }) : super(key: key);

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 10),
          child,
          const SizedBox(height: 10),
        ],
      ),
      margin: const EdgeInsets.all(kReusableCardMargin),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            blurRadius: 0.5,
            spreadRadius: 0.5,
            offset: const Offset(2, 2),
          )
        ],
        color: backgroundColor,
        borderRadius: BorderRadius.circular(kReusableCardRadius),
      ),
    );
  }
}
