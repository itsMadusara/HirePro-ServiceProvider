import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/FormFieldRegular.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/GoogleLogin.dart';
import 'package:hire_pro/widgets/LineDivider.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  late SharedPreferences preferences;

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
                          FormFieldRegular('Name', nameController, false),
                          FormFieldRegular('Email', emailController, false),
                          FormFieldRegular('Mobile Number', contactController, false),
                          FormFieldRegular('Password', passwordController, true),
                          FormFieldRegular('Re-Enter Password', rePasswordController, true),
                          FormFieldRegular('NIC Number', nicController, false),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MainButton('Sign Up', () {
                            signUpUser();
                          }),
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

  void signUpUser() async {
    if (passwordController.text.isNotEmpty && rePasswordController.text.isNotEmpty && nameController.text.isNotEmpty && emailController.text.isNotEmpty && contactController.text.isNotEmpty && nicController.text.isNotEmpty) {
      if (passwordController.text == rePasswordController.text) {
        var reqBody = {
          "contact" : contactController.text,
          "name" : nameController.text,
          "email" : emailController.text,
          "nic" : nicController.text,
          "password" : passwordController.text
        };
        var response = await http.post(Uri.parse("http://192.168.56.1:5000/registerSP"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(reqBody));
        var jsonResponse = jsonDecode(response.body);
        // print(jsonResponse);
        if(jsonResponse['status'] == "True"){
          print("Signed Successfully");
          Navigator.pushNamed(context, '/');
        } else {
          print("Sign Up Failed");
        }
      }
    }
  }
}
