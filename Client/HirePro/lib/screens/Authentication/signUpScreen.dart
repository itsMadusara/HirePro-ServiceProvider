import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/FormFieldRegular.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/GoogleLogin.dart';
import 'package:hire_pro/widgets/LineDivider.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 13,
                  child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('images/hireProWithoutBG.png'),
                          Container(
                            width: 350,
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FormFieldRegular('Name'),
                          FormFieldRegular('Email'),
                          FormFieldRegular('Mobile Number'),
                          FormFieldRegular('Password'),
                          FormFieldRegular('Re-Enter Password'),
                          FormFieldRegular('NIC Number'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MainButton('Next', () {}),
                        ],
                      ),
                    ),
                  ]),
                ),
                const Expanded(
                  flex: 1,
                  child: TermsAndPolicy(),
                )
              ],
            ),
          ),
        ));
  }

}
