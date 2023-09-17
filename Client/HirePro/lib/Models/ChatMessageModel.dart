import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String receiverId;
  Timestamp timestamp;
  String message;

  Message(
      {required this.senderId,
        required this.receiverId,
        required this.timestamp,
        required this.message,
        });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'message': message,
    };
  }
}