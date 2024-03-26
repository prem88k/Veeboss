import 'package:flutter/material.dart';

import '../../Contants/Colors.dart';
import '../../Models/Employee/chatMessageModel.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  final TextEditingController  _messageController = TextEditingController();

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: buttonTextColor,
            flexibleSpace: SafeArea(
              child: Container(
                padding: EdgeInsets.only(right: 16),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: (){ Navigator.pop(context); },
                      icon: Icon(Icons.arrow_back,color: Colors.white,),
                    ),
                    SizedBox(width: 2,),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile_photo.jpg'),
                      maxRadius: 20,
                    ),
                    SizedBox(width: 12,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Kriss Benwat",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600, color: whiteTextColor),),
                          SizedBox(height: 6,),
                          Text("Online",style: TextStyle(color: Colors.white54, fontSize: 13),),
                        ],
                      ),
                    ),
                    Container(
                      width: 20,
                        height: 30,
                        alignment: Alignment.center,
                        child: Icon(Icons.call,color: whiteTextColor, size: 25,)),
                    SizedBox(width: 15,),
                    Container(
                      width: 20,
                        height: 40,
                        alignment: Alignment.center,
                        child: Icon(Icons.video_call,color: whiteTextColor, size: 30,)),

                  ],
                ),
              ),
            ),
          ),
        body: Stack(
          children: <Widget>[
            Container(
              child: ListView.builder(
          itemCount: messages.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10,bottom: 10),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return Container(
              padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
              child: Align(
                alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
                ),
              ),
            );
          },
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
                          color: buttonTextColor,
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
                      onPressed: (){},
                      child: Icon(Icons.send,color: Colors.white,size: 18,),
                      backgroundColor: buttonTextColor,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
