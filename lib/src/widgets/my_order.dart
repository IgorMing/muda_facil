import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/screens/addresses.dart';
import 'package:muda_facil/src/screens/items.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/general.dart';
import 'package:muda_facil/src/widgets/checkable_button.dart';
import 'package:muda_facil/src/widgets/info_row.dart';

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
          ? const Text('Nenhuma mudança até o momento...')
          : Info(
              order: userOrder,
              actions: actions,
            ),
    );
  }
}

class Info extends StatefulWidget {
  const Info({
    super.key,
    required this.actions,
    required this.order,
  });

  final MovingOrder order;
  final UserOrder actions;

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final movingDateMs = widget.order.movingDate?.microsecondsSinceEpoch;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Minha mudança',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Divider(color: Theme.of(context).primaryColorDark),
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
                                widget.actions.setMovingDate(_selectedDate!);
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
                            onDateTimeChanged: (DateTime selectedDate) {
                              setState(() {
                                _selectedDate = selectedDate;
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
                setState(() {
                  widget.actions.setMovingDate(selectedDate);
                });
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
          ElevatedButton(
            onPressed: () {},
            child: const Text('Confirmar'),
          ),
      ],
    );
  }
}
