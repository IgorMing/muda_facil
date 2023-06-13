import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/orders/widgets/order_card.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/dialogs.dart';
import 'package:muda_facil/src/utils/general.dart';

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
        clickable: status == OrderStatus.waitingDriver ||
            status == OrderStatus.waitingPayment,
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
            AddressRow(
              iconData: Icons.home_filled,
              text: order.originAddress!,
            ),
            const Divider(),
            AddressRow(
                iconData: Icons.location_on_outlined,
                text: order.destinyAddress!),
            const SizedBox(
              height: kDefaultPadding,
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
            builder: (context) => status == OrderStatus.waitingDriver
                ? Dialogs.getBugetInfoDialog(
                    context,
                    onSave: onSave,
                  )
                : Dialogs.getConfirmDialog(
                    context,
                    onConfirm: onConfirm,
                  ),
          );
        });
  }
}

class AddressRow extends StatelessWidget {
  const AddressRow({
    super.key,
    required this.text,
    required this.iconData,
  });

  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(
          width: kDefaultPadding / 2,
        ),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
