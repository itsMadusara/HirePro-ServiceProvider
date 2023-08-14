import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/StarRatingIndicator.dart';
import 'package:flutter/services.dart';



class ProgressStepOne extends StatefulWidget {
  @override
  State<ProgressStepOne> createState() => _ProgressStepOneState();
}

String jsondata =
    '{"full_name": "John Doe", "email": "sachinimuthugala@gmail.com", "phone_number": "123-456-7890"}';
var userData = jsonDecode(jsondata);

class _ProgressStepOneState extends State<ProgressStepOne> {
  double rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Latest Arrival by 10:00',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: 250,
              child: Center(
                  child: Column(
                    children: [
                      Image.asset('images/google_map_image.jpeg'),
                    ],
                  ),
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: ClipOval(
                      child: Image.asset('images/profile_pic.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text('Customer Name',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.bold),),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StarRatingIndicator(rating, 15, Colors.amber),
                        Text(rating.toString()),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),

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
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.grey[300],
                        ),
                        child: TextButton(
                          onPressed: () {Navigator.pushNamed(context, '/view_task_details');},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Task Details',
                                style: TextStyle(color: Colors.black),
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
          ],
        ),

    );
  }
}




