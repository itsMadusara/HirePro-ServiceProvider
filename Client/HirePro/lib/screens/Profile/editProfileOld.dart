import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/services/imageUpload.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/smallButton.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

bool isEdited = true;

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

String jsondata =
    '{"full_name": "John Doe", "email": "samaliarachchih@gmail.com", "phone_number": "123-456-7890"}';
var userData = jsonDecode(jsondata);

class _EditProfileState extends State<EditProfile> {
  final keyCounter = GlobalKey<_EditFieldState>();
  String defaultImage = 'images/profile_pic.png';
  final imageUpload = ImageUpload();
  File? _image;
  void changeProfilePicture(ImageSource source) async {
    final file = await imageUpload.pickImage(source);
    if (file != null) {
      final croppedImage =
      await imageUpload.crop(file: file, cropStyle: CropStyle.circle);
      if (croppedImage != null) {
        setState(() {
          _image = File(
            croppedImage.path,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBarWillPopAndMore(isEdited),
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
                            width:
                            150, // Set the desired width of the container
                            height:
                            150, // Set the desired height of the container
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // Create a circular shape
                              border: Border.all(
                                color: kMainYellow, // Set the border color
                                width: 2, // Set the border width
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
                                    foregroundImage: _image != null
                                        ? FileImage(_image!)
                                        : null,
                                    child: Text(
                                      'HS',
                                      style: TextStyle(
                                          fontSize: 48, color: kMainYellow),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            left: 105,
                            child: FloatingActionButton.small(
                                backgroundColor: kMainYellow,
                                child: Icon(
                                  FontAwesomeIcons.camera,
                                  size: 15,
                                ),
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text(
                                          'Change profile picture using,',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        content: const Text(''),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SmallButton('Camera', () async {
                                                changeProfilePicture(
                                                    ImageSource.camera);
                                              }, kMainYellow, Colors.white),
                                              SmallButton('Gallery', () async {
                                                changeProfilePicture(
                                                    ImageSource.gallery);
                                              }, kMainYellow, Colors.white)
                                            ],
                                          )
                                        ],
                                      ),
                                )),
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
                              label: 'Email',
                              value: 'samaliarachchih@gmail.com',
                              edit: () {

                                Navigator.pushNamed(context, '/emailcodeverify',
                                    arguments: userData['email']);
                              }),
                          EditField(
                              label: 'Mobile Number',
                              value: '0761232323',
                              edit: () {
                                print('pressed');
                              }),
                          EditField(label: 'Password', value: '', edit: () {}),
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
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value;
    isPassword();
  }

  void isPassword() {
    password = widget.label == 'Password';
  }

  void isChnages(){

  }

  @override
  Widget build(BuildContext context) {
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
              controller: _controller,
              obscureText: password,
              // readOnly: editField,
              maxLines: widget.label == 'Introduction' ? null : 1, // Set maxLines to null for Introduction field.
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  _controller.text = newValue;
                  isEdited = true; // Set isEdited to true when any field is edited
                  print('Edited');
                });
              },
            ),

            if (password)
              Positioned(
                left: 260,
                top: 14,
                child: SizedBox(
                  height: 30,
                  child: FloatingActionButton.small(
                    onPressed: () {
                      setState(() {
                        editField = !editField;
                      });
                    },
                    backgroundColor: kSecondaryYellow,
                    child: Icon(
                      Icons.arrow_forward_ios,
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