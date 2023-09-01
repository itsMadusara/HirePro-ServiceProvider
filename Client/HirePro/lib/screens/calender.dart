import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/SmallArrowButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/services/calander.dart';

import '../../widgets/MainButton.dart';
import '../../widgets/ToggleEyeField.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBarBackButton(),
          body: Center(
            child: Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  // Other widgets...

                  // Add the Calander widget here
                  Calander(),

                  // Other widgets...
                ],
              ),
            ),
          ),
        )
    );
  }
}