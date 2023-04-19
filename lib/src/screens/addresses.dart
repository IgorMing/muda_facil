import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/utils/constants.dart';

class AddressesScreen extends ConsumerWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(userOrderOrNullProvider);
    final userOrder = ref.read(userOrderOrNullProvider.notifier);
    final formKey = GlobalKey<FormState>();

    final fromController = TextEditingController(text: order?.originAddress);
    final toController = TextEditingController(text: order?.destinyAddress);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Endereços'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            userOrder.create();
            userOrder.setAddresses(
              from: fromController.text,
              to: toController.text,
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        child: const Icon(Icons.navigate_next_outlined),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AddressField(
                  autoFocus: fromController.text.isEmpty,
                  label: "De",
                  controller: fromController,
                  required: true,
                ),
                const SizedBox(height: kDefaultPadding),
                AddressField(
                  autoFocus: fromController.text.isNotEmpty,
                  label: "Para",
                  controller: toController,
                ),
                const SizedBox(height: kDefaultPadding),
                const Padding(
                  padding: EdgeInsets.all(kDefaultPadding * 2),
                  child: Text(
                    'Adicione a informação completa do endereço. Exemplo: Rua José Roberto, n. 23, Bairro, Cidade-UF',
                    style: TextStyle(fontStyle: FontStyle.italic, height: 1.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddressField extends StatelessWidget {
  const AddressField({
    super.key,
    required this.controller,
    required this.label,
    this.required = false,
    this.autoFocus = false,
  });

  final String label;
  final TextEditingController controller;
  final bool required;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: kDefaultMaxLines,
      autofocus: autoFocus,
      validator: (value) {
        if (!required) return null;
        return value!.isEmpty ? "Este campo é obrigatório" : null;
      },
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
