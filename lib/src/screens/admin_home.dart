import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:muda_facil/src/utils/constants.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    var outlinedButton = OutlinedButton(
      onPressed: () {},
      child: const Text('Pedidos'),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            count > 0
                ? badges.Badge(
                    badgeContent: Text(
                      count.toString(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 10.0,
                      ),
                    ),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.all(kDefaultPadding / 2.5),
                    ),
                    badgeAnimation: const badges.BadgeAnimation.rotation(
                      animationDuration: Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      colorChangeAnimationCurve: Curves.easeInCubic,
                    ),
                    child: outlinedButton,
                  )
                : outlinedButton,
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
                child: const Text('Adicionar')),
          ],
        ),
      ),
    );
  }
}
