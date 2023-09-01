import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/SmallSquareInput.dart';
import 'package:hire_pro/widgets/SmallArrowButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';

class OtpEnterScreen extends StatefulWidget {
  const OtpEnterScreen({super.key});

  @override
  State<OtpEnterScreen> createState() => _OtpEnterScreen();
}

class _OtpEnterScreen extends State<OtpEnterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBarBackButton(),
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('images/hireProWithoutBG.png'),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.center,
                          child: Text(
                            'Enter the 4-digit code sent to you at 076-3116008',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SmallSquareInput(),
                            SmallSquareInput(),
                            SmallSquareInput(),
                            SmallSquareInput(),
                          ],
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('I haven\'t received a code (0.09)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  )),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey[200],
                          ),
                          height: 40,
                          width: 245,
                        ),
                        Container(

                          margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallArrowButton(
                                  kMainYellow, Icons.arrow_forward, () {Navigator.pushNamed(context, '/emailcoderequest');}),
                            ],
                          ),
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
