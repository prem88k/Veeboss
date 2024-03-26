import 'dart:async';
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Models/Employee/MyJobs.dart';
import 'package:veeboss/Screens/agent/EditJobPost.dart';

import '../../Models/Employee/GetBannerData.dart';
import '../../Presentation/PagerState.dart';
import '../../ProfileJobDetails.dart';
import '../AppliedUsersPage.dart';
import 'ProfileJobDetailsAgent.dart';

class CompanyUserListPage extends StatefulWidget {
  const CompanyUserListPage({Key? key}) : super(key: key);

  @override
  State<CompanyUserListPage> createState() => _CompanyUserListPageState();
}

class _CompanyUserListPageState extends State<CompanyUserListPage> {

  bool jobsLoading = false;

  bool isSelected = false;
  bool isClose = false;

  late GetAllMyJobPosts getAllMyJobPosts;
  List<jobList> jobListData = [];
  bool profileLoading = false;
  String login = '';

  void initState() {
    _loadCounter();
    getCompanyPostData();
    super.initState();
  }
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      login = (prefs.getString('role')) ?? "";
      print(login);
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: jobsLoading
          ? Center(
          child: CircularProgressIndicator(
            backgroundColor: buttonTextColor,
          ))
          : SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: jobListData.length == 0
                  ? Center(
                  child: Container(
                    //  margin: EdgeInsets.only(top: size.height * 0.4),
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontFamily: 'railway',
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500),
                      ))):jobsLoading?Center(child: CircularProgressIndicator(color: appText,))
                  : Container(
                padding: EdgeInsets.only(
                    top: size.height*0.01, bottom: size.height*0.0, left: size.width*0.015, right: 9.0),
                child: Column(
                  children: [
                    /*Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        " Welcome back Agent!",
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.bold,
                            color: appText),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),*/

                    SizedBox(height: size.height*0.005,),
                    Column(
                      children: [
                        Container(
                          child: ListView.builder(
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: jobListData.length,
                            itemBuilder: (BuildContext context, int index) {
                              //  status = "pending";
                              return Container(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.020,
                                    left: size.height * 0.015,
                                    right: size.height * 0.015,
                                    bottom: size.height * 0.015
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        border: Border.all(color: primaryTextColor),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              color: appBackground,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 10,
                                                            top: 8,
                                                            bottom: 10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[

                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                  left:
                                                                  12.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.end,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap: (){
                                                                              _onShare(
                                                                                  context, index);
                                                                            },
                                                                            child: Icon(
                                                                              Icons.share,
                                                                              color: appText,
                                                                              size: size.height*0.03,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width: size.width * 0.02,
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap: () {
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder:
                                                                                      (context) {
                                                                                    return ProfileJobDetailsAgent(
                                                                                        jobListData[index]);
                                                                                  },
                                                                                ),
                                                                              );
                                                                            },
                                                                            child: Container(
                                                                                alignment:
                                                                                Alignment
                                                                                    .topRight,
                                                                                padding: EdgeInsets.only(
                                                                                    right: size
                                                                                        .width *
                                                                                        0.012),
                                                                                child: Icon(
                                                                                  Icons
                                                                                      .visibility_outlined,
                                                                                  color:
                                                                                  appText,
                                                                                )),
                                                                          ),

                                                                          /*GestureDetector(
                                                                            onTap: () {
                                                                              showDataAlert(jobListData[index].id!, index);
                                                                            },
                                                                            child: Icon(
                                                                              Icons.more_vert,
                                                                              color: appText,
                                                                              size: size.height*0.03,
                                                                            ),
                                                                          ),
*/
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: size.height*0.008,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left:
                                                                  5.0,
                                                                  right:
                                                                  0.0),
                                                              child: jobListData[index]
                                                                  .post ==
                                                                  null
                                                                  ? Text(
                                                                "-",
                                                                style:
                                                                TextStyle(
                                                                  color: appText,
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize:
                                                                  size.height * 0.020,
                                                                ),
                                                              )
                                                                  : Row(
                                                                children: [
                                                                  /*  Row(
                                                                                  mainAxisAlignment:
                                                                                  MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Icon(Icons.circle, color:jobListData[index].isClosed==0? Colors.green:Colors.red, size: 15,),
                                                                                  ],
                                                                                ),*/
                                                                  SizedBox(width: size.width*0.015,),
                                                                  Container(
                                                                    width:
                                                                    size.width * 0.75,
                                                                    child:
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.only(
                                                                        right: 5.0,
                                                                        left: 0.0,
                                                                      ),
                                                                      child:
                                                                      Text(
                                                                        jobListData[index].post!,
                                                                        style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.025,
                                                                            fontWeight: FontWeight.bold, color: appButton),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height: size.height*0.010,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left:
                                                                  12.0,
                                                                  right:
                                                                  0.0),
                                                              child: jobListData[index]
                                                                  .vacancy ==
                                                                  null
                                                                  ? Text(
                                                                "-",
                                                                style:
                                                                TextStyle(
                                                                  fontSize:
                                                                  size.height * 0.020,
                                                                ),
                                                              )
                                                                  : Container(
                                                                width:
                                                                size.width * 0.75,
                                                                child:
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets.only(
                                                                    right: 5.0,
                                                                    left: 0.0,
                                                                  ),
                                                                  child:
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Number of Vacancy : ",
                                                                        style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017,
                                                                            fontWeight: FontWeight.normal, color: appText),
                                                                      ),
                                                                      Text(
                                                                        jobListData[index].vacancy.toString(),
                                                                        style: TextStyle(fontFamily: 'railway',
                                                                            fontSize: size.height * 0.017, fontWeight: FontWeight.bold, color: appText),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: size.height * 0.015,
                                                            ),
                                                            /*Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left:
                                                                  12.0,
                                                                  right:
                                                                  0.0),
                                                              child:  Row(
                                                                children: [
                                                                  Text(
                                                                    jobListData[index].salary == null ?
                                                                    "-" : "${jobListData[index].salary} - " ,
                                                                    style: TextStyle(
                                                                        fontFamily: 'railway',
                                                                        fontSize: size.height * 0.020,
                                                                        fontWeight: FontWeight.normal,
                                                                        color: appText),
                                                                  ),
                                                                  Text(
                                                                    jobListData[index].salaryEnd == null ?
                                                                    "-" : "${jobListData[index].salaryEnd} per month" ,
                                                                    style: TextStyle(
                                                                        fontFamily: 'railway',
                                                                        fontSize: size.height * 0.020,
                                                                        fontWeight: FontWeight.normal,
                                                                        color: appText),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),*/


                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left:
                                                                  12.0,
                                                                  right:
                                                                  0.0),
                                                              child:  Container(
                                                                width: size.width * 0.8,
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      jobListData[index].companyInfo == null ?
                                                                      "-" : "${jobListData[index].companyInfo}"
                                                                          "" ,
                                                                      style: TextStyle(
                                                                          fontFamily: 'railway',
                                                                          fontSize: size.height * 0.020,
                                                                          fontWeight: FontWeight.normal,
                                                                          color: appText),
                                                                    ),
                                                                    /*SizedBox(
                                                                      height: size.height * 0.008,
                                                                    ),
                                                                    Text(
                                                                      jobListData[index].city == null ?
                                                                      "-" : "${jobListData[index].city}" ,
                                                                      style: TextStyle(
                                                                          fontFamily: 'railway',
                                                                          fontSize: size.height * 0.020,
                                                                          fontWeight: FontWeight.normal,
                                                                          color: appText),
                                                                    ),*/
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: size.height * 0.008,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left:
                                                                  12.0,
                                                                  right:
                                                                  0.0),
                                                              child: Container(
                                                                width: size.width * 0.7,
                                                                child: DescriptionTextWidget(
                                                                    text: jobListData[index]
                                                                        .description
                                                                        .toString()),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: size.height * 0.012,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                      12.0),
                                                                  child:
                                                                  Text(
                                                                    "Posted ${convertToAgo(
                                                                      jobListData[index]
                                                                          .createdAt!,
                                                                    )}",
                                                                    style:
                                                                    TextStyle(
                                                                        fontSize:
                                                                        size.height * 0.015,
                                                                        fontFamily:
                                                                        'railway',
                                                                        color: appText
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: size
                                                                      .width *
                                                                      0.035,
                                                                ),
                                                                /*InkWell(
                                                                  onTap: (){
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) {
                                                                          return AppliedUsersPage(jobListData[index].id,jobListData[index]);
                                                                        },
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                  Container(
                                                                    //width: 100.0,
                                                                    height:
                                                                    40.0,
                                                                    width:
                                                                    120.0,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color:
                                                                      appHeader,
                                                                      border: Border.all(
                                                                          color: borderColors,
                                                                          width: 1.0),
                                                                      borderRadius:
                                                                      BorderRadius.circular(10.0),
                                                                    ),
                                                                    child:
                                                                    Center(
                                                                      child:
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            'View All Candidates',
                                                                            style: TextStyle(fontSize:size.width*0.025, color: Colors.white,fontFamily:"railway" ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),*/
                                                              ],
                                                            ),

                                                            SizedBox(
                                                              height: size.height * 0.020,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        right: 16,
                                                        top: 8),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .end,
                                                      children: <Widget>[
                                                        Text(
                                                          '',
                                                          textAlign:
                                                          TextAlign
                                                              .left,
                                                          style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            fontSize: 22,
                                                          ),
                                                        ),
                                                      ],
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
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getCompanyPostData() async {
    jobListData.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("---${prefs.getString('sessionToken')}--");
    setState(() {
      jobsLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/job/companyjobs',
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
    print("getCompanyPostData::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;
      print("object");
      setState(() {
        jobsLoading = false;
      });
      getAllMyJobPosts = GetAllMyJobPosts.fromJson(jsonDecode(responseBody));
      jobListData.addAll(getAllMyJobPosts.data!);
    }
  }

  Future<void> _onShare(BuildContext context, int index) async {
    // RenderBox? renderBox = context.findRenderObject() as RenderBox;
    await Share.shareWithResult(
        "${jobListData[index].description!}, ${jobListData[index].post!},"
            "${jobListData[index].vacancy.toString()}, "
            "${jobListData[index].file!.mainImageUrl.toString()}",
        subject: 'Welcome Message',
        sharePositionOrigin: Rect.fromLTWH(15, 50, 15, 50));
  }
}

String convertToAgo(String dateTime) {
  DateTime input =
  intl.DateFormat('yyyy-MM-DDTHH:mm:ss.SSSSSSZ').parse(dateTime, true);
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
  } else {
    return 'just now';
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 250) {
      firstHalf = widget.text.substring(0, 250);
      secondHalf = widget.text.substring(250, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: secondHalf.isEmpty
          ? Container(
        width: size.width * 0.7,
        child: new Text(
          firstHalf,
          maxLines: 3,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: size.height * 0.015,
            fontFamily: 'railway',
            color: appText,
          ),
        ),
      )
          : Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              width: size.width * 0.7,
              child: Text(
                flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                style: TextStyle(
                    fontSize: size.height * 0.015, fontFamily: 'railway', color: appText),
              ),
            ),
            GestureDetector(
              child: Text(
                flag ? "Read More" : "Read Less",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: size.height * 0.015,
                    fontFamily: 'railway'),
              ),
              onTap: () {
                setState(() {
                  flag = !flag;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
