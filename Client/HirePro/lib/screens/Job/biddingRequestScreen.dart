import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TaskDetails.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:flutter/services.dart';


class BiddingRequest extends StatefulWidget {
  final Map<String, dynamic> taskDescription; // Add this parameter
  const BiddingRequest({super.key, required this.taskDescription});
  @override
  State<BiddingRequest> createState() => _BiddingRequestState();
}

String jsondata = '{"full_name": "John Doe", "email": "sachinimuthugala@gmail.com", "phone_number": "123-456-7890"}';
var userData = jsonDecode(jsondata);

class _BiddingRequestState extends State<BiddingRequest> {

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> description = widget.taskDescription;
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
                      TaskDetails(taskDescription: description),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    hintText: 'Enter your bid',
                                    hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35.0), // Set the border radius
                                      borderSide: BorderSide.none, // Remove the bottom line
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                                flex: 1,
                                child: MainButton('Bid',(){Navigator.pushNamed(context, '/bidding_successful');})
                            ),
                          ],
                        ),
                      ),
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
                      )
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}




