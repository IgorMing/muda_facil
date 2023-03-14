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
            color: Theme.of(context).primaryColorDark.withOpacity(0.4)),
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

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.actions,
    required this.order,
  });

  final MovingOrder order;
  final UserOrder actions;

  @override
  Widget build(BuildContext context) {
    final movingDateMs = order.movingDate?.microsecondsSinceEpoch;

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
        if (GeneralUtils.isFilled(order.originAddress))
          InfoRow(
            label: "Origem",
            value: order.originAddress,
          ),
        if (GeneralUtils.isFilled(order.destinyAddress))
          InfoRow(
            label: "Destino",
            value: order.destinyAddress,
          ),
        if (movingDateMs != null)
          InfoRow(
            label: "Data",
            value: GeneralUtils.formatDateFromTimestamp(movingDateMs),
          ),
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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ItemsScreen(),
            ));
          },
          title: GeneralUtils.isFilledArray(order.items)
              ? 'Editar Itens'
              : 'Adicionar itens',
          checked: GeneralUtils.isFilledArray(order.items),
        ),
        if (actions.allCompleted)
          ElevatedButton(
            onPressed: () {},
            child: const Text('Confirmar'),
          ),
      ],
    );
  }
}
