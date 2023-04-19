import 'package:flutter/material.dart';
import 'package:muda_facil/src/screens/building.dart';

class DriverHome extends StatelessWidget {
  const DriverHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Building(screenName: 'Driver home'),
    );
  }
}
