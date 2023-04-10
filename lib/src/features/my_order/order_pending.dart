import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/screens/addresses.dart';
import 'package:muda_facil/src/screens/general_review.dart';
import 'package:muda_facil/src/screens/items.dart';
import 'package:muda_facil/src/utils/general.dart';
import 'package:muda_facil/src/widgets/checkable_button.dart';
import 'package:muda_facil/src/widgets/full_width_button.dart';

class OrderPending extends StatefulWidget {
  const OrderPending({
    super.key,
    required this.order,
    required this.actions,
    required this.onChangeDate,
  });

  final MovingOrder order;
  final UserOrder actions;
  final Function(DateTime selected) onChangeDate;

  @override
  State<OrderPending> createState() => _OrderPendingState();
}

class _OrderPendingState extends State<OrderPending> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckableButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddressesScreen(),
            ));
          },
          title: !GeneralUtils.isFilled(widget.order.originAddress)
              ? "Origem"
              : 'Editar origem',
          checked: GeneralUtils.isFilled(widget.order.originAddress),
        ),
        CheckableButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddressesScreen(),
            ));
          },
          title: !GeneralUtils.isFilled(widget.order.destinyAddress)
              ? "Destino"
              : 'Editar destino',
          checked: GeneralUtils.isFilled(widget.order.destinyAddress),
        ),
        CheckableButton(
          title:
              !GeneralUtils.isFilled(widget.order.movingDate?.toIso8601String())
                  ? 'Data'
                  : 'Editar data',
          checked:
              GeneralUtils.isFilled(widget.order.movingDate?.toIso8601String()),
          onPressed: () async {
            final now = DateTime.now();

            if (Platform.isIOS) {
              final containerHeight = MediaQuery.of(context).size.height / 3;
              showCupertinoModalPopup(
                context: context,
                builder: (context) => Container(
                  height: containerHeight,
                  padding: const EdgeInsets.only(top: 6.0),
                  // The Bottom margin is provided to align the popup above the system
                  // navigation bar.
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  // Provide a background color for the popup.
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  // Use a SafeArea widget to avoid system overlaps.
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar'),
                          ),
                          CupertinoButton(
                            onPressed: () {
                              if (_selectedDate != null) {
                                widget.onChangeDate(_selectedDate!);
                              }
                              Navigator.of(context).pop();
                            },
                            child: const Text('Confirmar'),
                          ),
                        ],
                      ),
                      SafeArea(
                        top: false,
                        child: SizedBox(
                          height: containerHeight - 100,
                          child: CupertinoDatePicker(
                            minimumDate: now,
                            maximumDate: DateTime(now.year + 1),
                            initialDateTime: widget.order.movingDate ?? now,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (value) {
                              setState(() {
                                _selectedDate = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: now,
                lastDate: DateTime(now.year + 1),
              );
              if (selectedDate != null) {
                widget.onChangeDate(selectedDate);
              }
            }
          },
        ),
        CheckableButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ItemsScreen(),
            ));
          },
          title: GeneralUtils.isFilledArray(widget.order.items)
              ? 'Editar Itens'
              : 'Itens',
          checked: GeneralUtils.isFilledArray(widget.order.items),
        ),
        if (widget.actions.allCompleted)
          FullWidthButton(
            title: 'Revisão geral',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const GeneralReviewScreen(),
              ));
            },
          )
      ],
    );
  }
}
