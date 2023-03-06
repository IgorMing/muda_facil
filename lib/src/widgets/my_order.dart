import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/user_order.dart';

class MyOrder extends ConsumerWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userOrder = ref.watch(userOrderProvider);

    return Card(
      child: Column(
        children: [
          Text("Para: ${userOrder?.destinyAddress}"),
          Text("Em: ${userOrder?.movingDate?.toDate()}"),
        ],
      ),
    );
  }
}
