import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You are logged in as: ${user!.email}'),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              label: const Text('Sign out'),
            )
          ],
        ),
      ),
    );
  }
}
