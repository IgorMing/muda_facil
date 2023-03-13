import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/screens/addresses.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/widgets/my_order.dart';

class HomeScreen extends ConsumerWidget {
  final user = FirebaseAuth.instance.currentUser;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userOrder = ref.watch(userOrderProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bem vindo, ${user!.email}'),
            const SizedBox(height: kDefaultPadding * 2),
            const MyOrder(),
            if (userOrder == null)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddressesScreen()));
                },
                child: const Text('Iniciar mudança'),
              ),
          ],
        ),
      ),
    );
  }
}
