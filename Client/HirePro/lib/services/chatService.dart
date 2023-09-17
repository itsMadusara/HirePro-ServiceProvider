import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/Models/ChatMessageModel.dart';

class ChatService extends ChangeNotifier{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message,String taskId, String currentUserId) async{

    // get the current user id
    // final String currentUserID = '23';
    final Timestamp timestamp = Timestamp.now();
    
    // create new message
    Message newMessage = Message(senderId: currentUserId, receiverId: receiverId, timestamp: timestamp, message: message);

    // add new message to database
    await firestore.collection('chat').doc(taskId).collection('message').add(newMessage.toMap());
  }
  
  Stream<QuerySnapshot> getMessage(String taskId){
    return firestore.collection('chat').doc(taskId).collection('message').orderBy('timestamp',descending: false).snapshots();
  }
}