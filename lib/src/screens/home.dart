import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/controllers/app_user.dart';
import 'package:muda_facil/src/features/my_order/my_order.dart';
import 'package:muda_facil/src/utils/constants.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Bem vindo, ${user!.name}')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: MyOrder(),
        ),
      ),
    );
  }
}
