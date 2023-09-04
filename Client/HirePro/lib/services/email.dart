import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Email {
  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final serviceId = 'service_6jijtzg';
    final templateId = 'template_io5fq08';
    final userId = 'sa8ph4jsaJWpS0DWl';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'to_email': email,
            'user_name': name,
            'user_email': 'hireprogrp34@gmail.com',
            'user_subject': subject,
            'user_message': message,
          }
        }));
    print(response.body);

  }
  int generateRandomNumber() {
  Random random = Random();
  int verificationCode = random.nextInt(90000) + 10000;
  return verificationCode;
}
}
