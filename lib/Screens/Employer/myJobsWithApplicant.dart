import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Models/Employee/MyJobs.dart';
import 'package:veeboss/Screens/agent/EditJobPost.dart';
import 'package:veeboss/Screens/Employer/JobHistory.dart';



class MyJobsApplicant extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyJobsApplicant>  with TickerProviderStateMixin{

  bool jobsLoading=false;
  late GetAllMyJobPosts getAllMyJobPosts;
  List<jobList> jobListData= [];
  late SharedPreferences prefs;
  @override
  void initState() {
    getPostData();
    super.initState();
  }
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return DefaultTabController(
      length: jobListData.length,
      child: Scaffold(
       key: _scaffoldKey,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height:size.height*0.3,
            child: ListView.builder(
              primary: false,
              scrollDirection: Axis.vertical,
              shrinkWrap: false,
              itemCount:jobListData.length,
              itemBuilder: (BuildContext context, int index) {
                //  status = "pending";

                return  Container(
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
                                    /*        CircleAvatar(
                                                  child: Image.asset(
                                                      'assets/images/logouser.png'),
                                                ),
                                                SizedBox(
                                                  width: 7.0,
                                                ),
                                                Text(
                                                  hotelData.name,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12.0,
                                                ),*/
                                  ],
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Container(
                                  margin:
                                  EdgeInsets.only(left: 12.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        jobListData[index].post!,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                         /* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return EditPost(
                                                    jobListData[index]
                                                        .id!);
                                              },
                                            ),
                                          );*/
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
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
                                    jobListData[index].description!,
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3.0),
                                  margin:
                                  EdgeInsets.only(left: 12.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Number of Vacancy :",
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          color: primaryColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        jobListData[index].vacancy
                                            .toString(),
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    new InkWell(
                                      child: new Container(
                                        //width: 100.0,
                                        height: 40.0,
                                        width: 140.0,
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
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => ApplicantsPage(jobListData[index].id!,prefs)));
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(6.0),
                                                  child: Icon(
                                                    Icons.verified_user,
                                                    color: Colors
                                                        .white,
                                                    size: 16,
                                                  ),
                                                ),
                                                new Text(
                                                  'Applied Users',
                                                  style: new TextStyle(
                                                      fontSize:
                                                      12.0,
                                                      color: Colors
                                                          .white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 4),
                                  child: Row(
                                    children: <Widget>[
                                      /*       SmoothStarRating(
                                                    allowHalfRating: true,
                                                    starCount: 5,
                                                    size: 20,
                                                    color: HotelAppTheme
                                                            .buildLightTheme()
                                                        .primaryColor,
                                                    borderColor: HotelAppTheme
                                                            .buildLightTheme()
                                                        .primaryColor,
                                                  ),*/
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16, top: 8),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
      ),
    );
  }


  Future<void> getPostData() async {
     prefs = await SharedPreferences.getInstance();
    setState(() {
      jobsLoading = true;
    });
     var uri = Uri.https(
       'yourang.shop',
       '/veeboss/public/api/v1/job/mypost',
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
    print("getProfileData::$responseBody");
    if (statusCode == 200) {
      setState(() {
        jobsLoading=false;
      });
      getAllMyJobPosts=GetAllMyJobPosts.fromJson(jsonDecode(responseBody));
      jobListData.addAll(getAllMyJobPosts.data!);
    }
  }
}