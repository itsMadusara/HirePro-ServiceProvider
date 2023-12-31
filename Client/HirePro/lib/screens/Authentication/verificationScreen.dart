import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/UploadImageBox.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../firebase_options.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  UploadImageBox box1 = UploadImageBox('Upload Here');
  UploadImageBox box2 = UploadImageBox('Upload Here');

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

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
                    box1,
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
                    box2,
                  ],
                ),
                SizedBox(height: 30), // Add spacing
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainButton('Continue', () {
                      print(box1.selectedFiles[0]);
                      print(box2.selectedFiles);
                      Map<String,dynamic> images = {
                        "dl" : [box1.selectedFiles[0].path],  // Assuming File has a `path` property
                        "proof" : [for (var file in box2.selectedFiles) file.path],
                      };
                      setPrefImages(images);
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

  Future<void> setPrefImages (Map<String,dynamic> images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String imagesJson = jsonEncode(images);
    await prefs.setString('verifyImages', imagesJson);
  }

}