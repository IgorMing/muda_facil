import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/my_order/my_order.dart';
import 'package:muda_facil/src/utils/constants.dart';

class HomeScreen extends ConsumerWidget {
  final user = FirebaseAuth.instance.currentUser;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kDefaultPadding * 2),
            Text('Bem vindo, ${user!.email}'),
            const SizedBox(height: kDefaultPadding / 2),
            const MyOrder(),
          ],
        ),
      ),
    );
  }
}
