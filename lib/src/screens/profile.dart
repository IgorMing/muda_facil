import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/app_user.dart';
import 'package:muda_facil/src/widgets/loading_adaptive.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserProvider);
    final actions = ref.read(appUserProvider.notifier);

    if (user == null) return const LoadingAdaptive();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nome: ${user.name}'),
            Text('Você está logado como: ${user.email}'),
            Text('Role: ${user.role}'),
            Text('Telefone: ${user.phone}'),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              onPressed: () {
                actions.signOut();
              },
              label: const Text('Encerrar sessão'),
            )
          ],
        ),
      ),
    );
  }
}
