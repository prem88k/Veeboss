import 'package:flutter/material.dart';

class ChatUsers{
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers({required this.name,required this.messageText,required this.imageURL,@required required this.time, required String text, required String secondaryText, required String image});
}