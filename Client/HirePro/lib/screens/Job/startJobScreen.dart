import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TaskDetails.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/OngoingTaskDetails.dart';
import 'package:flutter/services.dart';


class StartJob extends StatefulWidget {
  @override
  State<StartJob> createState() => _StartJobState();
}

String jsondata =
    '{"full_name": "Tharushi Silva", "email": "sachinimuthugala@gmail.com", "phone_number": "123-456-7890"}';
var userData = jsonDecode(jsondata);

class _StartJobState extends State<StartJob> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBarTitle(title: userData['full_name'],),
            bottomNavigationBar: BottomNavBar(),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  height: 900,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OngoingTaskDetails(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: 40, // Set your desired width
                                  height: 40, // Set your desired height
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300], // Set your desired grey background color
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.phone, color: Colors.black), // Set the icon color
                                    onPressed: () {},
                                  ),
                                )
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                                flex: 2,
                                child:Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35), // Set the border radius
                                    color: Colors.grey[300], // Set your desired grey background color
                                  ),
                                  child: TextButton(
                                    onPressed: () {Navigator.pushNamed(context, '/customer_profile');},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Visit Customer',
                                          style: TextStyle(color: Colors.black), // Set the text color
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: 40, // Set your desired width
                                  height: 40, // Set your desired height
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300], // Set your desired grey background color
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.chat, color: Colors.black,), // Set the icon color
                                    onPressed: () {},
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: MainButton('Start',(){Navigator.pushNamed(context, '/progress_start');}),
                      ),
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}




