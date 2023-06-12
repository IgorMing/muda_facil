import 'package:flutter/material.dart';
import 'package:muda_facil/src/screens/addresses.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

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
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddressesScreen()));
              await FirebaseAnalytics.instance.logEvent(name: 'create_order');
            },
            child: const Text('Iniciar mudança'),
          )
        ],
      ),
    );
  }
}
