import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/items/items.providers.dart';
import 'package:muda_facil/src/features/items/items.state.dart';
import 'package:muda_facil/src/features/items/items_admin.screen.dart';
import 'package:muda_facil/src/features/orders/needing_help.screen.dart';
import 'package:muda_facil/src/features/orders/orders.bloc.dart';
import 'package:muda_facil/src/features/orders/orders.providers.dart';
import 'package:muda_facil/src/features/orders/orders.screen.dart';
import 'package:muda_facil/src/features/orders/widgets/badge_card.dart';
import 'package:muda_facil/src/screens/error.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/widgets/loading_adaptive.dart';

class AdminHome extends ConsumerStatefulWidget {
  const AdminHome({super.key});

  @override
  ConsumerState<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends ConsumerState<AdminHome> {
  late final Orders ordersNotifier;
  late final CandidatesListState candidatesNotifier;

  @override
  void initState() {
    ordersNotifier = ref.read(ordersProvider.notifier)..subscribe();
    candidatesNotifier = ref.read(candidatesListStateProvider.notifier)
      ..subscribe();

    super.initState();
  }

  @override
  void dispose() {
    ordersNotifier.unsubscribe();
    candidatesNotifier.unsubscribe();
    ref.invalidate(ordersProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pendingCount = ref.watch(adminPendingCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: pendingCount.when(
          data: (data) => ListView(
            children: [
              BadgeCard(
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OrdersScreen(),
                  ));
                },
                label: 'Mudanças',
                description:
                    'Aqui podem ser encontradas todas as mudanças pendentes',
                value: data["orders"],
              ),
              const SizedBox(height: kDefaultPadding),
              BadgeCard(
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ItemsAdminScreen(),
                  ));
                },
                label: 'Itens inéditos',
                description:
                    'Itens que entraram em algum pedido, e não estão disponíveis no auto complete do usuário',
                value: data["items"],
              ),
              const SizedBox(height: kDefaultPadding),
              BadgeCard(
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NeedingHelpScreen(),
                  ));
                },
                label: 'Pedidos de ajuda',
                description:
                    'Pedidos que estão com pendência de retorno de ajuda',
                value: data["helpNeeded"],
              ),
            ],
          ),
          error: (error, stackTrace) =>
              const ErrorScreen('Algo inesperado aconteceu'),
          loading: () => const LoadingAdaptive(),
        ),
      ),
    );
  }
}
