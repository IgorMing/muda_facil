import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';

class Building extends StatelessWidget {
  const Building({super.key, required this.screenName});

  final String screenName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tela: $screenName. Em construção...'),
            const SizedBox(
              height: kDefaultPadding,
            ),
            const Icon(Icons.build_outlined),
          ],
        ),
      ),
    );
  }
}
