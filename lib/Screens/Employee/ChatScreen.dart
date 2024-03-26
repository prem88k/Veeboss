import 'package:flutter/material.dart';
import '../../Models/Employee/chatUsersModel.dart';
import '../../Models/Employee/conversationList.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  List<ChatUsers> chatUsers = [
    ChatUsers(text: "Jane Russel", secondaryText: "Awesome Setup", image: "assets/images/profile_photo.jpg", time: "Now", messageText: 'Awesome Setup', imageURL: '', name: 'Jane Russel'),
    ChatUsers(text: "Glady's Murphy", secondaryText: "That's Great", image: "assets/images/profile_photo.jpg", time: "Yesterday", imageURL: '', messageText: 'Awesome Setup', name: 'Jane Russel'),
    ChatUsers(text: "Jorge Henry", secondaryText: "Hey where are you?", image: "assets/images/profile_photo.jpg", time: "31 Mar", messageText: 'Awesome Setup', imageURL: '', name: 'Jane Russel'),
    ChatUsers(text: "Philip Fox", secondaryText: "Busy! Call me in 20 mins", image: "assets/images/profile_photo.jpg", time: "28 Mar", messageText: 'Awesome Setup', imageURL: '', name: 'Jane Russel'),
    ChatUsers(text: "Debra Hawkins", secondaryText: "Thankyou, It's awesome", image: "assets/images/profile_photo.jpg", time: "23 Mar", messageText: 'Awesome Setup', imageURL: '', name: 'Jane Russel'),
    ChatUsers(text: "Jacob Pena", secondaryText: "will update you in evening", image: "assets/images/profile_photo.jpg", time: "17 Mar", messageText: 'Awesome Setup', imageURL: '', name: 'Jane Russel'),
    ChatUsers(text: "Andrey Jones", secondaryText: "Can you please share the file?", image: "assets/images/profile_photo.jpg", time: "24 Feb", messageText: 'Awesome Setup', imageURL: '', name: 'Jane Russel'),
    ChatUsers(text: "John Wick", secondaryText: "How are you?", image: "assets/images/profile_photo.jpg", time: "18 Feb", messageText: 'Awesome Setup', imageURL: '', name: 'Jane Russel'),
  ];

  TextStyle style = TextStyle(fontFamily: 'Proxima', fontSize: 20.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.020,),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                    alignment: Alignment.topLeft,
                    child: Text('Following',textAlign: TextAlign.center, style: TextStyle(fontSize: size.height * 0.020, fontWeight: FontWeight.bold, fontFamily: 'Proxima', color: Colors.black),)),

                SizedBox(height: size.height * 0.020),
              ],
            ),
            Container(
              child: ListView.builder(
                itemCount: chatUsers.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return ConversationList(
                    name: chatUsers[index].name,
                    messageText: chatUsers[index].messageText,
                    imageUrl: chatUsers[index].imageURL,
                    time: chatUsers[index].time,
                    isMessageRead: (index == 0 || index == 3)?true:false,
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 20),
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: (){
                //  Navigator.of(context).push( MaterialPageRoute(builder: (context) => CustomerCarePage()));
                },
                child: Container(
                  height:size.height * 0.045,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(width: 1.5, color: Colors.black),
                  ),
                  child: Center(
                    child: Text("CONTACT CUSTOMER SUPPORT",
                        textAlign: TextAlign.center,
                        style: style.copyWith( color: Colors.black, fontWeight: FontWeight.bold, fontSize: size.height * 0.014, letterSpacing: 5)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
