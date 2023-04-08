import 'package:flutter/material.dart';
import 'package:muda_facil/src/screens/addresses.dart';
import 'package:muda_facil/src/utils/constants.dart';

class NoOrderInfo extends StatelessWidget {
  const NoOrderInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Nenhuma mudança até o momento...'),
          const SizedBox(
            height: kDefaultPadding,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddressesScreen()));
            },
            child: const Text('Iniciar mudança'),
          )
        ],
      ),
    );
  }
}
