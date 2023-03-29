import 'package:flutter/material.dart';
import 'package:muda_facil/src/models/item.dart';
import 'package:muda_facil/src/utils/constants.dart';

class ReviewItemCard extends StatelessWidget {
  const ReviewItemCard({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Text("${item.amount}x ${item.name}"),
      ),
    );
  }
}
