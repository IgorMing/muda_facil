import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';

class LoadingAdaptive extends StatelessWidget {
  const LoadingAdaptive({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        strokeWidth: kDefaultPadding,
      ),
    );
  }
}
