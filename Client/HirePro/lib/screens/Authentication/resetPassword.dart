import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import '../../widgets/MainButton.dart';
import '../../widgets/ToggleEyeField.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reEnterNewPasswordController = TextEditingController();

  bool _obscureText = true;
  IconData _icon = FontAwesomeIcons.eyeSlash;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBarBackButton(),
          body: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('images/hireProWithoutBG.png'),
                        SizedBox(height: 50,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  'Reset\nPassword?',
                                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        ToggleEyeField(
                            obscureText: _obscureText,
                            icon: _icon,
                            placeholder: 'New Password',
                            controller: newPasswordController),
                        SizedBox(height: 15,),
                        ToggleEyeField(
                            obscureText: _obscureText,
                            icon: _icon,
                            placeholder: 'Confirm New password',
                            controller: reEnterNewPasswordController),
                        SizedBox(height: 35,),
                        MainButton('Update', () {

                        }),
                      ],
                    ),
                  ]
              ),
            ),
          ),
        )
    );
  }
}
