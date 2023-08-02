import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/NavButton.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/SearchBarWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
