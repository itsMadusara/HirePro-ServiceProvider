import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/screens/Job/progress.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TaskDetails.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/OngoingTaskDetails.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../services/urlCreator.dart';


class StartJob extends StatefulWidget {
  final Map<String, dynamic> taskDescription;
  const StartJob({super.key, required this.taskDescription});
  @override
  State<StartJob> createState() => _StartJobState();
}

// String jsondata =
//     '{"full_name": "Tharushi Silva", "email": "sachinimuthugala@gmail.com", "phone_number": "123-456-7890"}';
// var userData = jsonDecode(jsondata);

class _StartJobState extends State<StartJob> {

  Future<String> setStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(urlCreate('setStarted')),
        headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['accessToken']},
        body: jsonEncode({"serviceid" : widget.taskDescription['serviceValue']['id']})
    );
    if (response.statusCode == 200) {
      return (response.body);
    } else {
      if(jsonDecode(response.body)['error'] == 'TokenExpiredError'){
        response = await http.get(Uri.parse(urlCreate('refreshToken')),
            headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['refreshToken']});
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['tokens']);
        await prefs.setString('tokens', jsonEncode(jsonResponse['tokens']));
        setStart();
      }
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.taskDescription;
    return SafeArea(
        child: Scaffold(
            appBar: AppBarTitle(title: data['customerName'],),
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
                      OngoingTaskDetails(taskDescription: data),
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
                        child: MainButton('Start',(){
                          setStart();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProgressStart(taskDescription: widget.taskDescription),
                              )
                          );
                        }),
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




