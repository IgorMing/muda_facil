import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/controllers/user_controller.dart';
import 'package:muda_facil/src/features/onboarding/onboarding.dart';
import 'package:muda_facil/src/features/onboarding/widgets/expanded_button.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/validators.dart';

class OnboardingNameStep extends ConsumerStatefulWidget {
  const OnboardingNameStep({
    super.key,
    required this.onNext,
  });

  final Function onNext;

  @override
  ConsumerState<OnboardingNameStep> createState() => _OnboardingNameStepState();
}

class _OnboardingNameStepState extends ConsumerState<OnboardingNameStep> {
  late final TextEditingController _textController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    final userName = ref.read(userControllerProvider)?.name;
    _textController = TextEditingController(text: userName);
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
    final notifier = ref.read(userControllerProvider.notifier);

    void onFinishEditting() {
      if (_formKey.currentState!.validate()) {
        notifier.setFullName(_textController.text);
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
              'Digite seu nome completo',
              style: theme.textTheme.bodyLarge!
                  .copyWith(color: theme.colorScheme.onPrimary),
            ),
            const SizedBox(height: kDefaultPadding),
            Form(
              key: _formKey,
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                cursorHeight: 42,
                cursorColor: Colors.grey.shade400,
                controller: _textController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                style: textStyle.copyWith(height: 1.4),
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: theme.colorScheme.error),
                  hintText: 'E.g. João da Silva',
                  hintStyle: textStyle.copyWith(
                      color: theme.colorScheme.onPrimary.withOpacity(0.2)),
                  labelText: 'Nome completo',
                  labelStyle: theme.primaryTextTheme.bodyLarge,
                  focusedBorder: getBorder(theme),
                  enabledBorder: getBorder(theme, lineWidth: 2.0),
                ),
                validator: (value) =>
                    value != null && Validators.hasSpaceBetween(value)
                        ? null
                        : 'Preencha o nome completo',
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            Row(
              children: [
                ExpandedButton(
                  text: 'Avançar',
                  onPressed: () {
                    onFinishEditting();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
