import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/ui.dart';

class OrderWaitingPayment extends StatelessWidget {
  const OrderWaitingPayment({super.key, required this.pixCode});

  final String pixCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Center(
        child: Column(
          children: [
            const Text(
              'Copie e cole este código pix',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: kDefaultPadding / 2),
            SelectableText(pixCode),
            const SizedBox(height: kDefaultPadding / 2),
            ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: pixCode));
                UIUtils.showSnackBar(
                  context,
                  'O código pix foi copiado.',
                  success: true,
                );
              },
              icon: const Icon(Icons.copy_outlined),
              label: const Text('Copiar código pix'),
            ),
            const SizedBox(height: kDefaultPadding / 2),
            Text(
              'Após o pagamento ser registrado, iremos atualizar o status de sua solicitação.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
