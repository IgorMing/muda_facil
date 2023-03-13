import 'package:flutter/material.dart';
import 'package:muda_facil/src/screens/items.dart';
import 'package:muda_facil/src/utils/constants.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Endereços'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ItemsScreen(),
            ));
          },
          child: const Icon(Icons.navigate_next_outlined),
        ),
        body: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: const [
              AddressField(label: "De"),
              SizedBox(height: kDefaultPadding),
              AddressField(label: "Para"),
              SizedBox(height: kDefaultPadding),
              Padding(
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
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
      ),
      autocorrect: false,
      textCapitalization: TextCapitalization.words,
    );
  }
}
