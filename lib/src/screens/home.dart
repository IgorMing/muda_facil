import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/app_user.dart';
import 'package:muda_facil/src/features/my_order/my_order.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/widgets/loading_adaptive.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserProvider);

    if (user == null) return const LoadingAdaptive();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kDefaultPadding * 2),
            Text('Bem vindo, ${user.name}'),
            const SizedBox(height: kDefaultPadding / 2),
            const MyOrder(),
          ],
        ),
      ),
    );
  }
}
