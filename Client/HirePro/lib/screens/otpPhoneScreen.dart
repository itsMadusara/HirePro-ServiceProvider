import 'dart:convert';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/services/email.dart';
import 'package:hire_pro/widgets/MediumButton.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';

class OTPPhone extends StatefulWidget {
  const OTPPhone({super.key});

  @override
  State<OTPPhone> createState() => _OTPPhoneState();
}

class _OTPPhoneState extends State<OTPPhone> {
  // Phone phoneNumber = Email();
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    String jsondata =
        '{"full_name": "John Doe", "email": "sachinimuthugala99@gmail.com", "phone_number": "076-3116008"}';
    var userData = jsonDecode(jsondata);

    return SafeArea(
        child: Scaffold(
          appBar: AppBarBackButton(),
          bottomNavigationBar: BottomNavBar(),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(40).copyWith(top: 0),
              child: Column(
                children: [
                  Image.asset('images/hireProWithoutBG.png'),
                  Text(
                    'Press "Continue" to receive a 4-digit OTP to your phone Number \n' + userData['phone_number'],
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
                        arguments: userData['email']);
                  }, kMainYellow, Colors.white),
                ],
              ),
            ),
          ),
        )
    );
  }
}
