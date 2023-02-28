import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/screens/items.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  bool isEditting = false;
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = user!.email ?? '';

    super.initState();
  }

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
