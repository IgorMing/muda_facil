import 'package:flutter/material.dart';

class OrderHelpNeeded extends StatelessWidget {
  const OrderHelpNeeded({super.key, required this.helpText});

  final String helpText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Help needed: $helpText'),
    );
  }
}
