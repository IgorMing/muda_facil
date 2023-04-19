import 'package:flutter/material.dart';
import 'package:muda_facil/src/screens/building.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Building(screenName: 'Admin home'),
    );
  }
}
