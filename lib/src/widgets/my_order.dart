import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/widgets/checkable_button.dart';
import 'package:muda_facil/src/widgets/info_row.dart';

class MyOrder extends ConsumerWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userOrder = ref.watch(userOrderProvider);
    final actions = ref.read(userOrderProvider.notifier);

    final movingDateMs = userOrder?.movingDate?.microsecondsSinceEpoch;
    final originAddress = userOrder?.originAddress;
    final destinyAddress = userOrder?.destinyAddress;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding * 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).primaryColorDark.withOpacity(0.4)),
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Column(
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
          if (originAddress != null)
            InfoRow(
              label: "Origem",
              value: originAddress,
            ),
          if (destinyAddress != null)
            InfoRow(
              label: "Destino",
              value: destinyAddress,
            ),
          if (movingDateMs != null)
            InfoRow(
              label: "Data",
              value: DateFormat('dd/MM/yyyy H:m')
                  .format(DateTime.fromMicrosecondsSinceEpoch(movingDateMs)),
            ),
          CheckableButton(
            title: originAddress == null ? "Origem" : 'Editar origem',
            checked: originAddress != null,
          ),
          CheckableButton(
            title: destinyAddress == null ? "Destino" : 'Editar destino',
            checked: destinyAddress != null,
          ),
          const CheckableButton(
            title: 'Editar Itens',
            checked: true,
          ),
          if (actions.allCompleted)
            ElevatedButton(
              onPressed: () {},
              child: const Text('Confirmar'),
            ),
        ],
      ),
    );
  }
}
