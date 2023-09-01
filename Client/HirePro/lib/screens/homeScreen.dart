import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/NavButton.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/SearchBarWidget.dart';
import 'package:hire_pro/widgets/MainCard.dart';
import 'package:hire_pro/constants.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SearchBarWidget(),
                MainCard(
                    110, 325, Color(0XFFF5F5F5), Image.asset('images/townPNG.png')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                GestureDetector(
                  onTap: () {(Navigator.pushNamed(context, '/upcoming_tasks'));},
                  child: MainCard(
                    110,
                    150,
                    kMainYellow,
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Upcoming',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w400),
                          ),
                          Text('Tasks',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {(Navigator.pushNamed(context, '/ongoing_tasks'));},
                  child: MainCard(
                    110,
                    150,
                    kMainGrey,
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ongoing',
                            style: TextStyle(
                                color: kMainYellow,
                                fontSize: 23,
                                fontWeight: FontWeight.w400),
                          ),
                          Text('Tasks',
                              style: TextStyle(
                                  color: kMainYellow,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ),
                ),],
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedIconButton(onPressed: () {'/view_wallet';}, icon: Icons.payment),
                      RoundedIconButton(onPressed: () {'/';}, icon: Icons.notifications_active),
                      RoundedIconButton(onPressed: () {'/';}, icon: Icons.event),
                    ],
                  ),

                ),
                MainCard(
                    130,
                    325,
                    Color(0XFFF5F5F5),
                  GestureDetector(
                      onTap: () {Navigator.pushNamed(context, '/bidding_tasks');},
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('images/bid.png'),
                            Container(
                              margin:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                              child: Text(
                                "BID",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 40, color: kMainYellow),
                              ),
                            )
                          ]
                      )
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}


class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;

  RoundedIconButton({required this.icon, this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 90,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black,
            size: 45,
          ),
        ),
      ),
    );
  }
}
