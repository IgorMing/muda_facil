import 'package:flutter/material.dart';

class OrderApproved extends StatelessWidget {
  const OrderApproved({super.key, required this.driverName});

  final String driverName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          'Tudo certo! Sua mudança está confirmada com o motorista $driverName'),
    );
  }
}
