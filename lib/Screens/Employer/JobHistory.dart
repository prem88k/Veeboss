import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Models/Employee/ApplicantsData.dart';
import 'package:veeboss/Screens/Employer/BottomNavigationBar.dart';


class ApplicantsPage extends StatefulWidget {
  int id;
  SharedPreferences prefs;

  ApplicantsPage(this.id, this.prefs, ) ;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ApplicantsPage>
    with TickerProviderStateMixin {

  late ApplicantsData applicantsData;
  bool jobsLoading = false;
  List<Users> usersLists = [];


  @override
  void initState() {
   
    getUserLists();
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          shadowColor: primaryColor,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Applied Users",
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.05,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height:size.height*0.3,
            child: ListView.builder(
              primary: false,
              scrollDirection: Axis.horizontal,
              shrinkWrap: false,
              itemCount:usersLists.length,
              itemBuilder: (BuildContext context, int index) {
                //  status = "pending";

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              height: 240.0,
                              color: whiteTextColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  child: Image.asset(
                                                      'assets/images/logouser.png'),
                                                ),
                                                SizedBox(
                                                  width: 7.0,
                                                ),
                                                Text(
                                                  usersLists[index].name!,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12.0,
                                            ),
                                            Container(
                                              margin:
                                              EdgeInsets.only(left: 12.0),
                                              child: Text(
                                                usersLists[index].email!,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(3.0),
                                              height: 60.0,
                                              margin:
                                              EdgeInsets.only(left: 12.0),
                                              child: Text(
                                                usersLists[index].contactNo!,
                                                textAlign: TextAlign.left,
                                                maxLines: 3,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10.0,),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[
                                                new InkWell(
                                                  onTap: () => DeclinedJob(),
                                                  child: new Container(
                                                    //width: 100.0,
                                                    height: 40.0,
                                                    width: 120.0,
                                                    decoration:
                                                    new BoxDecoration(
                                                      color: primaryColor,
                                                      border: new Border.all(
                                                          color: Colors.white,
                                                          width: 2.0),
                                                      borderRadius:
                                                      new BorderRadius
                                                          .circular(10.0),
                                                    ),
                                                    child: new Center(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(6.0),
                                                            child:  Icon(
                                                              Icons.cancel,
                                                              color: Colors.white,
                                                              size: 16,
                                                            ),
                                                          ),
                                                          new Text(
                                                            'Declined',
                                                            style: new TextStyle(
                                                                fontSize: 12.0,
                                                                color:
                                                                Colors.white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                             /*   new InkWell(
                                                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatScreen(user: hotelData,prefs:prefs))),
                                                  *//*onTap: () => print('hello'),*//*
                                                  child: new Container(
                                                    //width: 100.0,
                                                    height: 40.0,
                                                    width: 120.0,
                                                    decoration:
                                                    new BoxDecoration(
                                                      color: kPrimaryColor,
                                                      border: new Border.all(
                                                          color: Colors.white,
                                                          width: 2.0),
                                                      borderRadius:
                                                      new BorderRadius
                                                          .circular(10.0),
                                                    ),
                                                    child: new Center(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(6.0),
                                                            child:  Icon(

                                                              Icons.chevron_right,
                                                              color: Colors.white,
                                                              size: 16,
                                                            ),
                                                          ),
                                                          new Text(
                                                            'Message',
                                                            style: new TextStyle(
                                                                fontSize: 12.0,
                                                                color:
                                                                Colors.white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),*/
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
      ),
    );
  }



  Future<void> getUserLists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      jobsLoading = true;
    });
    
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/job/detalis/${widget.id.toString()}',
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
    print("applicantsData::$responseBody");
    if (statusCode == 200) {
      setState(() {
        jobsLoading = false;
      });
      applicantsData = ApplicantsData.fromJson(jsonDecode(responseBody));
      usersLists.addAll(applicantsData.data!.users!);
    }
  }

  DeclinedJob() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/job/user/changestatus',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };
    Map<String, dynamic> body = {
      'status': "rejected",

    };
    final encoding = Encoding.getByName('utf-8');
    Response response = await post(
      uri,
      body: body,
      headers: headers,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("responseAddPost::$responseBody");
    if (statusCode == 200) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return bottomNavigationBarEmployer();
            },
          ),
        );
      });
    }
  }}


