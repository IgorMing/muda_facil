import 'package:flutter/material.dart';
import 'package:muda_facil/src/models/user_model.dart';
import 'package:muda_facil/src/screens/admin_home.dart';
import 'package:muda_facil/src/screens/driver_home.dart';
import 'package:muda_facil/src/screens/home.dart';
import 'package:muda_facil/src/screens/profile.dart';
import 'package:muda_facil/src/utils/constants.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation(this.user, {super.key});

  final UserModel user;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  void dispose() {
    _selectedIndex = 0;
    super.dispose();
  }

  Widget _getActiveScreen() {
    if (widget.user.role == Role.admin) {
      switch (_selectedIndex) {
        case 2:
          return const ProfileScreen();
        case 1:
          return const AdminHome();
        case 0:
        default:
          return const HomeScreen();
      }
    } else if (widget.user.role == Role.driver) {
      switch (_selectedIndex) {
        case 1:
          return const ProfileScreen();
        case 0:
        default:
          return const DriverHome();
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

  List<BottomNavigationBarItem> _getSpecialTab() {
    switch (widget.user.role) {
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
          ..._getSpecialTab(),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
      body: _getActiveScreen(),
    );
  }
}
