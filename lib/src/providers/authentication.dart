import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/services/auth.dart';

final authenticationProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>(
    (ref) => ref.read(authenticationProvider).onStateChanges);
