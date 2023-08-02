 import 'package:flutter/material.dart';
 Container GoogleLogin() {
    return Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 187, 187, 187)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 55,
                        width: 350,
                        margin: EdgeInsets.only(bottom: 15),
                        child: RawMaterialButton(
                          onPressed: () {},
                          child: Row(children: [
                            Expanded(
                                flex: 1,
                                child: Image.asset('images/Google_icon.png')),
                            Expanded(
                              flex: 10,
                              child: Center(
                                child: Text(
                                  'Login with Google',
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 16),
                                ),
                              ),
                            ),
                          ]),
                        ));
  }