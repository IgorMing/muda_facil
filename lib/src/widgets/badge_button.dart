import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class BadgeButton extends StatelessWidget {
  const BadgeButton({
    super.key,
    required this.onPress,
    required this.label,
    this.value,
  });

  final Function() onPress;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final outlinedButton = OutlinedButton(
      onPressed: onPress,
      child: Text(label),
    );

    if (value == null) {
      return outlinedButton;
    }

    return badges.Badge(
      badgeContent: Text(
        value!,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 10.0,
        ),
      ),
      badgeStyle: badges.BadgeStyle(
        badgeColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.all(kDefaultPadding / 2.5),
      ),
      badgeAnimation: const badges.BadgeAnimation.scale(
        animationDuration: Duration(milliseconds: 500),
        curve: Curves.decelerate,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      child: outlinedButton,
    );
  }
}
