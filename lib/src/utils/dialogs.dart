import 'package:flutter/material.dart';

class Dialogs {
  static AlertDialog getBudgetInfoDialog() {
    return AlertDialog(
      title: const Text('Budget info'),
      content: Form(
          child: Column(
        children: const [],
      )),
    );
  }

  static AlertDialog getSingleInputDialog(
    BuildContext context, {
    required String title,
    required bool requireMinLength,
    required minLength,
    required Function(String text) onSave,
    required String cancelButtonText,
    required String confirmButtonText,
    String? initialText,
  }) {
    final controller = TextEditingController(text: initialText);
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: TextFormField(
          validator: (value) {
            if (!requireMinLength) {
              return null;
            }

            if (value == null || value.length < minLength) {
              return 'Digite ao menos $minLength caracteres';
            }

            return null;
          },
          controller: controller,
          autofocus: true,
          autocorrect: false,
          textCapitalization: TextCapitalization.sentences,
          onSaved: (newValue) {
            onSave(controller.text);
            Navigator.of(context).pop();
          },
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(),
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(cancelButtonText),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
            }
          },
          child: Text(confirmButtonText),
        ),
      ],
    );
  }
}
