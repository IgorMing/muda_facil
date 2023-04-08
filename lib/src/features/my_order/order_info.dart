import 'package:flutter/material.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/features/my_order/editButtons.dart';
import 'package:muda_facil/src/features/my_order/order_declined.dart';
import 'package:muda_facil/src/features/my_order/order_help.dart';
import 'package:muda_facil/src/features/my_order/order_waiting_approval.dart';
import 'package:muda_facil/src/features/my_order/order_waiting_driver.dart';
import 'package:muda_facil/src/features/my_order/order_waiting_payment.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/general.dart';
import 'package:muda_facil/src/utils/ui.dart';
import 'package:muda_facil/src/widgets/info_row.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({
    super.key,
    required this.actions,
    required this.order,
  });

  final MovingOrder order;
  final UserOrder actions;

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final movingDateMs = widget.order.movingDate?.microsecondsSinceEpoch;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Minha mudança',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (widget.actions.canDeleteOrder)
              IconButton(
                onPressed: () {
                  UIUtils.showAlertDialog(
                    context,
                    text:
                        'Esta ação é irreversível, e vai apagar toda a solicitação.',
                    onSelect: (selectedValue) {
                      if (selectedValue) widget.actions.deleteOrder();
                    },
                  );
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
          ],
        ),
        Divider(color: Theme.of(context).primaryColorDark),
        InfoRow(
          label: "Status",
          value: getOrderStatusLabelByEnumName(widget.order.status.name),
        ),
        if (GeneralUtils.isFilled(widget.order.originAddress))
          InfoRow(
            label: "Origem",
            value: widget.order.originAddress,
          ),
        if (GeneralUtils.isFilled(widget.order.destinyAddress))
          InfoRow(
            label: "Destino",
            value: widget.order.destinyAddress,
          ),
        if (movingDateMs != null)
          InfoRow(
            label: "Data",
            value: GeneralUtils.formatDateFromTimestamp(movingDateMs),
          ),
        if (widget.order.items.isNotEmpty)
          InfoRow(
            label: "Itens",
            value: GeneralUtils.getFormattedItems(widget.order.items),
            showAll: true,
          ),
        Divider(color: Theme.of(context).primaryColorDark),
        if (widget.actions.canShowEditButtons)
          ...getEditButtons(
            context: context,
            order: widget.order,
            actions: widget.actions,
            onChangeDateEphemeral: (selected) {
              setState(() {
                _selectedDate = selected;
              });
            },
            onChangeDate: (selected) {
              widget.actions.setMovingDate(selected);
            },
            selectedDate: _selectedDate,
          ),
        if (widget.order.status == OrderStatus.waitingDriver)
          const OrderWaitingDriver(),
        if (widget.order.status == OrderStatus.waitingApproval)
          OrderWaitingApproval(
            driverName: widget.order.driverName!,
            budgetValue: widget.order.budgetValue!,
            onDecline: (String reason) {
              widget.actions.declineBudget(reason);
            },
            onSave: () {
              UIUtils.showLoaderDialog(context, action: () {
                widget.actions.setStatus(OrderStatus.waitingPayment);
              });
            },
          ),
        if (widget.order.status == OrderStatus.declined)
          OrderDeclined(reason: widget.order.declineReason!),
        if (widget.order.status == OrderStatus.waitingPayment)
          const OrderWaitingPayment(),
        OrderHelp(onSave: widget.actions.setHelp),
      ],
    );
  }
}
