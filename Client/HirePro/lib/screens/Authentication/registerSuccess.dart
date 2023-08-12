import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/SmallArrowButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';

class RegisterSuccess extends StatefulWidget {
  const RegisterSuccess({super.key});

  @override
  State<RegisterSuccess> createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBarBackButton(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('images/hireProWithoutBG.png'),
                        Container(
                          child: Icon(
                            Icons.check_circle,
                            size: 72,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey[200],
                          ),
                          height: 72,
                          width: 72,
                        ),
                        Column(
                          children: [
                            Container(
                              margin:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                              alignment: Alignment.center,
                              child: Text(
                                'All set.',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text('Click next to continue to the home page.'),
                          ],
                        ),
                        Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                          child: SmallArrowButton(kMainYellow, Icons.arrow_forward,
                                  () {
                                Navigator.pushNamed(context, '/home');
                              }),
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
