import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/widgets/checkable_button.dart';

class OrderWaitingApproval extends StatelessWidget {
  const OrderWaitingApproval({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Center(
        child: Column(
          children: [
            const Text('Encontramos um frete!'),
            const SizedBox(
              height: kDefaultPadding,
            ),
            const Icon(
              Icons.fire_truck_outlined,
              size: 45,
            ),
            const SizedBox(height: kDefaultPadding / 2),
            const Text('Antonio Silva'),
            const Text('R\$ 1250'),
            const SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Não gostei'),
                ),
                CheckableButton(
                  title: 'Aceito',
                  onPressed: () {},
                  checked: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
