import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/app_user.dart';
import 'package:muda_facil/src/features/onboarding/onboarding.dart';
import 'package:muda_facil/src/screens/bottom_navigation.dart';

class Authenticated extends ConsumerStatefulWidget {
  const Authenticated({super.key});

  @override
  ConsumerState<Authenticated> createState() => _AuthenticatedState();
}

class _AuthenticatedState extends ConsumerState<Authenticated> {
  late final AppUser appUserNotifier;

  @override
  void initState() {
    appUserNotifier = ref.read(appUserProvider.notifier);
    appUserNotifier.subscribe();
    super.initState();
  }

  @override
  void dispose() {
    appUserNotifier.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appUser = ref.watch(appUserProvider);

    if (appUser != null && appUser.onboardingCompleted) {
      return BottomNavigation(appUser);
    } else {
      return const OnboardingScreen();
    }
  }
}
