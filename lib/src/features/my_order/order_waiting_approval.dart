import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/ui.dart';
import 'package:muda_facil/src/widgets/checkable_button.dart';

class OrderWaitingApproval extends StatelessWidget {
  const OrderWaitingApproval({
    super.key,
    required this.onDecline,
    required this.onSave,
    required this.driverName,
    required this.budgetValue,
  });

  final String driverName;
  final double budgetValue;
  final Function(String reason) onDecline;
  final Function() onSave;

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
            Text(driverName),
            Text('R\$ ${budgetValue.toInt()}'),
            const SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    UIUtils.of(context).showInputDialog(
                      onSave: onDecline,
                      title: 'Explique o motivo, por favor',
                      requireMinLength: true,
                    );
                  },
                  child: const Text('Não gostei'),
                ),
                CheckableButton(
                  title: 'Aceito',
                  onPressed: onSave,
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
