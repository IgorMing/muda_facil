import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/user_order.dart';
import 'package:muda_facil/src/models/user_model.dart';
import 'package:muda_facil/src/providers/authentication.dart';
import 'package:muda_facil/src/services/auth.dart';

class AppUser extends StateNotifier<UserModel?> {
  late final AuthService authService;
  late final StateNotifierProviderRef<AppUser, UserModel?> _ref;
  late StreamSubscription<UserModel?> _subscription;

  AppUser(StateNotifierProviderRef<AppUser, UserModel?> ref) : super(null) {
    _ref = ref;
    authService = ref.read(authenticationProvider);
  }

  void subscribe() {
    _subscription = authService.onUserChanges.listen((event) {
      _ref.invalidate(userOrderOrNullProvider);
      state = event;
    });
  }

  void unsubscribe() {
    _subscription.cancel();
  }

  Future<UserModel?> getUser(String id) {
    return authService.getUserInfo(uid: id);
  }

  Future<void> signIn(String email, String password) {
    return authService.signInByEmailAndPassword(email, password);
  }

  Future<void> resetPassword(String email) {
    return authService.resetPasswordByEmail(email);
  }

  Future<void> signUp(String email, String password) async {
    await authService.signUpByEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    _ref.invalidate(appUserProvider);

    await _ref.read(userOrderOrNullProvider.notifier).cancelSubscription();
    await _subscription.cancel();

    return await authService.signOut();
  }

  setFullName(String fullName) async {
    state = state!.copyWith(name: fullName);
  }

  setPhone(String phone) {
    state = state!.copyWith(phone: phone);
    authService.setUser(user: state!);
  }
}

final appUserProvider =
    StateNotifierProvider<AppUser, UserModel?>((ref) => AppUser(ref));
