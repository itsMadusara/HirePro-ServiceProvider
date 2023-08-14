import 'package:flutter/material.dart';
import 'package:hire_pro/screens/Job/progressStepOne.dart';
import 'package:hire_pro/screens/Job/progressStepTwo.dart';
import 'package:hire_pro/screens/Job/progressStepThree.dart';
import 'package:hire_pro/screens/homeScreen.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/screens/Job/earnedStarsScreen.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';

class ProgressStart extends StatefulWidget {
  const ProgressStart({super.key});

  @override
  State<ProgressStart> createState() => _ProgressStartState();
}

class _ProgressStartState extends State<ProgressStart> {
  int currentStep = 0;

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
                    if (currentStep == 2) {
                      Navigator.pushNamed(context, '/job_completed');
                    } else {
                      currentStep += 1;
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
          isActive: currentStep >= 0,
          title: Text('Start'),
          content: ProgressStepOne(),
        ),
        Step(
            isActive: currentStep >= 1,
            title: Text('Arrived'),
            content: ProgressStepTwo()
        ),
        Step(
            isActive: currentStep >= 2,
            title: Text('Completed'),
            content: ProgressStepThree()
        )
      ];
}
