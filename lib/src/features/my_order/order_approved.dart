import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';

class OrderApproved extends StatelessWidget {
  const OrderApproved({super.key, required this.driverName});

  final String driverName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.check_outlined,
            color: kSuccessColor,
            size: 50.0,
          ),
          RichText(
            text: TextSpan(
                text: 'Tudo certo! ',
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  const TextSpan(
                      text: 'Sua mudança está confirmada com o motorista '),
                  TextSpan(
                    text: driverName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
