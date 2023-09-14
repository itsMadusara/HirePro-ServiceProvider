import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/SmallSquareInput.dart';
import 'package:hire_pro/widgets/SmallArrowButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpEnterScreen extends StatefulWidget {
  const OtpEnterScreen({super.key});

  @override
  State<OtpEnterScreen> createState() => _OtpEnterScreen();
}

class _OtpEnterScreen extends State<OtpEnterScreen> {
  // String phoneNumber = '';
  Map<String,dynamic> userData = {};
  bool isLoading = true;

  Future<Map<String, dynamic>> getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String signupdata = prefs.getString('signupReqBody') ?? '';
    var signupdataJson = jsonDecode(signupdata);
    return signupdataJson;
    // phoneNumber = userData['contact'] ?? 'Not loaded';
    // print(userData['contact']);
  }

  Future<void> _loadUserData() async {
    try {
      userData = await getData();
      // userDataMap.forEach((element) {print(element);});
      setState(() {
        isLoading = false; // Set isLoading to false after data is loaded
      });
      return;
    } catch (error) {
      print('Error fetching user data: $error');
      setState(() {
        isLoading = false; // Set isLoading to false after data is loaded
      });
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBarBackButton(),
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: isLoading ?
                    Center(child: CircularProgressIndicator()) :
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('images/hireProWithoutBG.png'),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.center,
                          child: Text(
                            'Enter the 4-digit code sent to you at' + userData['contact'],
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SmallSquareInput(),
                            SmallSquareInput(),
                            SmallSquareInput(),
                            SmallSquareInput(),
                          ],
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('I haven\'t received a code (0.09)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  )),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey[200],
                          ),
                          height: 40,
                          width: 245,
                        ),
                        Container(

                          margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallArrowButton(
                                  kMainYellow, Icons.arrow_forward, () {Navigator.pushNamed(context, '/emailcoderequest');}),
                            ],
                          ),
                        ),
                      ]),
                ),
                Expanded(child: TermsAndPolicy()),
              ],
            ),
          ),
      )
    );
  }
}
