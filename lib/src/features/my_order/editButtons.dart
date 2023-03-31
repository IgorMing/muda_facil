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

List<Widget> getEditButtons({
  required BuildContext context,
  required MovingOrder order,
  required UserOrder actions,
  required Function(DateTime selected) onChangeDateEphemeral,
  required Function(DateTime selected) onChangeDate,
  DateTime? selectedDate,
}) {
  return [
    CheckableButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AddressesScreen(),
        ));
      },
      title: !GeneralUtils.isFilled(order.originAddress)
          ? "Origem"
          : 'Editar origem',
      checked: GeneralUtils.isFilled(order.originAddress),
    ),
    CheckableButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AddressesScreen(),
        ));
      },
      title: !GeneralUtils.isFilled(order.destinyAddress)
          ? "Destino"
          : 'Editar destino',
      checked: GeneralUtils.isFilled(order.destinyAddress),
    ),
    CheckableButton(
      title: !GeneralUtils.isFilled(order.movingDate?.toIso8601String())
          ? 'Data'
          : 'Editar data',
      checked: GeneralUtils.isFilled(order.movingDate?.toIso8601String()),
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
                          if (selectedDate != null) {
                            onChangeDate(selectedDate);
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
                        initialDateTime: order.movingDate ?? now,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: onChangeDateEphemeral,
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
            onChangeDate(selectedDate);
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
      title: GeneralUtils.isFilledArray(order.items) ? 'Editar Itens' : 'Itens',
      checked: GeneralUtils.isFilledArray(order.items),
    ),
    if (actions.allCompleted)
      FullWidthButton(
        title: 'Revisão geral',
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const GeneralReviewScreen(),
          ));
        },
      ),
  ];
}
