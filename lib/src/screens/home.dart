import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/screens/items.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/ui.dart';
import 'package:muda_facil/src/widgets/my_order.dart';

class HomeScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Text('Bem vindo, ${user!.email}'),
                IconButton(
                  onPressed: () {
                    UIUtils.showInputDialog(context, onSave: () {});
                  },
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
            const MyOrder(),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ItemsScreen()));
              },
              child: const Text('Iniciar mudança'),
            )
          ],
        ),
      ),
    );
  }
}
