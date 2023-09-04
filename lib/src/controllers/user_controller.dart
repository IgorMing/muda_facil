import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:muda_facil/src/models/user_model.dart';
import 'package:muda_facil/src/repositories/auth_repository.dart';
import 'package:muda_facil/src/repositories/user_repository.dart';

class UserController extends StateNotifier<UserModel?> {
  final UserRepository userRepository;
  final String uid;

  UserController(this.userRepository, this.uid) : super(null);

  Future<void> getUser() async {
    state = await userRepository.getUserById(uid);
  }

  Future<UserModel?> getUserById(String uid) {
    return userRepository.getUserById(uid);
  }

  Future<void> createUser(UserModel user) {
    return userRepository.createUser(user);
  }

  setFullName(String fullName) async {
    // if (state == null) {
    //   await getUser();
    // }
    state = state!.copyWith(name: fullName);
  }

  setPhone(String phone) {
    state = state!.copyWith(phone: phone);
    userRepository.updateUser(uid: uid, user: state!);
  }
}

final userControllerProvider =
    StateNotifierProvider<UserController, UserModel?>((ref) {
  final auth = ref.watch(authRepositoryProvider); // ??
  final uid = auth.getCurrentUser()?.uid;

  final controller =
      UserController(ref.read(userRepositoryProvider), uid ?? '');

  return controller;
});
