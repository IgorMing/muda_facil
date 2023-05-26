import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({
    super.key,
    required this.label,
    this.onPress,
    this.description,
    this.value,
  });

  final Function()? onPress;
  final String label;
  final String? description;
  final int? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final disabled = onPress == null;

    final outlinedButton = SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
              disabled ? Colors.grey.withOpacity(0.8) : Colors.white),
        ),
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              if (disabled) ...[
                const Icon(Icons.lock),
                const SizedBox(height: kDefaultPadding / 2),
              ],
              Text(
                label,
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: theme.colorScheme.primary),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              if (description != null)
                Text(
                  description!,
                  style: theme.textTheme.bodySmall,
                ),
            ],
          ),
        ),
      ),
    );

    if (value == null) {
      return outlinedButton;
    }

    return badges.Badge(
      badgeContent: Text(
        value.toString(),
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
