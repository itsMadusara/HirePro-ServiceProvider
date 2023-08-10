import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/FormFieldRegular.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/GoogleLogin.dart';
import 'package:hire_pro/widgets/LineDivider.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  String errorMessage = '';
  void initSharedPref() async {
    preferences = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        'email': usernameController.text,
        'password': passwordController.text,
      };
      var response = await http.post(Uri.parse("http://192.168.56.1:5000/loginSP"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['tokens']['status']);
      if (jsonResponse['tokens']['status'] == "True") {
        print(jsonResponse);
        var myTokens = jsonResponse['tokens'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('tokens', jsonEncode(myTokens));
        // var sesstionToken = myTokens;
        // preferences.setString('token', myTokens);
        print("Logged in");
        Navigator.pushNamed(context, '/home');
      } else {
        print('Invalid Login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('images/hireProWithoutBG.png'),
                          GoogleLogin(),
                          const LineDivider(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FormFieldRegular('Your Email', usernameController, false),
                          FormFieldRegular('Password', passwordController, true),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 350,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: kMainYellow, fontSize: 14),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          MainButton('Login', () {
                            loginUser();
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/sign_up');
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(color: kMainYellow, fontSize: 14),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
                const Expanded(
                  flex: 3,
                  child: TermsAndPolicy(),
                )
              ],
            ),
          ),
        ));
  }
}