import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/app_user.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/widgets/profile_row.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserProvider);
    final actions = ref.read(appUserProvider.notifier);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            expandedHeight: kDefaultPadding * 8,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Perfil'),
            ),
            pinned: true,
          )
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileRow(label: 'Nome', value: user!.name),
            ProfileRow(label: 'Email', value: user.email),
            if (user.role == Role.admin)
              ProfileRow(label: 'Role', value: user.role.toString()),
            ProfileRow(label: 'Celular', value: user.phone),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    actions.signOut();
                  },
                  label: const Text('Encerrar sessão'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
