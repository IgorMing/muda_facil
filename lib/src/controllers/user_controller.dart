import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:muda_facil/src/models/user_model.dart';
import 'package:muda_facil/src/providers/providers.dart';
import 'package:muda_facil/src/repositories/user_repository.dart';

class UserController extends StateNotifier<UserModel?> {
  final UserRepository userRepository;
  final FirebaseAuth authRepository;
  // StreamSubscription<UserModel?>? _streamSubscription;
  Stream<UserModel?> get userStream =>
      userRepository.getUserStream(authRepository.currentUser!.uid);

  UserController(this.userRepository, this.authRepository) : super(null) {
    // final String uid = authRepository.currentUser!.uid;
    // _streamSubscription?.cancel();
    // _streamSubscription = userRepository.getUserStream(uid).listen((event) {
    //   state = event;
    // });
  }

  // @override
  // void dispose() {
  //   _streamSubscription?.cancel();
  //   super.dispose();
  // }

  Future<UserModel?> getUser() {
    return userRepository.getCurrentUser();
  }

  Future<UserModel?> getUserById(String uid) {
    return userRepository.getUserById(uid);
  }
}

final userControllerProvider =
    StateNotifierProvider<UserController, UserModel?>(
  (ref) => UserController(
    ref.read(userRepositoryProvider),
    ref.read(firebaseAuthProvider),
  ),
);

final userStreamProvider = StreamProvider((ref) {
  final userController = ref.watch(userControllerProvider.notifier);
  return userController.userStream;
});
