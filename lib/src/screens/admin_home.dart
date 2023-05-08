import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/widgets/badge_button.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            BadgeButton(
                onPress: () {}, label: 'Pedidos', value: count.toString()),
            BadgeButton(
              onPress: () {
                setState(() {
                  count++;
                });
              },
              label: 'Add 1 more',
            ),
          ],
        ),
      ),
    );
  }
}
