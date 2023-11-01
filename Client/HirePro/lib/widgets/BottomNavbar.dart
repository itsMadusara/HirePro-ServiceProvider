import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Use Navigator to navigate based on the selected index
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/ongoing_tasks');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.search),
      //   label: 'Search',
      // ),
      BottomNavigationBarItem(
        icon: Icon(Icons.handyman),
        label: 'Tasks',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.supervised_user_circle_rounded),
        label: 'Profile',
      ),
    ],
      currentIndex: _selectedIndex,
      selectedItemColor: kMainYellow,
      unselectedItemColor: Colors.grey, // Set selected label color
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      showUnselectedLabels: true,
      onTap: _onItemTapped,
    );
  }
}
