import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_pro/Controllers/validationController.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/services/urlCreator.dart';
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
  ValidationController validationController = ValidationController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences preferences;
  final _loginFormKey = GlobalKey<FormState>();

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
      var response = await http.post(Uri.parse(urlCreate('loginSP')),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['tokens']['status']);
      if (jsonResponse['tokens']['status'] == "True") {
        // print(jsonResponse);
        var myTokens = jsonResponse['tokens'];
        print(myTokens);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('tokens', jsonEncode(myTokens));
        // var sessionToken = myTokens;
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
                Form(
                  key: _loginFormKey,
                  child:Expanded(
                    flex: 10,
                    child:
                    Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Expanded(
                        flex: 3,
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
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FormFieldRegular('Your Email', usernameController, false,(val) {
                              if (validationController.emailValidator(val) != null)
                                return validationController.emailValidator(val);
                              return null;}),
                            FormFieldRegular('Password', passwordController, true,(val) {
                              if (validationController.passwordValidator(val) != null)
                                return validationController.passwordValidator(val);
                              return null;}),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
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
                            MainButton('Login', ()
                            {
                              if (_loginFormKey.currentState!.validate()) {
                                loginUser();
                              }
                            }
                            // {
                            //   loginUser();
                            // }
                            ),
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
                ),

                const Expanded(
                  flex: 2,
                  child: TermsAndPolicy(),
                )
              ],
            ),
          ),
        ));
  }
}