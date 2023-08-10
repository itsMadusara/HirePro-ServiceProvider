import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/FormFieldRegular.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Image.asset('images/hireProWithoutBG.png'),
              FormFieldRegular('Phone Number', contactController, false),
              FormFieldRegular('Your Email', emailController, false),
              FormFieldRegular('Password', emailController, true),
              MainButton('Send OTP', () {})
            ]),
            TermsAndPolicy(),
          ],
        ),
      ),
    ));
  }
}
