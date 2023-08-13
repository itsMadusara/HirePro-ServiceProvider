import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TaskDetails.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/Stepper.dart';
import 'package:flutter/services.dart';


class ProgressStepThree extends StatefulWidget {
  @override
  State<ProgressStepThree> createState() => _ProgressStepThreeState();
}

String jsondata =
    '{"full_name": "John Doe", "email": "sachinimuthugala@gmail.com", "phone_number": "123-456-7890"}';
var userData = jsonDecode(jsondata);

class _ProgressStepThreeState extends State<ProgressStepThree> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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

                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}




