import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hire_pro/Controllers/validationController.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/services/urlCreator.dart';
import 'package:hire_pro/widgets/FormFieldRegular.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ValidationController validationController = ValidationController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  late SharedPreferences preferences;
  final _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              height: 1000,
              child: Column(
                children: [
                  Form(
                    key: _signupFormKey,
                    child:Expanded(
                      flex: 13,
                      child:
                      Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Expanded(
                          flex: 2,
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
                        Container(
                          height: 550,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FormFieldRegular('Name', nameController, false, (val) {
                                if (validationController.nameValidator(val) != null)
                                  return validationController.nameValidator(val);
                                return null;}),
                              FormFieldRegular('Email', emailController, false,(val) {
                                if (validationController.emailValidator(val) != null)
                                  return validationController.emailValidator(val);
                                return null;}),
                              FormFieldRegular('Mobile Number', contactController, false,(val) {
                                if (validationController.phoneValidator(val) != null)
                                  return validationController.phoneValidator(val);
                                return null;}),
                              FormFieldRegular('Password', passwordController, true,(val) {
                                if (validationController.passwordValidator(val) != null)
                                  return validationController.passwordValidator(val);
                                return null;}),
                              FormFieldRegular('Re-Enter Password', rePasswordController, true,(val) {
                                if (validationController.passwordValidator(val) != null)
                                  return validationController.passwordValidator(val);
                                return null;}),
                              FormFieldRegular('NIC Number', nicController, false,(val) {
                                if (validationController.nicValidator(val) != null)
                                  return validationController.nicValidator(val);
                                return null;}),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MainButton('Sign Up', () {
                                if (_signupFormKey.currentState!.validate()) {
                                  signUpUser();
                                  Navigator.pushNamed(context, '/otp_mobile');
                                }
                              }
                              // {
                              //   signUpUser();
                              //   Navigator.pushNamed(context, '/otp_mobile');
                              // }
                              ),
                            ],
                          ),
                        ),
                      ]),
                  ),
                  ),

                  const Expanded(
                    flex: 1,
                    child: TermsAndPolicy(),
                  )
                ],
              ),
            )
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('signupReqBody', jsonEncode(reqBody));
        // var response = await http.post(Uri.parse(urlCreate("registerSP")),
        //     headers: {'Content-Type': 'application/json'},
        //     body: jsonEncode(reqBody));
        // var jsonResponse = jsonDecode(response.body);
        // print(jsonResponse);
        // if(jsonResponse['status'] == "True"){
        //   print("Signed Successfully");
        //   Navigator.pushNamed(context, '/otp_mobile');
        // } else {
        //   print("Sign Up Failed");
        // }
      }
    }
  }
}
