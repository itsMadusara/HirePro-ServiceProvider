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
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/urlCreator.dart';

class UploadProfilePicture extends StatefulWidget {
  @override
  State<UploadProfilePicture> createState() => _UploadProfilePictureState();
}

class _UploadProfilePictureState extends State<UploadProfilePicture> {
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
            appBar: AppBarTitle(title: 'Upload Profile Picture'),
            resizeToAvoidBottomInset: false,
            body: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 250,
                            height: 250,
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
                                    radius: 120,
                                    backgroundColor: kMainGrey,
                                    foregroundImage: _image != null
                                        ? FileImage(_image!)
                                        : null,
                                    child: Icon(Icons.person, color: Colors.grey,size: 60,)
                                    // Text(
                                    //   'HS',
                                    //   style: TextStyle(
                                    //       fontSize: 48, color: kMainYellow),
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 200,
                            left: 165,
                            child: FloatingActionButton.small(
                                backgroundColor: kMainYellow,
                                child: Icon(
                                  FontAwesomeIcons.camera,
                                  size: 18,
                                ),
                                onPressed: () =>
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          Popup(),
                                    )),
                          ),
                        ],
                      ),
                      MainButton("Save", () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        String signupdata = prefs.getString('signupReqBody') ?? '';
                        var response = await http.post(Uri.parse(urlCreate("registerSP")),
                            headers: {'Content-Type': 'application/json'},
                            body: signupdata);
                        var jsonResponse = jsonDecode(response.body);
                        print(jsonResponse);
                        if(jsonResponse['status'] == "True"){
                          print("Signed Successfully");
                          Navigator.pushNamed(context, '/otp_mobile');
                        } else {
                          print("Sign Up Failed");
                        }
                        prefs.remove("signupReqBody");
                        Navigator.pushNamed(context, '/registration_success');
                      }),
                    ],
                  ),
                ),
              ),
            )
    );
  }

  AlertDialog Popup() {
    return AlertDialog(
      title: const Text(
        'Open camera to Upload Profile Picture',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      content: const Text(''),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SmallButton('Camera', () async {
              changeProfilePicture(ImageSource.camera);
            }, kMainYellow, Colors.white),
          ],
        )
      ],
    );
  }
}