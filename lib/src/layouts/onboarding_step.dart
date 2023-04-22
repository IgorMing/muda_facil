import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:muda_facil/src/utils/constants.dart';

const int kMinNumberTextLen = 14;

class OnboardingStep extends StatefulWidget {
  const OnboardingStep(this.text, {super.key, required this.onNext});

  final String text;
  final Function onNext;

  @override
  State<OnboardingStep> createState() => _OnboardingStepState();
}

class _OnboardingStepState extends State<OnboardingStep> {
  late final TextEditingController _textController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _textController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.primaryTextTheme.bodyLarge!.copyWith(fontSize: 26);

    void onFinishEditting() {
      if (_formKey.currentState!.validate()) {
        FocusManager.instance.primaryFocus?.unfocus();
        widget.onNext();
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 2,
        vertical: kDefaultPadding,
      ),
      width: double.infinity,
      height: double.infinity,
      color: theme.colorScheme.primary,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: kDefaultPadding * 2),
            Text(
              '${widget.text}: Qual seu número para contato?',
              style: theme.textTheme.bodyLarge!
                  .copyWith(color: theme.colorScheme.onPrimary),
            ),
            const SizedBox(height: kDefaultPadding),
            Form(
              key: _formKey,
              child: TextFormField(
                // autofocus: true, // double check if this is working
                cursorColor: Colors.grey.shade400,
                controller: _textController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => onFinishEditting(),
                inputFormatters: [
                  MaskTextInputFormatter(
                    mask: '(##) #####-####',
                    filter: {'#': RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy,
                  ),
                ],
                style: textStyle,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: theme.colorScheme.error),
                  hintText: '(19) 99999-9999',
                  hintStyle: textStyle.copyWith(
                      color: theme.colorScheme.onPrimary.withOpacity(0.2)),
                  labelText: 'Celular',
                  labelStyle: theme.primaryTextTheme.bodyLarge,
                  focusedBorder: _getBorder(theme),
                  border: _getBorder(theme, lineWidth: 2.0),
                  enabledBorder: _getBorder(theme, lineWidth: 2.0),
                ),
                validator: (value) => value!.length < kMinNumberTextLen
                    ? 'Preencha o número completo'
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

UnderlineInputBorder _getBorder(ThemeData theme, {double lineWidth = 1.0}) {
  return UnderlineInputBorder(
    borderSide: BorderSide(
      width: lineWidth,
      color: theme.colorScheme.onPrimary,
    ),
  );
}
