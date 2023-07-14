import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/app_user.dart';
import 'package:muda_facil/src/features/items/items.providers.dart';
import 'package:muda_facil/src/features/items/items.state.dart';
import 'package:muda_facil/src/features/onboarding/onboarding.dart';
import 'package:muda_facil/src/screens/bottom_navigation.dart';
import 'package:muda_facil/src/widgets/loading_adaptive.dart';

class Authenticated extends ConsumerStatefulWidget {
  const Authenticated({super.key});

  @override
  ConsumerState<Authenticated> createState() => _AuthenticatedState();
}

class _AuthenticatedState extends ConsumerState<Authenticated> {
  late final AppUser appUserNotifier;
  late final AutocompleteListState autocompleteNotifier;

  @override
  void initState() {
    appUserNotifier = ref.read(appUserProvider.notifier)..subscribe();
    autocompleteNotifier = ref.read(autocompleteListStateProvider.notifier)
      ..subscribe();

    super.initState();
  }

  @override
  void dispose() {
    autocompleteNotifier.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appUser = ref.watch(appUserProvider);

    if (appUser == null) {
      return const Scaffold(
        body: LoadingAdaptive(),
      );
    }

    if (appUser.onboardingCompleted) {
      return BottomNavigation(appUser);
    } else {
      return const OnboardingScreen();
    }
  }
}
