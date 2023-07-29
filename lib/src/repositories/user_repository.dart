import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:muda_facil/src/extensions/firebase_firestore_extension.dart';
import 'package:muda_facil/src/models/user_model.dart';
import 'package:muda_facil/src/providers/providers.dart';
import 'package:muda_facil/src/repositories/exceptions.dart';

abstract class BaseUserRepository {
  Stream<UserModel?> getUserStream(String id);
  Future<UserModel?> getCurrentUser();
  Future<UserModel?> getUserById(String uid);
  Future<String> createUser(UserModel user);
  Future<void> updateUser({required String uid, required UserModel user});
}

class UserRepository implements BaseUserRepository {
  final Ref _ref;

  UserRepository(this._ref);

  @override
  Future<UserModel?> getCurrentUser() async {
    final id = _ref.read(firebaseAuthProvider).currentUser!.uid;
    return getUserById(id);
  }

  @override
  Stream<UserModel?> getUserStream(String id) => _ref
      .read(firebaseFirestoreProvider)
      .userRef()
      .doc(id)
      .snapshots()
      .map((event) => event.data());

  @override
  Future<String> createUser(UserModel user) async {
    try {
      final createdUserRef =
          await _ref.read(firebaseFirestoreProvider).userRef().add(user);

      return createdUserRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message.toString());
    }
  }

  @override
  Future<void> updateUser(
      {required String uid, required UserModel user}) async {
    try {
      await _ref
          .read(firebaseFirestoreProvider)
          .userRef()
          .doc(uid)
          .update(user.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message.toString());
    }
  }

  @override
  Future<UserModel?> getUserById(String uid) async {
    try {
      final result =
          await _ref.read(firebaseFirestoreProvider).userRef().doc(uid).get();
      return result.data();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message.toString());
    }
  }
}

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository(ref));
