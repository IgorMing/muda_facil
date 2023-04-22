import 'package:flutter/material.dart';
import 'package:muda_facil/src/layouts/onboarding_step.dart';

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
          OnboardingStep(
            'screen 1',
            onNext: () {
              _navigate(1);
            },
          ),
          OnboardingStep(
            'screen 2',
            onNext: () {
              _navigate(2);
            },
          ),
          OnboardingStep(
            'screen 3',
            onNext: () {
              _navigate(0);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _navigate(int pageIndex) {
    return _pageController.animateToPage(pageIndex,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }
}
