import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/orders/orders.bloc.dart';
import 'package:muda_facil/src/features/orders/widgets/badge_button.dart';
import 'package:muda_facil/src/utils/constants.dart';

class AdminHome extends ConsumerStatefulWidget {
  const AdminHome({super.key});

  @override
  ConsumerState<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends ConsumerState<AdminHome> {
  late final Orders ordersNotifier;

  @override
  void initState() {
    ordersNotifier = ref.read(ordersProvider.notifier);
    ordersNotifier.subscribe();
    super.initState();
  }

  @override
  void dispose() {
    ordersNotifier.unsubscribe();
    ref.invalidate(ordersProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            BadgeButton(
              onPress: () {},
              label: 'Mudanças',
              description:
                  'Aqui podem ser encontradas todas as mudanças pendentes',
              value: orders.length.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
