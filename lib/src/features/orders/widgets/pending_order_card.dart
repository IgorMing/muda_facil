import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/orders/orders.bloc.dart';
import 'package:muda_facil/src/features/orders/widgets/order_card.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/dialogs.dart';
import 'package:muda_facil/src/utils/general.dart';
import 'package:muda_facil/src/widgets/icon_row.dart';

class PendingOrderCard extends ConsumerWidget {
  const PendingOrderCard({
    super.key,
    required this.order,
    required this.onSave,
    required this.onConfirm,
    required this.status,
  });

  final MovingOrder order;
  final Function({
    required String driverName,
    required double budgetValue,
    required String pixCode,
  }) onSave;
  final Function() onConfirm;
  final OrderStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrderCard(
        clickable: isStatusInterable(status),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(kDefaultPadding / 4),
                color: getColorByStatus(context, status: status),
                child: Text(
                  getOrderStatusLabelByEnumName(status.name),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        height: 1.5,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            IconRow(
              iconData: Icons.home_filled,
              text: order.originAddress!,
            ),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            IconRow(
                iconData: Icons.location_on_outlined,
                text: order.destinyAddress!),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            IconRow(
              iconData: Icons.monetization_on_outlined,
              text: GeneralUtils.getCurrencyFormat(order.budgetValue ?? 0),
            ),
            const Divider(),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            if (order.movingDate != null)
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  GeneralUtils.formatDateFromTimestamp(
                      order.movingDate!.microsecondsSinceEpoch),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
              ),
          ],
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => status == OrderStatus.waitingPayment
                ? Dialogs.getConfirmDialog(
                    context,
                    onConfirm: onConfirm,
                  )
                : Dialogs.getBugetInfoDialog(
                    context,
                    onSave: onSave,
                  ),
          );
        });
  }
}
