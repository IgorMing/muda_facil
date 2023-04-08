import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/widgets/loading_adaptive.dart';

class OrderWaitingDriver extends StatelessWidget {
  const OrderWaitingDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding * 1),
      child: Column(
        children: const [
          Text(
              'Prontinho! Basta aguardar nossa equipe encontrar o frete ideal pra você.'),
          SizedBox(
            height: kDefaultPadding,
          ),
          LoadingAdaptive(),
        ],
      ),
    );
  }
}
