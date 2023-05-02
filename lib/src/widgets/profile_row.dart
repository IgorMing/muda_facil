import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    required this.label,
    this.value,
  });

  final String? value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: TextField(
        enabled: false,
        controller: TextEditingController(text: value),
        decoration: InputDecoration(
          label: Text(label),
        ),
      ),
    );
  }
}
