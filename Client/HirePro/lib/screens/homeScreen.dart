// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/NavButton.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/SearchBarWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:html';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _storedValue = '';

  @override
  void initState() {
    super.initState();
    _loadStoredValue();
  }

  // Load stored value from SharedPreferences
  Future<void> _loadStoredValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedValue = prefs.getString('tokens') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavBar(),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Stored Value: $_storedValue', //testing
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      'Sign up',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )
                    // NavButton("Hire", () {}),
                    // NavButton("Ongoing", () {}),
                    // NavButton("Categories", () {})
                  ],
                ),
                SearchBarWidget()
              ],
            ),
          ),
    ));
  }
}
