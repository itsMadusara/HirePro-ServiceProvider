import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/UploadImageBox.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarBackButton(),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(height: 16), // Add spacing
                  Image.asset('images/hireProWithoutBG.png'),
                  SizedBox(height: 16), // Add spacing
                  Container(
                    width: 350,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
                SizedBox(height: 16), // Add spacing
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 350,
                      child: const Text(
                        'Upload Driving License',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 20,),
                    UploadImageBox('Upload Here'),
                  ],
                ),
                SizedBox(height: 16), // Add spacing
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 350,
                      child: const Text(
                        'Proof of document to identify permanent Residence',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 20,),
                    UploadImageBox('Upload Here'),
                  ],
                ),
                SizedBox(height: 30), // Add spacing
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainButton('Continue', () {
                      Navigator.pushNamed(context, '/upload_profile_picture');
                    }),
                  ],
                ),
                SizedBox(height: 35), // Add spacing
                const TermsAndPolicy(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}