import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/services/email.dart';
import 'package:hire_pro/widgets/MediumButton.dart';
import 'package:hire_pro/widgets/SquareInputBox.dart';
import '../widgets/BottomNavbar.dart';
import '../widgets/TopNavigation.dart';

class EmailCodeVerifyScreen extends StatefulWidget {
  const EmailCodeVerifyScreen({super.key});

  @override
  State<EmailCodeVerifyScreen> createState() => _EmailCodeVerifyScreenState();
}

class _EmailCodeVerifyScreenState extends State<EmailCodeVerifyScreen> {
  Email email = Email();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    int code = email.generateRandomNumber();
    email.sendEmail(
        name: 'Sachini Muthugala',
        email: '$args',
        subject: 'Email Verification Code',
        message: 'Please verify with the 5 digit code $code');
    return SafeArea(
        child: Scaffold(
          appBar: AppBarBackAndMore(),
          bottomNavigationBar: BottomNavBar(),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(40),
              child: Column(
                children: [
                  Image.asset('images/hireProWithoutBG.png'),
                  Text(
                    'Enter the code sent to your email: $args',
                    style: kHeading1.copyWith(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareInputBox(),
                      SquareInputBox(),
                      SquareInputBox(),
                      SquareInputBox(),
                      SquareInputBox(),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  MediumButton('Continue', () {Navigator.pushNamed(context, '/upload_verified_documents');}, kMainYellow, Colors.white),
                ],
              ),
            ),
          ),
        )
    );
  }
}
