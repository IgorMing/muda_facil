import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/models/user_model.dart';
import 'package:muda_facil/src/services/auth.dart';

class AppUser extends StateNotifier<UserModel?> {
  final authService = AuthService();

  AppUser() : super(null) {
    _init();
  }

  Future<void> _init() async {
    authService.stream.listen((event) async {
      if (event != null) {
        final uid = event.uid;
        final role = await authService.getUserRole(uid);
        state = state == null
            ? UserModel(
                uid: uid,
                email: event.email,
                name: event.displayName,
                role: role,
              )
            : state!.copyWith(
                uid: uid,
                email: event.email,
                name: event.displayName,
                role: role,
              );
        authService.setUser(state!);
      } else {
        state = null;
      }
    });
  }
}

final appUserProvider =
    StateNotifierProvider<AppUser, UserModel?>((ref) => AppUser());
