import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiwi_mobile_app/views/pay_view.dart';
import 'package:qiwi_mobile_app/views/profile_view.dart';
import 'package:qiwi_mobile_app/views/scan_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.phone});
  final String phone;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w500);
  final List<Widget> _children = [];

  @override
  void initState() {
    _children.addAll([
      const PayView(),
      const ScanView(),
      ProfileView(phone: widget.phone),
    ]);

    super.initState();
  }

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
            icon: Icon(Icons.wallet),
            label: 'Главная',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Оплата',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
