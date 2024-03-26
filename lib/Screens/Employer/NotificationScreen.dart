import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Employee/NotificationModel.dart';
import '../Employee/NotificationJob.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  late NotificationData notificationData;
  late List<NotificationList> notificationList = [];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: appBackground,
        bottomOpacity: 0,
        shape: Border(
            bottom: BorderSide(
                color: borderColors,
                width: 0.5
            )
        ),
        iconTheme: IconThemeData(color: appText),
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Notification Page",
          style: TextStyle(
            color: appText,
            fontSize: 18,
            fontFamily: 'railway',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: appBackground,
      resizeToAvoidBottomInset: false,
      body:  isLoading
          ? Center(
          child: CircularProgressIndicator(
            color: buttonTextColor,
          ))
          : notificationList.length == 0
          ? Center(
        child: Text(
          "No Notification",
          style: TextStyle(
              fontFamily: 'railway',
              fontSize: size.width * 0.055,
              color: appText),
        ),
      )
          : SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              top: size.height * 0.03,
              left: size.width * 0.035,
              right: size.width * 0.035,
              bottom: size.height * 0.03),
          child: Column(
            children: [
              ListView.builder(
                  itemCount: notificationList.length,
                  shrinkWrap: true,
                  physics:  NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(size.width * 0.02),
                  itemBuilder:
                      (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NotificationJobDetails(notificationList[index].jobId.toString());
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10),
                            border: Border.all(
                                color: appButton, width: 0.5)),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.height * 0.50,
                              height: size.height * 0.1,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.notifications_outlined,
                                          color:
                                          appText,
                                          size: 25,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: size.width * 0.040,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:size.width * 0.6,
                                            margin:  EdgeInsets.all(4),
                                            child: Text(
                                              notificationList[
                                              index].title!,
                                              style: TextStyle(
                                                  fontFamily:
                                                  'railway',
                                                  fontSize:
                                                  size.width *
                                                      0.04,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                  appButton),
                                            ),
                                          ),
                                          Container(
                                            width:size.width * 0.6,
                                            margin:  EdgeInsets.all(4),
                                            child: Text(
                                              notificationList[
                                              index].message!,
                                              style: TextStyle(
                                                  fontFamily:
                                                  'railway',
                                                  fontSize:
                                                  size.width *
                                                      0.04,
                                                  color:
                                                  appText),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> getNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/notification',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    var getdata = json.decode(response.body);

    print("NotificationResponse::$responseBody");
    if (statusCode == 200) {
      setState(() {
        isLoading = false;
        notificationData = NotificationData.fromJson(jsonDecode(responseBody));
        notificationList.addAll(notificationData.data!);
      });
    }
  }
}
