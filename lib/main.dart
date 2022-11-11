import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:qiwi_mobile_app/views/pay_view.dart';
import 'package:qiwi_mobile_app/views/profile_view.dart';
import 'package:qiwi_mobile_app/views/scan_view.dart';

void main() {
  runApp(GetMaterialApp(
    theme: ThemeData.light().copyWith(
      colorScheme: ThemeData.light().colorScheme.copyWith(
            primary: Colors.white,
            secondary: Color.fromRGBO(255, 140, 0, 1.0),
            background: Color.fromRGBO(245, 245, 245, 1.0),
            tertiary: Color.fromRGBO(0, 0, 0, 1.0),
            surface: Colors.grey.shade400
            // surface: Color.fromRGBO(153, 153, 153, 1.0)
          ),
    ),
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: ThemeData.dark().colorScheme.copyWith(
            primary: Color.fromRGBO(0, 0, 0, 0.2),
            secondary: Color.fromRGBO(255, 140, 0, 1.0),
            background: Color.fromRGBO(45, 53, 64, 1.0),
            tertiary: Colors.white,
            surface: Color.fromRGBO(255, 255, 255, 0.3)
          ),
    ),
    
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w500);
  final List<Widget> _children = [
    const PayView(),
    const ScanView(),
    const ProfileView(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.surface,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Ionicons.wallet),
            label: 'Главная',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Ionicons.camera),
            label: 'Оплата',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Ionicons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
