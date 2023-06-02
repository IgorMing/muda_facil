import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/dialogs.dart';
import 'package:muda_facil/src/utils/general.dart';
import 'package:muda_facil/src/widgets/info_row.dart';

class OrderCard extends ConsumerWidget {
  const OrderCard({
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
    final clickable = status == OrderStatus.waitingDriver ||
        status == OrderStatus.waitingPayment;

    return Card(
      shape: _roundedRectangleBorder,
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.primary,
        onTap: () {
          if (!clickable) return;

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
        },
        customBorder: _roundedRectangleBorder,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(kDefaultPadding / 4),
                  color: _getColorByStatus(context, status: status),
                  child: Text(
                    getOrderStatusLabelByEnumName(status.name),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          height: 1.5,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              InfoRow(
                label: 'De',
                value: order.originAddress,
              ),
              const Divider(),
              InfoRow(
                label: 'Para',
                value: order.destinyAddress,
              ),
              if (order.movingDate != null)
                Center(
                  child: InfoRow(
                    label: 'Data',
                    value: GeneralUtils.formatDateFromTimestamp(
                        order.movingDate!.microsecondsSinceEpoch),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

const _roundedRectangleBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(kDefaultPadding)),
);

Color _getColorByStatus(BuildContext context, {required OrderStatus status}) {
  final colorScheme = Theme.of(context).colorScheme;

  switch (status) {
    case OrderStatus.waitingDriver:
    case OrderStatus.waitingPayment:
      return kWarningColor;
    case OrderStatus.helpNeeded:
    case OrderStatus.declined:
      return colorScheme.error;
    case OrderStatus.waitingApproval:
    case OrderStatus.approved:
    case OrderStatus.pending:
      return kSuccessColor;
  }
}
