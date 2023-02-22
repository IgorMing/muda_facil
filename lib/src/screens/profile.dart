import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/services/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You are logged in as: ${user!.email}'),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              onPressed: () {
                AuthService.signOut();
              },
              label: const Text('Sign out'),
            )
          ],
        ),
      ),
    );
  }
}
