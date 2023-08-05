import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/controllers/user_order.dart';
import 'package:muda_facil/src/features/my_order/no_order_info.dart';
import 'package:muda_facil/src/features/my_order/order_info.dart';
import 'package:muda_facil/src/utils/constants.dart';

class MyOrder extends ConsumerWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userOrder = ref.watch(userOrderOrNullProvider);
    final actions = ref.read(userOrderOrNullProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding * 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColorDark.withOpacity(0.4),
        ),
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: userOrder == null
          ? const NoOrderInfo()
          : OrderInfo(
              order: userOrder,
              actions: actions,
            ),
    );
  }
}
