import 'package:flutter/material.dart';

import 'package:foodwifi/pages/homepage.dart';
import 'package:foodwifi/pages/muyaccountpage.dart';
import 'package:foodwifi/pages/myorderpage.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int currentIndex = 0;
  final screen = [const HomePage(), const MyOrders(), const MyAccountPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/foodnewok.png",
                  height: 22,
                  width: 22,
                ),
                label: "foodwifi"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag,
                ),
                label: "My orders"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_sharp), label: "My Account"),
          ]),
      body: screen[currentIndex],
    );
  }
}
