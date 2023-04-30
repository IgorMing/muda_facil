import 'package:flutter/material.dart';
import 'package:muda_facil/src/features/onboarding/name_step.dart';
import 'package:muda_facil/src/features/onboarding/phone_step.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        children: [
          OnboardingNameStep(onNext: () {
            _navigate(1);
          }),
          OnboardingPhoneStep(
            onBack: () {
              _navigate(0);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _navigate(int pageIndex) {
    return _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInToLinear,
    );
  }
}

UnderlineInputBorder getBorder(ThemeData theme, {double lineWidth = 1.0}) {
  return UnderlineInputBorder(
    borderSide: BorderSide(
      width: lineWidth,
      color: theme.colorScheme.onPrimary,
    ),
  );
}
