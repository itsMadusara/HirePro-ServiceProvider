import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/smallButton.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

String jsondata =
    '{"full_name": "John Doe", "email": "sachinimuthugala@gmail.com", "phone_number": "123-456-7890"}';
var userData = jsonDecode(jsondata);

class _EditProfileState extends State<EditProfile> {
  final keyCounter = GlobalKey<_EditFieldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBarBackAndMore(),
            bottomNavigationBar: BottomNavBar(),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  height: 900,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: kMainYellow,
                                width: 2,
                              ),
                            ),
                            child: Hero(
                              tag: 'image',
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: CircleAvatar(
                                    radius: 72,
                                    backgroundColor: kMainGrey,
                                    foregroundImage: AssetImage('images/profile_pic.png'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Edit Account',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      Column(
                        children: [
                          EditField(
                              key: keyCounter,
                              label: 'Full Name',
                              value: 'Harini Samaliarachchi',
                              edit: () {
                                setState(() {
                                  keyCounter.currentState!.editField =
                                      !keyCounter.currentState!.editField;
                                });
                              }),
                          EditField(
                              label: 'Email',
                              value: 'sachinimuthugala99@gmail.com',
                              edit: () {
                                Navigator.pushNamed(
                                    context, '/emailcoderequest',
                                    arguments: userData['email']);
                              }),
                          EditField(
                              label: 'Mobile Number',
                              value: '0761232323',
                              edit: () {
                                Navigator.pushNamed(
                                    context, '/otp_phone',
                                    arguments: userData['phone_number']);
                              }),
                          EditField(
                              // key: keyCounter,
                              label: 'Introduction',
                              value: 'HandyNYC (Insured) - We are a Handyman Company Based in NYC That Presenting Home Owners - Renters and Business Solutions For Maintaining and Remodeling Their Property',
                              edit: () {
                                setState(() {
                                  keyCounter.currentState!.editField =
                                  !keyCounter.currentState!.editField;
                                });
                              }),
                          EditField(
                              label: 'Password',
                              value: '',
                              edit: () {
                                Navigator.pushNamed(
                                    context, '/changePassword');
                              }),

                        ],
                      ),
                      MainButton("Save", () {}),
                    ],
                  ),
                ),
              ),
            )));
  }
}

class EditField extends StatefulWidget {
  final String label;
  final String value;
  final VoidCallback edit;

  EditField(
      {super.key,
      required this.label,
      required this.value,
      required this.edit});

  @override
  State<EditField> createState() => _EditFieldState();
}

class _EditFieldState extends State<EditField> {
  bool editField = true;
  bool password = false;

  void isPassword() {
    if (widget.label == 'Password') {
      setState(() {
        password = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    isPassword();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 6),
        Stack(
          children: [
            TextFormField(
              obscureText: password,
              readOnly: editField,
              maxLines: widget.label == 'Introduction' ? null : 1,
              initialValue: widget.value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Positioned(
              left: 265,
              top: 10,
              child: SizedBox(
                height: 30,
                child: FloatingActionButton.small(
                  onPressed: widget.edit,
                  backgroundColor: kSecondaryYellow,
                  child: Icon(
                    password ? Icons.arrow_forward_ios: FontAwesomeIcons.pen,
                    color: Colors.grey[800],
                    size: 12,
                  ),
                  elevation: 1,
                ),
              ),
            ),

          ],
        ),
        SizedBox(height: 6),
      ],
    );
  }
}
