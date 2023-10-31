import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_pro/Controllers/validationController.dart';
import 'package:hire_pro/widgets/FormFieldRegular.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../services/urlCreator.dart';

class WalletDetails extends StatefulWidget {
  const WalletDetails({super.key});

  @override
  State<WalletDetails> createState() => _WalletDetailsState();
}

class _WalletDetailsState extends State<WalletDetails> {
  ValidationController validationController = ValidationController();
  TextEditingController cardNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  late SharedPreferences preferences;
  final _walletDetailsFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBarTitle(title: 'Add Wallet',),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
              child: Container(
                height: 1000,
                child: Column(
                  children: [
                    Form(
                      key: _walletDetailsFormKey,
                      child:Expanded(
                        flex: 13,
                        child:
                        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Container(
                            height: 450,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 15),
                                        Text('Card Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        Text(
                                          ' *',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    FormFieldRegular('Card Number', cardNoController, false, (val) {
                                      if (validationController.cardNumberValidator(val) != null)
                                        return validationController.cardNumberValidator(val);
                                      return null;}),
                                  ],
                                ),

                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 15),
                                        Text('Card Holders Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        Text(
                                          ' *',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    FormFieldRegular('Card Holder Name', nameController, false, (val) {
                                      if (validationController.nameValidator(val) != null)
                                        return validationController.nameValidator(val);
                                      return null;}),
                                  ],
                                ),

                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 15),
                                        Text('Bank Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        Text(
                                          ' *',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    FormFieldRegular('Bank Name', bankNameController, false, (val) {
                                      if (validationController.nameValidator(val) != null)
                                        return validationController.nameValidator(val);
                                      return null;}),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 15),
                                        Text('Branch Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        Text(
                                          ' *',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    FormFieldRegular('Branch Name', branchNameController, false, (val) {
                                      if (validationController.nameValidator(val) != null)
                                        return validationController.nameValidator(val);
                                      return null;}),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MainButton('Add', () {
                                  if (_walletDetailsFormKey.currentState!.validate()) {
                                    addBankDetails();
                                    Navigator.pushNamed(context, '/view_wallet');
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
                  ],
                ),
              )
          ),
        ));
  }

  Future<String> addBankDetails() async {
    if (nameController.text.isNotEmpty && bankNameController.text.isNotEmpty && cardNoController.text.isNotEmpty && branchNameController.text.isNotEmpty) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(urlCreate('addBankDetails')),
        headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['accessToken']},
        body: jsonEncode({
          'account_no' : cardNoController.text,
          'card_holder_name' : nameController.text,
          'bank_name' : bankNameController.text,
          'branch_name' : branchNameController.text,})
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
        addBankDetails();
      }
      throw Exception('Failed to post bank details');
    }
    } else {
      throw Exception('Failed to load album');
    }
  }
}
