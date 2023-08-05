import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:muda_facil/src/controllers/app_user.dart';
import 'package:muda_facil/src/features/onboarding/onboarding.dart';
import 'package:muda_facil/src/features/onboarding/widgets/expanded_button.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/ui.dart';

const int kMinNumberTextLen = 14;

class OnboardingPhoneStep extends ConsumerStatefulWidget {
  const OnboardingPhoneStep({
    super.key,
    required this.onBack,
  });

  final Function onBack;

  @override
  ConsumerState<OnboardingPhoneStep> createState() =>
      _OnboardingPhoneStepState();
}

class _OnboardingPhoneStepState extends ConsumerState<OnboardingPhoneStep> {
  late final TextEditingController _textController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    final userPhone = ref.read(appUserProvider)?.phone;
    _textController = TextEditingController(text: userPhone);
    _formKey = GlobalKey<FormState>();
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
    final notifier = ref.read(appUserProvider.notifier);

    void onFinishEditting() {
      if (_formKey.currentState!.validate()) {
        UIUtils.of(context).showLoaderDialog(() {
          notifier.setPhone(_textController.text);
        });
      }
    }

    return WillPopScope(
      onWillPop: () async {
        widget.onBack();
        return false;
      },
      child: Container(
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
                'Qual seu número para contato?',
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: theme.colorScheme.onPrimary),
              ),
              const SizedBox(height: kDefaultPadding),
              Form(
                key: _formKey,
                child: TextFormField(
                  cursorHeight: 42,
                  cursorColor: Colors.grey.shade400,
                  controller: _textController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '(##) #####-####',
                      filter: {'#': RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy,
                    ),
                  ],
                  style: textStyle.copyWith(height: 1.4),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: theme.colorScheme.error),
                    hintText: '(19) 99999-9999',
                    hintStyle: textStyle.copyWith(
                        color: theme.colorScheme.onPrimary.withOpacity(0.2)),
                    labelText: 'Celular',
                    labelStyle: theme.primaryTextTheme.bodyLarge,
                    focusedBorder: getBorder(theme),
                    border: getBorder(theme, lineWidth: 2.0),
                    enabledBorder: getBorder(theme, lineWidth: 2.0),
                  ),
                  validator: (value) => value!.length < kMinNumberTextLen
                      ? 'Preencha o número completo'
                      : null,
                ),
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        widget.onBack();
                      },
                      child: Text(
                        'Voltar',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: theme.colorScheme.onPrimary),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: kDefaultPadding,
                  ),
                  ExpandedButton(
                    text: 'Avançar',
                    onPressed: () {
                      onFinishEditting();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
