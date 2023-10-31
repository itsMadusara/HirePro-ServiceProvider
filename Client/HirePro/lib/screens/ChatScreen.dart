import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:flutter/services.dart';
import 'package:hire_pro/services/chatService.dart';


class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> taskDescription;
  const ChatScreen({super.key, required this.taskDescription});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  // receiverId --> CustomerId
  String receiverId = '1';
  String taskId = '138';
  String currentUserId = '15';


  @override
  void initState() {
    super.initState();
    // Scroll to the bottom when the widget first loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await setId();
    });
  }

  Future<String> setId() async{
    try{
      receiverId = widget.taskDescription['customerId'];
      taskId = widget.taskDescription['serviceValue']['id'];
      currentUserId = widget.taskDescription['providerId'];
      return('1');
    } catch (err){
      print(err);
      return('0');
    }
  }

  void sendMessage() async {
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(receiverId, _messageController.text,taskId,currentUserId);
      _messageController.clear();
    }
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildMessageList(){
    return StreamBuilder(stream: _chatService.getMessage(taskId), builder: (context,snapshot){
      if(snapshot.hasError){
        return Text('Error${snapshot.error}');
      }
      if(snapshot.connectionState ==  ConnectionState.waiting){
        return const Text('Loading .. ');
      }
      return ListView(
        children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
      );
    }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    bool sender = false;
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    if(data['senderId'] == currentUserId){
      sender = true;
    }
    var alignment =  (data['senderId'] == currentUserId)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      padding:
      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      alignment: alignment,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (!sender
                  ? Colors.grey.shade200
                  : Colors.blue[200]),
            ),
            padding: EdgeInsets.all(16),
            child: Text(
              data['message'],
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
        // children: [
        //   Text(data['message'])
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: SafeArea(
                child: Container(
                  height: 500,
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back,color: Colors.black,),
                      ),
                      SizedBox(width: 2,),
                      CircleAvatar(
                        backgroundImage: AssetImage('images/profile_pic.png'),
                        maxRadius: 20,
                      ),
                      SizedBox(width: 12,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.taskDescription['customerName'],style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                      // Icon(Icons.settings,color: Colors.black54,),
                    ],
                  ),
                ),
              ),
            ),
          body: Stack(
            children: <Widget>[
              Scrollbar(
                controller: _scrollController,
                child:Container(
                  margin: EdgeInsets.fromLTRB(0,0,0,60),
                  child: _buildMessageList(),
                ),
              ),

              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: kMainYellow,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 20, ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      FloatingActionButton(
                        onPressed: (){
                          sendMessage();
                        },
                        child: Icon(Icons.send,color: Colors.white,size: 18,),
                        backgroundColor: kMainYellow,
                        elevation: 0,
                      ),
                    ],

                  ),
                ),
              ),
            ],
          ),
            )
        );
  }
}




