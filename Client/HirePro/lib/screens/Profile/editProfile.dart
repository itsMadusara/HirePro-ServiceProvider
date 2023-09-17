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
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/urlCreator.dart';


class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

// String jsondata =
//     '{"full_name": "John Doe", "email": "sachinimuthugala@gmail.com", "phone_number": "123-456-7890"}';
// var userData = jsonDecode(jsondata);

class _EditProfileState extends State<EditProfile> {
  final keyCounterName = GlobalKey<_EditFieldState>();
  final keyCounterIntro = GlobalKey<_EditFieldState>();
  Map<String,dynamic> userData = {};
  bool isLoading = true;

  Future<String> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(urlCreate('getUser')),
        headers: {'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['accessToken']}
    );
    if (response.statusCode == 200) {
      return (response.body);
    } else {
      if(jsonDecode(response.body)['error'] == 'TokenExpiredError'){
        response = await http.get(Uri.parse(urlCreate('refreshToken')),
            headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['refreshToken']});
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['tokens']);
        await prefs.setString('tokens', jsonEncode(jsonResponse['tokens']));
        getUserData();
      }
      throw Exception('Failed to load');
    }
  }

  Future<void> _loadUserData() async {
    try {
      final fetchedData = await getUserData();
      Map<String,dynamic> userDataMap = jsonDecode(fetchedData);
      // userDataMap.forEach((element) {print(element);});
      setState(() {
        userData = userDataMap;
        isLoading = false; // Set isLoading to false after data is loaded
      });
      print(userDataMap);
      return;
    } catch (error) {
      print('Error fetching user data: $error');
      setState(() {
        userData = {};
        isLoading = false; // Set isLoading to false after data is loaded
      });
      return;
    }
  }

  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBarBackAndMore(),
            bottomNavigationBar: BottomNavBar(),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: isLoading ? Center(child: CircularProgressIndicator())
              : Center(
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
                                    foregroundImage: AssetImage('images/profile_picture_mellow.png'),
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
                              key: keyCounterName,
                              label: 'Full Name',
                              value: userData['name'],
                              edit: () {
                                setState(() {
                                  keyCounterName.currentState!.editField =
                                      !keyCounterName.currentState!.editField;
                                });
                              }),
                          EditField(
                              label: 'Email',
                              value: userData['email'],
                              edit: () {
                                Navigator.pushNamed(
                                    context, '/emailcoderequest',
                                    arguments: userData['email']);
                              }),
                          EditField(
                              label: 'Mobile Number',
                              value: userData['contact'],
                              edit: () {
                                Navigator.pushNamed(
                                    context, '/otp_phone',
                                    arguments: userData['phone_number']);
                              }),
                          EditField(
                              key: keyCounterIntro,
                              label: 'Introduction',
                              value: userData['intro'],
                              edit: () {
                                setState(() {
                                  keyCounterIntro.currentState!.editField =
                                  !keyCounterIntro.currentState!.editField;
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
