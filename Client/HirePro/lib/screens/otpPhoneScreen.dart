import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/services/email.dart';
import 'package:hire_pro/widgets/MediumButton.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPPhone extends StatefulWidget {
  const OTPPhone({super.key});

  @override
  State<OTPPhone> createState() => _OTPPhoneState();
}

class _OTPPhoneState extends State<OTPPhone> {
  // Phone phoneNumber = Email();
  String phoneNumber = '';
  Map<String,dynamic> userData = {};
  bool isLoading = true;

  Future<Map<String, dynamic>> getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String signupdata = prefs.getString('signupReqBody') ?? '';
    var signupdataJson = jsonDecode(signupdata);
    return signupdataJson;
    phoneNumber = userData['contact'] ?? 'Not loaded';
    print(userData['contact']);
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
    // String jsondata = getData() as String;
    // var userData = jsonDecode(jsondata);
    // String phone = userData['contact'] ?? 'Not loaded';


    return SafeArea(
        child: Scaffold(
          appBar: AppBarBackButton(),
          bottomNavigationBar: BottomNavBar(),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(40).copyWith(top: 0),
              child: isLoading ?
                Center(child: CircularProgressIndicator()) :
                Column(
                children: [
                  Image.asset('images/hireProWithoutBG.png'),
                  Text(
                    'Press "Continue" to receive a 4-digit OTP to your phone Number \n' + userData['contact'],
                    style: kHeading1.copyWith(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Image.asset('images/otp_phone.png', height: 250),
                  SizedBox(
                    height: 50,
                  ),
                  MediumButton('Continue', () {
                    Navigator.pushNamed(context, '/otp_enter',
                        arguments: "userData['email']");
                  }, kMainYellow, Colors.white),
                ],
              ),
            ),
          ),
        )
    );
  }
}
