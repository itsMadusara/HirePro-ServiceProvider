import 'package:hire_pro/Models/ServiceProvider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hire_pro/services/urlCreator.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api{

  Future<SP> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(urlCreate('getUser')),
        headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['accessToken']});
    print(jsonDecode(prefs.getString('tokens') ?? ''));
    if (response.statusCode == 200) {
      print((jsonDecode(response.body)));
      return await SP.fromJson(jsonDecode(response.body));
    } else {
      if(jsonDecode(response.body)['error'] == 'TokenExpiredError'){
        response = await http.get(Uri.parse(urlCreate('refreshToken')),
            headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['refreshToken']});
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['tokens']);
        await prefs.setString('tokens', jsonEncode(jsonResponse['tokens']));
        getData();
      }
      throw Exception('Failed to load User Details');
    }
    // final response = await http.get(
    //   Uri.parse(url + 'getUser'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json',
    //     HttpHeaders.authorizationHeader: 'Bearer $sessionToken',
    //   },
    // );
    // try {
    //   if (response.statusCode == 200) {
    //     return await SP.fromJson(jsonDecode(response.body));
    //   } else {
    //     throw Exception('Failed to load Service Provider details');
    //   }
    // } catch (e) {
    //   print(e);
    //   throw (e);
    // }
  }
}