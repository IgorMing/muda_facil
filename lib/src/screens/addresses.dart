import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/screens/items.dart';
import 'package:muda_facil/src/utils/constants.dart';

class AddressesScreen extends ConsumerWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(userOrderOrNullProvider);
    final userOrder = ref.read(userOrderOrNullProvider.notifier);

    final fromController = TextEditingController(text: order!.originAddress);
    final toController = TextEditingController(text: order.destinyAddress);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Endereços'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            userOrder.create();
            if (fromController.text.isNotEmpty ||
                toController.text.isNotEmpty) {
              userOrder.setAddresses(
                  from: fromController.text, to: toController.text);
            }
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ItemsScreen(),
            ));
          },
          child: const Icon(Icons.navigate_next_outlined),
        ),
        body: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              AddressField(
                label: "De",
                controller: fromController,
              ),
              const SizedBox(height: kDefaultPadding),
              AddressField(
                label: "Para",
                controller: toController,
              ),
              const SizedBox(height: kDefaultPadding),
              const Padding(
                padding: EdgeInsets.all(kDefaultPadding * 2),
                child: Text(
                  'Estes campos podem ser preenchidos mais tarde, se quiser',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class AddressField extends StatelessWidget {
  const AddressField({
    super.key,
    required this.controller,
    required this.label,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
      ),
      autocorrect: false,
      textCapitalization: TextCapitalization.words,
    );
  }
}
