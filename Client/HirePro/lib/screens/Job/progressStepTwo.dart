import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../complaintForm.dart';

class ProgressStepTwo extends StatefulWidget {
  Map<String,dynamic> taskDescription;
  ProgressStepTwo({required this.taskDescription});
  @override
  State<ProgressStepTwo> createState() => _ProgressStepTwoState();
}

String jsondata =
    '{"full_name": "John Doe", "email": "sachinimuthugala@gmail.com", "phone_number": "123-456-7890"}';
var userData = jsonDecode(jsondata);

class _ProgressStepTwoState extends State<ProgressStepTwo> {
  final customerNumber = '0763116008';
  final sosNumber = '119';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Image.asset('images/work_in_progress.gif'),
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
                          onPressed: () async {
                            await FlutterPhoneDirectCaller.callNumber(customerNumber);
                          },
                        ),
                      )
                  ),
                  SizedBox(width: 8,),
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
                  SizedBox(width: 8,),
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
                  SizedBox(width: 8,),
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
                          icon: Icon(Icons.report_problem_rounded, color: Colors.black), // Set the icon color
                          onPressed: () {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ComplaintForm(taskDetails : widget.taskDescription))
                          );},
                        ),
                      )
                  ),
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
                          icon: Icon(Icons.sos_outlined, color: Colors.black), // Set the icon color
                          onPressed: () async {
                            await FlutterPhoneDirectCaller.callNumber(sosNumber);
                          },
                        ),
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}




