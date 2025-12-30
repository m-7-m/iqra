import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iqra/controllers/nav_controller.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final NavController navController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline),
            selectedIcon: Icon(Icons.bookmark),
            label: 'العلامات',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'البحث',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'الاعدادات',
          ),
        ],
        selectedIndex: navController.index.value,
        onDestinationSelected: (index) {
          navController.index.value = index;
        },
      ),
    );
  }
}
