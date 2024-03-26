import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Models/Employee/AppliedJobs.dart';
import 'package:veeboss/Models/Employee/MyJobs.dart';
import 'package:veeboss/Screens/Employee/JobProcessScreen.dart';

import '../../ProfileJobDetails.dart';
import '../Employer/EmployerProfilePage.dart';

class EmployeeAppliedJobListPage extends StatefulWidget {
  @override
  _EmployeeAppliedJobListPageState createState() =>
      _EmployeeAppliedJobListPageState();
}

class _EmployeeAppliedJobListPageState extends State<EmployeeAppliedJobListPage>
    with TickerProviderStateMixin {
  bool jobsLoading = false;
  late UserAppliedJobs getAllMyJobPosts;
  List<Jobs> jobListData = [];

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
    '25-06-2023',
    '25-06-2023',
    '15-08-2023',
    '25-06-2023',
    '25-06-2023',
    '25-06-2023',
    '15-08-2023',
    '25-06-2023',
    '25-06-2023',
    '25-06-2023',
    '15-08-2023',
    '25-06-2023',
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
                  backgroundColor: buttonTextColor,
                ))
              : SingleChildScrollView(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Column(
                    children: [
                      jobListData.length == 0
                          ? Center(
                              child: Container(
                                  margin:
                                      EdgeInsets.only(top: size.height * 0.4),
                                  child: Text(
                                    "Jobs Not Found",
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
                                                        new BoxDecoration(
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
                                                          offset: const Offset(
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
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder:
                                                                                (context) {
                                                                              return EmployerProfile(jobListData[index].userId);
                                                                            },
                                                                          ),
                                                                        );
                                                                      },
                                                                      child: jobListData[index].profilePhoto ==
                                                                              null
                                                                          ? Container(
                                                                              alignment: Alignment.topCenter,
                                                                              height: size.height * 0.080,
                                                                              width: size.height * 0.080,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                                                                  image: DecorationImage(image: AssetImage("assets/images/profile.png"), fit: BoxFit.fill)))
                                                                          : Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080,
                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                                                              image: DecorationImage(image: NetworkImage(jobListData[index].profilePhoto.toString()),
                                                                                  fit: BoxFit.fill)))),
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
                                                              EdgeInsets.only(
                                                                  left: size
                                                                          .width *
                                                                      0.035),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Time :',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'railway',
                                                                    fontSize:
                                                                        size.height *
                                                                            0.018,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: appHeader,
                                                              ),),
                                                              SizedBox(
                                                                width:
                                                                    size.width *
                                                                        0.018,
                                                              ),
                                                              Text(
                                                                  jobListData[index].companyStatus == null ?
                                                                jobListData[index].appliedTime.toString()
                                                                    : jobListData[index].companyStatus == "selected" && jobListData[index].comShortlistStatus == null ?
                                                                  jobListData[index].hrTime.toString()
                                                                    :jobListData[index].comShortlistStatus == "accepted" && jobListData[index].hiringStatus == null ?
                                                                  jobListData[index].companyShortlistTime.toString()
                                                                    : jobListData[index].hiringStatus == "hired" ?
                                                                jobListData[index].hiringTime.toString() : jobListData[index].time.toString(),
                                                              //  jobListData[index].time.toString(),
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'railway',
                                                                    fontSize:
                                                                        size.height *
                                                                            0.018,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                    appText),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.010,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: size
                                                                          .width *
                                                                      0.035),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Status :',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'railway',
                                                                    fontSize:
                                                                        size.height *
                                                                            0.018,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                    appHeader),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    size.width *
                                                                        0.018,
                                                              ),
                                                              Text(
                                                                  jobListData[index].companyStatus == null ?
                                                                  "In Review."
                                                                : jobListData[index].companyStatus == "selected" && jobListData[index].comShortlistStatus == null ?
                                                                "Shortlisted By HR."
                                                                :jobListData[index].comShortlistStatus == "accepted" && jobListData[index].hiringStatus == null ?
                                                                "Review By Company."
                                                                : jobListData[index].hiringStatus == "hired" ?
                                                                "Hired By Company" : "Your Profile Was Rejected.",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'railway',
                                                                    fontSize:
                                                                        size.height *
                                                                            0.018,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        appText),
                                                              ),
                                                              SizedBox(
                                                                width: size.width * 0.1,
                                                              ),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                          return JobProcess(
                                                                              jobListData[index]);
                                                                        },
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Container(
                                                                      margin: EdgeInsets.only(bottom: size.height * 0.01),
                                                                      width: size.width * 0.2,
                                                                      height: size.height * 0.045,
                                                                      decoration: BoxDecoration(
                                                                        color:
                                                                            appBackground,
                                                                        borderRadius: BorderRadius.only(
                                                                            topRight:
                                                                                Radius.circular(10.0),
                                                                            topLeft: Radius.circular(10.0),
                                                                            bottomRight: Radius.circular(10.0),
                                                                            bottomLeft: Radius.circular(10.0)),
                                                                        border: Border.all(
                                                                            width:
                                                                                0.4,
                                                                            color:
                                                                                appButton,
                                                                            style:
                                                                                BorderStyle.solid),
                                                                      ),
                                                                      child: Center(
                                                                        child:
                                                                            Text(
                                                                          "Track",
                                                                          style: TextStyle(
                                                                              fontFamily: 'railway',
                                                                              fontSize: size.height * 0.018,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: appHeader),
                                                                        ),
                                                                      )))
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.02,
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
      '/veeboss/public/api/v1/job/myapplied',
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
    print("getUserAppliedJobs::$responseBody");
    if (statusCode == 200) {
      setState(() {
        jobsLoading = false;
      });
      getAllMyJobPosts = UserAppliedJobs.fromJson(jsonDecode(responseBody));
      jobListData.addAll(getAllMyJobPosts.data!);
    }
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
              width: size.width * 0.6,
              child: new Text(
                firstHalf,
                maxLines: 3,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: size.height * 0.015,
                    fontFamily: 'railway',
                    color: appText),
              ),
            )
          : Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: size.width * 0.5,
                    child: Text(
                      flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                      style: TextStyle(
                          fontSize: size.height * 0.015,
                          fontFamily: 'railway',
                          color: appText),
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      flag ? "Read More" : "Read Less",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: appHeader,
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
