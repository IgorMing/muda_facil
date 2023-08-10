import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:muda_facil/src/models/user_model.dart';
import 'package:muda_facil/src/repositories/auth_repository.dart';
import 'package:muda_facil/src/repositories/user_repository.dart';

class UserController extends StateNotifier<UserModel?> {
  final UserRepository userRepository;
  final String uid;

  // StreamSubscription<UserModel?>? _streamSubscription;
  // Stream<UserModel?> get userStream => userRepository.getUserStream(uid);

  UserController(this.userRepository, this.uid) : super(null);

  // Future<void> subscribe() async {
  //   _streamSubscription?.cancel();
  //   _streamSubscription = userStream.listen((event) {
  //     state = event;
  //   });
  // }

  // Future<void> unsubscribe() async {
  //   _streamSubscription?.cancel();
  // }

  // @override
  // void dispose() {
  //   unsubscribe();
  //   super.dispose();
  // }

  Future<UserModel?> getUser() async {
    state = await userRepository.getCurrentUser();
    return state;
  }

  Future<UserModel?> getUserById(String uid) {
    return userRepository.getUserById(uid);
  }
}

final userControllerProvider =
    StateNotifierProvider<UserController, UserModel?>((ref) {
  final uid = ref.watch(authUidProvider); // ??

  final controller = UserController(ref.read(userRepositoryProvider), uid!);

  return controller;
});

// final userStreamProvider = StreamProvider((ref) {
//   final userController = ref.watch(userControllerProvider.notifier);
//   return userController.userStream;
// });
