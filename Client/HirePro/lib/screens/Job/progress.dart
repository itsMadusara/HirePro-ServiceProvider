import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_pro/screens/Job/progressStepOne.dart';
import 'package:hire_pro/screens/Job/progressStepTwo.dart';
import 'package:hire_pro/screens/Job/progressStepThree.dart';
import 'package:hire_pro/screens/homeScreen.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/screens/Job/earnedStarsScreen.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../services/urlCreator.dart';

class ProgressStart extends StatefulWidget {
  Map<String,dynamic> taskDescription;
  ProgressStart({required this.taskDescription});

  @override
  State<ProgressStart> createState() => _ProgressStartState();
}

class _ProgressStartState extends State<ProgressStart> {
  int currentStep = 0;

  void setCurrState(){
    String status = widget.taskDescription['serviceValue']['status'];
    switch (status) {
      case 'Started':
        currentStep = 0;
      case 'Arrived':
        currentStep = 1;
      case 'Completed':
        currentStep = 2;
      default:
        currentStep = 0;
    }
  }

  void initState() {
    super.initState();
    setCurrState();
  }

  Future<String> setArrived() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(urlCreate('setArrived')),
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
        setArrived();
      }
      throw Exception('Failed to load album');
    }
  }

  Future<String> setCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(urlCreate('setCompleted')),
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
        setCompleted();
      }
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBarTitle(title: 'Progress',),
          bottomNavigationBar: BottomNavBar(),
            body: Stepper(
                elevation: 0,
                type: StepperType.horizontal,
                currentStep: currentStep,
                onStepContinue: () {
                  setState(() {
                    if (currentStep == 0) {
                      setArrived();
                      currentStep += 1;
                    } else if (currentStep == 1) {
                      currentStep += 1;
                    } else {
                      setCompleted();
                      Navigator.pushNamed(context, '/job_completed');
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep == 0) {
                      Navigator.pop(context);
                    } else {
                      currentStep -= 1;
                    }
                  });
                },
                steps: getSteps()
            )
        )
    );
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep == 0,
          title: Text('Start'),
          content: ProgressStepOne(taskDescription: widget.taskDescription),
        ),
        Step(
            isActive: currentStep == 1,
            title: Text('Arrived'),
            content: ProgressStepTwo(taskDescription: widget.taskDescription)
        ),
        Step(
            isActive: currentStep == 2,
            title: Text('Completed'),
            content: ProgressStepThree()
        )
      ];
}
