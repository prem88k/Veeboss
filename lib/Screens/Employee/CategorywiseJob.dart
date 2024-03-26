import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Contants/Colors.dart';
import '../../Models/Employee/MyJobs.dart';
import '../../ProfileJobDetails.dart';
import '../Employer/myJobs.dart';
import 'VoiceNoteScreen.dart';
class CategoryWiseJob extends StatefulWidget{
  int? id;
  String? name;
  CategoryWiseJob(this. id, this.name);


  @override
  State<CategoryWiseJob> createState() => _CategoryWiseJobState();
}

class _CategoryWiseJobState extends State<CategoryWiseJob> {

  late GetAllMyJobPosts getAllMyJobPosts;
  List<jobList> jobListData = [];
  bool isLoading=false;
  int index = 0;

  bool jobsLoading =false;
  @override
  void initState() {
    // TODO: implement initState
    getJobsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        bottomOpacity: 0,
        shape: Border(
            bottom: BorderSide(
                color: borderColors,
                width: 0.1
            )
        ),
        elevation: 1,
        centerTitle: true,
        iconTheme: IconThemeData(
            color: appText
        ),
        title: Text(widget.name!,   style: TextStyle(
            fontFamily:
            'railway',
            fontSize: size.width *
                0.04,
            fontWeight:
            FontWeight.normal,
            color: appText),),
        backgroundColor: appBackground,

      ),
      body:isLoading?Center(child: CircularProgressIndicator(color: buttonTextColor,)):jobListData.length==0?
      Center(
        child: Text("No Jobs found for this category",   style: TextStyle(
            fontFamily:
            'railway',
            fontSize: size.width *
                0.030,
            fontWeight:
            FontWeight.normal,
            color: appText),),
      ): ListView.builder(
        primary: false,
        //  scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: jobListData.length,
        itemBuilder:
            (BuildContext context, int index) {
          //  status = "pending";
          return Padding(
            padding: EdgeInsets.only(
                top: 0.0,
                bottom: 5.0,
                left: 0.02,
                right: 0.02),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) {
                        return ProfileJobDetails(
                            jobListData[
                            index]);
                      },
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      color: appBackground,
                      padding: EdgeInsets.only(
                          left: size.height * 0.01,
                          right: size.height * 0.01),
                      width: size.width,
                      child: Container(
                        width: size.width,
                        padding: EdgeInsets.only(
                            left: size.width * 0.00),
                        decoration: new BoxDecoration(
                          color: appBackground,
                          border: Border.all(
                              color: borderColors,
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
                          MainAxisAlignment.start,
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
                                          onTap: () {
                                            /*  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return EmployerProfile(jobListData[index].userId);
                                        },
                                      ),
                                    );*/
                                          },
                                          child: jobListData[index].file ==
                                              null
                                              ? Container(
                                              alignment: Alignment
                                                  .topCenter,
                                              height: size.height *
                                                  0.080,
                                              width: size.height *
                                                  0.080,
                                              decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(100), image: DecorationImage(image: AssetImage("assets/images/profile.png"), fit: BoxFit.fill)))
                                              : Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                                  image: DecorationImage(image: NetworkImage(jobListData[index]
                                                      .file!
                                                      .mainImageUrl
                                                      .toString()), fit: BoxFit.cover)))),
                                      SizedBox(
                                        width:
                                        size.width *
                                            0.030,
                                      ),
                                      Container(
                                        width:
                                        size.width *
                                            0.6,
                                        child: Column(
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
                                                  width:
                                                  size.width * 0.6,
                                                  child:
                                                  Text(
                                                    //userList[index],
                                                    jobListData[index].post!=null?jobListData[index].post!:"-",
                                                    style: TextStyle(fontFamily: 'railway', fontSize: size.width * 0.036,
                                                        fontWeight: FontWeight.bold, color: appButton),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height *
                                                  0.006,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Vacancy: ',
                                                  style: TextStyle(
                                                      fontFamily: 'railway',
                                                      fontSize: size.width * 0.028,
                                                      fontWeight: FontWeight.bold,
                                                      color: appText),
                                                ),
                                                SizedBox(
                                                  width:
                                                  size.width * 0.0055,
                                                ),
                                                Text(
                                                  jobListData[index].vacancy.toString(),
                                                  style: TextStyle(
                                                      fontFamily: 'railway',
                                                      fontSize: size.width * 0.028,
                                                      fontWeight: FontWeight.normal,
                                                      color: appText),
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) {
                                            return ProfileJobDetails(
                                                jobListData[
                                                index]);
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
                                ],
                              ),
                            ),

                            SizedBox(
                              height:
                              size.height * 0.015,
                            ),

                            Padding(
                              padding:
                              const EdgeInsets
                                  .only(
                                  left: 12.0,
                                  right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.backpack,
                                    color: appText, size: size.height * 0.025 ,),
                                  SizedBox(
                                    width:
                                    size.width * 0.025,
                                  ),
                                  DescriptionTextWidget(
                                    text: jobListData[index].companyInfo == null ?
                                    "-" :
                                    jobListData[index].companyInfo!,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                              size.height * 0.015,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets
                                  .only(
                                  left: 12.0,
                                  right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on_outlined,
                                    color: appText, size: size.height * 0.025 ,),
                                  SizedBox(
                                    width:
                                    size.width * 0.025,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      /* Text(
                                                                  jobListData[index].city == null ?
                                                                  "-" :
                                                                  jobListData[index].city! + " , ",
                                                                  style: TextStyle(
                                                                      fontFamily: 'railway',
                                                                      fontSize: size.height * 0.015,
                                                                      fontWeight: FontWeight.normal,
                                                                      color: appText),
                                                                ),*/
                                      Text(
                                        jobListData[index].location == null ?
                                        "-" :
                                        jobListData[index].location!,
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.015,
                                            fontWeight: FontWeight.normal,
                                            color: appText),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                              size.height * 0.015,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("₹",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height * 0.025,
                                          fontWeight: FontWeight.normal,
                                          color: appText)),
                                  SizedBox(
                                    width:
                                    size.width * 0.025,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jobListData[index].salary == null ?
                                        "-" : "${jobListData[index].salary!} - " ,
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.020,
                                            fontWeight: FontWeight.normal,
                                            color: appText),
                                      ),
                                      Text(
                                        jobListData[index].salaryEnd == null ?
                                        "-" : "₹ ${jobListData[index].salaryEnd!} salary /month" ,
                                        style: TextStyle(
                                            fontFamily: 'railway',

                                            fontSize: size.height * 0.020,
                                            fontWeight: FontWeight.normal,
                                            color: appText),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                              size.height * 0.010,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                              children: [
                                jobListData[index].file == null
                                    ? Container()
                                    : Padding(
                                  padding: const EdgeInsets
                                      .only(
                                      top: 5.0),
                                  child:
                                  Container(
                                    height:
                                    size.height *
                                        0.3,
                                    width: size
                                        .width *
                                        0.85,
                                    child: Image.network(jobListData[index]
                                        .file!
                                        .mainImageUrl
                                        .toString(), width: size.width),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                              size.height * 0.010,
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
                                        jobListData[index]
                                            .isApply ==
                                            "is_apply"
                                            ? Container(
                                          // padding: EdgeInsets.only(right: 8.0),
                                          child:
                                          Image.asset(
                                            "assets/images/apply_fill.png",
                                            color:
                                            appButton,
                                            height:
                                            size.height * 0.025,
                                          ),
                                        )
                                            : Container(
                                          child:
                                          Image.asset(
                                            "assets/images/apply.png",
                                            height:
                                            size.height * 0.025,
                                            color:
                                            appText,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size
                                              .height *
                                              0.002,
                                        ),
                                        Container(
                                          child: Text(
                                            'Apply',
                                            style: TextStyle(
                                                fontFamily:
                                                'railway',
                                                fontSize: size.width *
                                                    0.030,
                                                fontWeight: FontWeight
                                                    .normal,
                                                color:
                                                primaryTextColor),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      SaveJobs(
                                          jobListData[
                                          index]
                                              .id!
                                              .toInt());
                                    },
                                    child: Column(
                                      children: [
                                        jobListData[index]
                                            .isSave ==
                                            "is_save"
                                            ? Container(
                                          // padding: EdgeInsets.only(right: 8.0),
                                          child:
                                          Image.asset(
                                            "assets/images/save_fill.png",
                                            color:
                                            appButton,
                                            height:
                                            size.height * 0.023,
                                          ),
                                        )
                                            : Container(
                                          // padding: EdgeInsets.only(right: 8.0),
                                          child:
                                          Image.asset(
                                            "assets/images/save.png",
                                            height:
                                            size.height * 0.023,
                                            color:
                                            appText,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size
                                              .height *
                                              0.002,
                                        ),
                                        Container(
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                                fontFamily:
                                                'railway',
                                                fontSize: size.width *
                                                    0.030,
                                                fontWeight: FontWeight
                                                    .normal,
                                                color:
                                                appText),
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
                                            height: size
                                                .height *
                                                0.023,
                                            color:appText,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size
                                              .height *
                                              0.002,
                                        ),
                                        Container(
                                          child: Text(
                                            'Share',
                                            style: TextStyle(
                                                fontFamily:
                                                'railway',
                                                fontSize: size.width *
                                                    0.030,
                                                fontWeight: FontWeight
                                                    .normal,
                                                color:
                                                appText),
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
    );
  }

  Future<void> getJobsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    final headers = {'x-session-token': prefs.getString('sessionToken')!};

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/cetegory-wise-job',
    );
    final encoding = Encoding.getByName('utf-8');

    Map<String, dynamic> body = {
      'cetegory_id': widget.id.toString(),
    };
    int statusCode;
    String responseBody;

    Response response = await post(uri, headers: headers, body: body);
    statusCode = response.statusCode;
    responseBody = response.body;

    print("GetCategoryWise-job::$responseBody");
    if (statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      getAllMyJobPosts = GetAllMyJobPosts.fromJson(jsonDecode(responseBody));
      jobListData.addAll(getAllMyJobPosts.data!);
    }
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
                      color: appText,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
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
                              /*boxShadow: [
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
  Future<void> _onShare(BuildContext context) async {
    // RenderBox? renderBox = context.findRenderObject() as RenderBox;
    await Share.shareWithResult(
        " ${jobListData[index].description!}, ${jobListData[index].post!},"
            "${jobListData[index].vacancy.toString()}, "
            "${jobListData[index].file!.mainImageUrl.toString()}",
        subject: 'Welcome Message',
        sharePositionOrigin: Rect.fromLTWH(15, 50, 15, 50));
  }

}
