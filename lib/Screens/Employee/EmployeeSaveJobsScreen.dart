import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Contants/Colors.dart';
import '../../Models/Employee/MyJobs.dart';
import '../../ProfileJobDetails.dart';
import 'VoiceNoteScreen.dart';

class EmployeeSaveJobsScreen extends StatefulWidget {
  const EmployeeSaveJobsScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeSaveJobsScreen> createState() => _EmployeeSaveJobsScreenState();
}

class _EmployeeSaveJobsScreenState extends State<EmployeeSaveJobsScreen>
    with TickerProviderStateMixin {
  bool jobsLoading = false;
  late GetAllMyJobPosts getAllMyJobPosts;
  List<jobList> jobListData = [];
  int index = 0;
  bool isLoading = false;

  @override
  void initState() {
    getUserLists();
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  final bannerList = [
    'assets/images/hire_android.png',
    'assets/images/hire_php.jpg',
    'assets/images/hire_html.png',
    'assets/images/hire_android.png',
    'assets/images/hire_html.png',
    'assets/images/hire_android.png',
    'assets/images/hire_html.png',
    'assets/images/hire_android.png',
    'assets/images/hire_html.png',
    'assets/images/hire_html.png',
    'assets/images/hire_android.png',
    'assets/images/hire_html.png',
    'assets/images/hire_html.png',
    'assets/images/hire_android.png',
    'assets/images/hire_html.png',
    'assets/images/hire_html.png',
    'assets/images/hire_android.png',
    'assets/images/hire_html.png',
  ];

  final dateList = [
    '15-08-2023',
    '11-12-2023',
    '25-06-2023',
    '15-08-2023',
    '25-06-2023',
    '15-08-2023',
    '25-06-2023',
    '15-08-2023',
    '25-06-2023',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return DefaultTabController(
      length: jobListData.length,
      child: Scaffold(
          backgroundColor: appBackground,
          resizeToAvoidBottomInset: true,
          key: _scaffoldKey,
          body: jobsLoading
              ? Center(
              child: CircularProgressIndicator(
                backgroundColor: whiteTextColor,
              ))
              : SingleChildScrollView(
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                jobListData.length == 0
                    ? Center(
                    child: Container(
                        margin:
                        EdgeInsets.only(top: size.height * 0.4),
                        child: Text(
                          " Save Jobs Not Found",
                          style: TextStyle(
                              fontFamily: 'railway',
                              color: appText,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500),
                        )))
                    : Column(
                  children: [
                    Container(
                      child: ListView.builder(
                        primary: false,
                        //  scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: jobListData.length,
                        itemBuilder:
                            (BuildContext context, int index) {
                          //  status = "pending";
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                bottom: 5.0,
                                left: 5.0,
                                right: 5.0),
                            child: GestureDetector(
                              onTap: () {
                                /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return IntroductionScreen();
                                      },
                                    ),
                                  );*/
                              },
                              child: GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Container(
                                      color: appBackground,
                                      padding: EdgeInsets.only(
                                          left: size.height * 0.01,
                                          right:
                                          size.height * 0.01),
                                      width: size.width,
                                      child: Container(
                                        width: size.width,
                                        padding: EdgeInsets.only(
                                            left:
                                            size.width * 0.00),
                                        decoration:
                                        BoxDecoration(
                                          color: appBackground,
                                          border: Border.all(
                                              color: appText,
                                              width: 0.2),
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 0.0,
                                              offset:  Offset(
                                                  0.0, 0.0),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          mainAxisSize:
                                          MainAxisSize.min,
                                          // To make the card compact
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                              EdgeInsets.only(
                                                  left:
                                                  size.width *
                                                      0.020,
                                                  top: 10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      GestureDetector(
                                                          onTap:
                                                              () {
                                                            /*  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return EmployerProfile(jobListData[index].userId);
                                        },
                                      ),
                                    );*/
                                                          },
                                                          child: jobListData[index]
                                                              .file!
                                                              ==
                                                              null
                                                              ? Container(
                                                              alignment: Alignment.topCenter,
                                                              height: size.height * 0.080,
                                                              width: size.height * 0.080,
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), image: DecorationImage(image: AssetImage("assets/images/profile.png"), fit: BoxFit.fill)))
                                                              : Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), image: DecorationImage(image: NetworkImage(jobListData[index]
                                                              .file!
                                                              .mainImageUrl
                                                              .toString()), fit: BoxFit.fill)))),
                                                      SizedBox(
                                                        width: size
                                                            .width *
                                                            0.030,
                                                      ),
                                                      Container(
                                                        width:
                                                        size.width *
                                                            0.6,
                                                        child:
                                                        Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                  width: size.width * 0.6,
                                                                  child: Text(
                                                                    //userList[index],
                                                                    jobListData[index].post!,
                                                                    style: TextStyle(fontFamily: 'railway', fontSize: size.width * 0.036,
                                                                        fontWeight: FontWeight.bold, color: appButton),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              size.height * 0.006,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'Vacancy: ',
                                                                  style: TextStyle(fontFamily: 'railway', fontSize: size.width * 0.028,
                                                                      fontWeight: FontWeight.bold, color: appText),
                                                                ),
                                                                SizedBox(
                                                                  width: size.width * 0.0055,
                                                                ),
                                                                Text(
                                                                  jobListData[index].vacancy.toString(),
                                                                  style: TextStyle(fontFamily: 'railway', fontSize: size.width * 0.028,
                                                                      fontWeight: FontWeight.normal, color: appText),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator
                                                          .push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (context) {
                                                            return ProfileJobDetails(
                                                                jobListData[index]);
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child:
                                                    Container(
                                                        alignment: Alignment
                                                            .topRight,
                                                        padding: EdgeInsets.only(
                                                            right: size.width *
                                                                0.012),
                                                        child:
                                                        Icon(
                                                          Icons
                                                              .visibility_outlined,
                                                          color:
                                                          primaryTextColor,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height *
                                                  0.015,
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  left: 15.0,
                                                  right: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                children: [
                                                  DescriptionTextWidget(
                                                    text: jobListData[
                                                    index]
                                                        .description
                                                        .toString(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height *
                                                  0.010,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                jobListData[index]
                                                    .file ==
                                                    null
                                                    ? Container()
                                                    : Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      top:
                                                      5.0),
                                                  child:
                                                  Container(
                                                    height:
                                                    size.height *
                                                        0.3,
                                                    width: size
                                                        .width *
                                                        0.85,
                                                    decoration:
                                                    BoxDecoration(
                                                      image:
                                                      DecorationImage(
                                                        fit: BoxFit
                                                            .contain,
                                                        image: NetworkImage(jobListData[index]
                                                            .file!
                                                            .mainImageUrl
                                                            .toString()),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height *
                                                  0.010,
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0),
                                              child: Divider(
                                                thickness: 0.1,
                                                color:
                                                primaryTextColor,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  bottom: 10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (jobListData[
                                                      index]
                                                          .isApply !=
                                                          "is_apply") {
                                                        Navigator
                                                            .push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) {
                                                              return VoiceNote(jobListData[index]
                                                                  .id!
                                                                  .toInt());
                                                            },
                                                          ),
                                                        );
                                                      }
                                                      // _showDialog(context);
                                                      //    ApplyJobs(jobListData[index].id!.toInt());
                                                    },
                                                    child: Column(
                                                      children: [
                                                        jobListData[index].isApply ==
                                                            "is_apply"
                                                            ? Container(
                                                          // padding: EdgeInsets.only(right: 8.0),
                                                          child:
                                                          Image.asset(
                                                            "assets/images/apply_fill.png",
                                                            color: appButton,
                                                            height: size.height * 0.025,
                                                          ),
                                                        )
                                                            : Container(
                                                          child:
                                                          Image.asset(
                                                            "assets/images/apply.png",
                                                            height: size.height * 0.025,
                                                            color: appText,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: size
                                                              .height *
                                                              0.002,
                                                        ),
                                                        Container(
                                                          child:
                                                          Text(
                                                            'Apply',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'railway',
                                                                fontSize: size.width *
                                                                    0.030,
                                                                fontWeight:
                                                                FontWeight.normal,
                                                                color: appText),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      SaveJobs(jobListData[
                                                      index]
                                                          .id!
                                                          .toInt());
                                                    },
                                                    child: Column(
                                                      children: [
                                                        jobListData[index].isSave ==
                                                            "is_save"
                                                            ? Container(
                                                          // padding: EdgeInsets.only(right: 8.0),
                                                          child:
                                                          Image.asset(
                                                            "assets/images/save_fill.png",
                                                            color: appButton,
                                                            height: size.height * 0.023,
                                                          ),
                                                        )
                                                            : Container(
                                                          // padding: EdgeInsets.only(right: 8.0),
                                                          child:
                                                          Image.asset(
                                                            "assets/images/save.png",
                                                            height: size.height * 0.023,
                                                            color:appText,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: size
                                                              .height *
                                                              0.002,
                                                        ),
                                                        Container(
                                                          child:
                                                          Text(
                                                            'Save',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'railway',
                                                                fontSize: size.width *
                                                                    0.030,
                                                                fontWeight:
                                                                FontWeight.normal,
                                                                color: appText),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _onShare(
                                                          context);
                                                      // Share.share(jobListData[index].description!, subject: 'Welcome Message');
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          // padding: EdgeInsets.only(right: 8.0),
                                                          child: Image
                                                              .asset(
                                                              "assets/images/send.png",
                                                              height: size.height *
                                                                  0.023,
                                                              color: appText
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: size
                                                              .height *
                                                              0.002,
                                                        ),
                                                        Container(
                                                          child:
                                                          Text(
                                                            'Share',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'railway',
                                                                fontSize: size.width *
                                                                    0.030,
                                                                fontWeight:
                                                                FontWeight.normal,
                                                                color: appText),
                                                          ),
                                                        )
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
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Future<void> getUserLists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      jobsLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/savejob-get',
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
    print("getUserSaveJobs::$responseBody");
    if (statusCode == 200) {
      setState(() {
        jobsLoading = false;
      });
      getAllMyJobPosts = GetAllMyJobPosts.fromJson(jsonDecode(responseBody));
      jobListData.addAll(getAllMyJobPosts.data!);
    }
  }

  Future<void> _onShare(BuildContext context) async {
    // RenderBox?   renderBox = context.findRenderObject() as RenderBox;
    await Share.shareWithResult(
        " ${jobListData[index].description!}, ${jobListData[index].post!},"
            "${jobListData[index].vacancy.toString()}, "
            "${jobListData[index].file!.mainImageUrl.toString()}",
        subject: 'Welcome Message',
        sharePositionOrigin: Rect.fromLTWH(15, 50, 15, 50));
  }

  Future<void> SaveJobs(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      jobsLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/job/save',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };
    Map<String, dynamic> body = {
      'job_id': id.toString(),
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("response::$responseBody");
    if (statusCode == 200) {
      setState(() {
        jobsLoading = false;
      });
      prefs.setBool("isLogging", true);

      FocusScope.of(context).requestFocus(FocusNode());
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          _showSaveJobDialog(context);
        });
      });
    } else {
      setState(() {
        jobsLoading = false;
      });
    }
  }

  _showSaveJobDialog(BuildContext ctx) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      builder: (context) => SimpleDialog(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
            color: Colors.white,
            child: Image.asset(
              "assets/images/checklist.png",
              height: 110.0,
            ),
          ),
          Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "Are you want to applied this job ?",
                  style: TextStyle(
                      fontFamily: "railway",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: appText,
                      fontSize: 15.0),
                ),
              )),
          Container(
            padding: EdgeInsets.only(top: 15.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.035,
                  ),
                  isLoading
                      ? CircularProgressIndicator(
                    backgroundColor: buttonTextColor,
                  )
                      : GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      //   AddToCart(widget.item.id);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(size.width * 0.01),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: appButton,
                              /* boxShadow: [
                                      BoxShadow(
                                          color: buttonTextColor,
                                          spreadRadius: 1),
                                    ],*/
                            ),
                            width: size.width * 0.25,
                            height: size.height * 0.05,
                            child: Center(
                                child: Text(
                                  "Save Jobs",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      fontSize: size.width * 0.04,
                                      color: appText),
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )

          /* Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
                child: Text(
                  "Thank you for Applying for job in this app",
                  style: TextStyle(
                      fontFamily: "railway",
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      fontSize: 17.0,
                      color: Colors.black26),
                  textAlign: TextAlign.center,
                ),
              )),*/
        ],
      ),
      context: ctx,
      barrierDismissible: true,
    );
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

    if (widget.text.length > 120) {
      firstHalf = widget.text.substring(0, 120);
      secondHalf = widget.text.substring(120, widget.text.length);
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
        width: size.width * 0.8,
        child: new Text(
          firstHalf,
          maxLines: 2,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: size.height * 0.015,
              fontFamily: 'railway',
              color: appText
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
                    fontSize: size.height * 0.015, fontFamily: 'railway',color: appText),
              ),
            ),
            GestureDetector(
              child: Text(
                flag ? "Read More" : "Read Less",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color:appButton,
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
