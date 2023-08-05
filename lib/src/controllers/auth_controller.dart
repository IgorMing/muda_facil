import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:muda_facil/src/repositories/auth_repository.dart';

class AuthController extends StateNotifier<AsyncValue<User?>> {
  final Ref _ref;

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._ref) : super(const AsyncValue.loading()) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription =
        _ref.read(authRepositoryProvider).authStateChanges.listen((event) {
      state = AsyncValue.data(event);
    });
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<User?>>(
        (ref) => AuthController(ref));
