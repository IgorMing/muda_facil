import 'package:flutter/material.dart';

class LoadingAdaptive extends StatelessWidget {
  const LoadingAdaptive({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
