import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/blocs/app_user.dart';
import 'package:muda_facil/src/models/user_model.dart';
import 'package:muda_facil/src/screens/admin_home.dart';
import 'package:muda_facil/src/screens/driver_home.dart';
import 'package:muda_facil/src/screens/home.dart';
import 'package:muda_facil/src/screens/profile.dart';
import 'package:muda_facil/src/utils/constants.dart';

class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({super.key});

  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation> {
  int _selectedIndex = 0;

  Widget _getActiveScreen(UserModel? user) {
    if (user?.role == Role.admin) {
      switch (_selectedIndex) {
        case 2:
          return const ProfileScreen();
        case 1:
          return const AdminHome();
        case 0:
        default:
          return const HomeScreen();
      }
    } else if (user?.role == Role.driver) {
      switch (_selectedIndex) {
        case 2:
          return const ProfileScreen();
        case 1:
          return const DriverHome();
        case 0:
        default:
          return const HomeScreen();
      }
    } else {
      switch (_selectedIndex) {
        case 1:
          return const ProfileScreen();
        case 0:
        default:
          return const HomeScreen();
      }
    }
  }

  List<BottomNavigationBarItem> _getSpecialTab(UserModel? user) {
    switch (user?.role) {
      case Role.admin:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings_outlined),
            label: 'Admin',
          ),
        ];
      case Role.driver:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fire_truck_outlined),
            label: 'Motorista',
          ),
        ];
      case Role.user:
      default:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedIndex);
    final user = ref.watch(appUserProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (int selected) {
          setState(() {
            _selectedIndex = selected;
          });
        },
        items: [
          ..._getSpecialTab(user),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: _getActiveScreen(user),
    );
  }
}
