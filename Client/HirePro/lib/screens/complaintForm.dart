import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hire_pro/Controllers/validationController.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/services/urlCreator.dart';
import 'package:hire_pro/widgets/FormFieldRegular.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/UploadMultipleImagesBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ComplaintForm extends StatefulWidget {
  Map<String,dynamic> taskDetails;
  ComplaintForm({required this.taskDetails});
  @override
  State<ComplaintForm> createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBarTitle(title: 'Report an Issue',),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 800,
                child: Column(
                  children: [
                    Form(
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start, children: [
                          Container(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        Text(
                                          ' *',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Container(
                                      height: 150, // Set the desired height for the TextField
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      ),
                                      child: SingleChildScrollView(
                                        child: TextField(
                                          controller: textController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            hintText: 'Enter clear description of the issue',
                                            border: InputBorder.none,
                                          ),
                                          maxLines: null,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft, // Align text to the left
                            child: Text('Images for proof', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          SizedBox(height: 13),
                          UploadMultipleImagesBox('Upload Images'),
                          SizedBox(height: 20),
                          Container(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MainButton('Add', () {
                                addComplaint();
                                Navigator.pushNamed(context, '/home');
                              }
                                // {
                                //   signUpUser();
                                //   Navigator.pushNamed(context, '/otp_mobile');
                                // }
                              ),
                            ],
                          ),
                          )
                        ]),
                      ),
                  ],
                ),
              )
          ),
          )
        ));
  }

  void signUpUser() async {
    if (textController.text.isNotEmpty) {
    }
  }

  Future<String> addComplaint() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await http.post(Uri.parse(urlCreate('addComplaint')),
          headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['accessToken']},
          body: jsonEncode({
            'content' : textController.text,
            'serviceid' : widget.taskDetails['serviceValue']['id'],})
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
          addComplaint();
        }
        throw Exception('Failed to post COMPLAINT details');
      }
  }
}
