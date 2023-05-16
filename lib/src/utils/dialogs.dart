import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:muda_facil/src/utils/validators.dart';

class Dialogs {
  static AlertDialog getBugetInfoDialog(
    BuildContext context, {
    required Function({
      required String driverName,
      required double budgetValue,
      required String pixCode,
    })
        onSave,
  }) {
    final formKey = GlobalKey<FormState>();

    final driverNameController = TextEditingController();
    final budgetValueController = MoneyMaskedTextController();
    final budgetValueFocusNode = FocusNode();
    final pixCodeController = TextEditingController();

    return AlertDialog(
      title: const Text('Orçamento'),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: driverNameController,
                decoration: const InputDecoration(
                  label: Text('Nome do motorista'),
                ),
                onEditingComplete: () {
                  budgetValueFocusNode.requestFocus();
                },
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                validator: (value) => Validators.hasSpaceBetween(value!)
                    ? null
                    : 'O nome completo, por favor',
              ),
              TextFormField(
                controller: budgetValueController,
                focusNode: budgetValueFocusNode,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  label: Text('Valor do orçamento'),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (budgetValueController.numberValue > 0) {
                    return null;
                  }

                  return 'Informe um valor, por favor.';
                },
              ),
              TextFormField(
                controller: pixCodeController,
                decoration: InputDecoration(
                  label: const Text('Código pix'),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final clipboardData =
                          await Clipboard.getData(Clipboard.kTextPlain);
                      pixCodeController.text = clipboardData?.text ?? '';
                    },
                    icon: const Icon(Icons.paste_outlined),
                  ),
                ),
                style: Theme.of(context).textTheme.bodySmall,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  }

                  return 'Cole o código pix copiado, clicando no ícone.';
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              onSave(
                driverName: driverNameController.text,
                budgetValue: budgetValueController.numberValue,
                pixCode: pixCodeController.text,
              );
            }
          },
          child: const Text('Enviar'),
        ),
      ],
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
