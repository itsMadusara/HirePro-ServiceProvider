import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/ToggleEyeField.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../services/urlCreator.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureText = true;
  IconData _icon = FontAwesomeIcons.eyeSlash;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reEnterNewPasswordController = TextEditingController();
  Map<String,dynamic> changePasswordReply = {};

  Future<String> changePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(urlCreate('changePassword')),
        headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['accessToken']},
        body: jsonEncode({'oldPassword': currentPasswordController.text, 'newPassword': newPasswordController.text})
    );
    if (response.statusCode == 200 || response.statusCode == 401) {
      changePasswordReply = await jsonDecode(response.body);
      // print(changePasswordReply);
      return (response.body);
    } else {
      if(jsonDecode(response.body)['error'] == 'TokenExpiredError'){
        response = await http.get(Uri.parse(urlCreate('refreshToken')),
            headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['refreshToken']});
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['tokens']);
        await prefs.setString('tokens', jsonEncode(jsonResponse['tokens']));
        changePassword();
      }
      throw Exception('Failed to load album');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: BottomNavBar(),
            appBar: AppBarAll(title: 'Change Password',),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ToggleEyeField(
                          obscureText: _obscureText,
                          icon: _icon,
                          placeholder: 'Enter current password',
                          controller: currentPasswordController),
                      ToggleEyeField(
                          obscureText: _obscureText,
                          icon: _icon,
                          placeholder: 'Enter new password',
                          controller: newPasswordController),
                      ToggleEyeField(
                          obscureText: _obscureText,
                          icon: _icon,
                          placeholder: 'Re enter new password',
                          controller: reEnterNewPasswordController),
                      Container(
                        width: 350,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: kMainYellow, fontSize: 14),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      MainButton('Update', () async {
                        if(newPasswordController.text == reEnterNewPasswordController.text){
                          if(newPasswordController.text.length < 8){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password Must Be 8 Characters Long')));
                            return;
                          } else {
                            await changePassword();
                            if(changePasswordReply['error'] == 'Incorrect password'){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect Current Password')));
                              return;
                            } else {
                              print('Password changed');
                              Navigator.pushNamed(context, '/profile');
                            }
                          }
                        } else {
                          print('Passwords do not match');
                        }
                      }),
                    ],
                  ),
                )
              ]),
            )
        )
    );
  }
}
