import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Contants/Colors.dart';
import '../../Models/Employee/MyJobs.dart';
import '../../ProfileJobDetails.dart';
import '../AllJobsDetails.dart';
import '../SearchPage.dart';
import 'VoiceNoteScreen.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewAllJobsDetails extends StatefulWidget {
  const ViewAllJobsDetails({Key? key}) : super(key: key);

  @override
  State<ViewAllJobsDetails> createState() => _ViewAllJobsDetailsState();
}

class _ViewAllJobsDetailsState extends State<ViewAllJobsDetails> {

  late GetAllMyJobPosts getAllMyJobPosts;
  List<jobList> jobListData = [];
  bool isLoading = false;

  @override
  void initState() {
    getJobsData("job/get");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBackground,
        iconTheme: IconThemeData(
            color: appText
        ),
        shape: Border(
            bottom: BorderSide(
                color: borderColors,
                width: 0.5
            )
        ),
        elevation: 1,
        centerTitle: true,
        title: Text("All Jobs",
            style: TextStyle(fontFamily: "railway", color: appText)),
        actions: <Widget>[
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) {
                      return SearchPage();
                    },
                  ),
                );
              },
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: size.height * 0.055,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: appText)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.search, color: appButton,),
                        ),
                        Text("Search Jobs",
                          style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.018,
                              fontWeight: FontWeight.normal,
                              color: primaryTextColor),
                        )
                      ],
                    ),
                  )
              ),
            ),

            Container(
              height: size.height * 0.050,
              width: size.width,
              decoration: BoxDecoration(
                color: appHeader
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Top match jobs for you",
                    style: TextStyle(
                        fontFamily: 'railway',
                        fontSize: size.height * 0.018,
                        fontWeight: FontWeight.normal,
                        color: appBackground),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: size.height * 0.025,
            ),
            // recent job list
            jobListData.length == 0
                ? Center(
                child: Container(
                    margin: EdgeInsets.only(top: size.height * 0.4),
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
                ListView.builder(
                  primary: false,
                  //  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  itemCount: jobListData.length,
                  itemBuilder:
                      (BuildContext context, int index) {
                    //  status = "pending";
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0.0,
                          bottom: 3.0,
                          left: 0.02,
                          right: 0.02),
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
                          /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return IntroductionScreen();
                                    },
                                  ),
                                );*/
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.height * 0.01,
                                  right: size.height * 0.01),
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.00),
                                decoration: new BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(
                                      10),
                                ),
                                child: Card(
                                  elevation: 2,
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
                                            left: 12.0,
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
                                                      /* Navigator.push(
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
                                                        BoxDecoration(borderRadius: BorderRadius.circular(100), image: DecorationImage(image: AssetImage("assets/images/profile.png"), fit: BoxFit.cover)))
                                                        : Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                                            border: Border.all(color: primaryTextColor),
                                                            image: DecorationImage(image: NetworkImage(jobListData[index]
                                                                .file!
                                                                .mainImageUrl
                                                                .toString()), fit: BoxFit.cover)))),
                                                SizedBox(
                                                  width:
                                                  size.width *
                                                      0.015,
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(left: 12.0),
                                                  child: Container(
                                                    width:
                                                    size.width *
                                                        0.5,
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
                                                              size.width * 0.5,
                                                              child:
                                                              Text(
                                                                //userList[index],
                                                                jobListData[index].post!,
                                                                style: TextStyle(fontFamily: 'railway', fontSize: size.width * 0.042,
                                                                    fontWeight: FontWeight.bold, color: appButton),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.007,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              jobListData[index].salary == null ?
                                                              "-" : "₹${jobListData[index].salary!} - " ,
                                                              style: TextStyle(
                                                                  fontFamily: 'railway',
                                                                  fontSize: size.height * 0.017,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: appText),
                                                            ),
                                                            Text(
                                                              jobListData[index].salaryEnd == null ?
                                                              "-" : "₹${jobListData[index].salaryEnd!}" ,
                                                              style: TextStyle(
                                                                  fontFamily: 'railway',
                                                                  fontSize: size.height * 0.017,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: appText),
                                                            ),
                                                            Text(
                                                              "  salary /month" ,
                                                              style: TextStyle(
                                                                  fontFamily: 'railway',
                                                                  fontSize: size.height * 0.016,
                                                                  fontWeight: FontWeight.normal,
                                                                  color: appText),
                                                            ),
                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            /*GestureDetector(
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
                                                          ),*/
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
                                            right: 0.0),
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
                                            right: 0.0),
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
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                SizedBox(
                                                  width:
                                                  size.width * 0.025,
                                                ),
                                                Icon(Icons.arrow_forward_ios_sharp, size: 12, color: appButton,),
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
                                        child:  Container(
                                          height: size.height * 0.035,
                                          width: size.width * 0.24,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: primaryTextColor)
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 3.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    jobListData[index].vacancy.toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'railway',
                                                        fontSize: size.width * 0.032,
                                                        fontWeight: FontWeight.normal,
                                                        color: primaryTextColor),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.0055,
                                                  ),
                                                  Text(
                                                    ' Vacancies',
                                                    style: TextStyle(
                                                        fontFamily: 'railway',
                                                        fontSize: size.width * 0.030,
                                                        fontWeight: FontWeight.normal,
                                                        color: primaryTextColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      /* SizedBox(
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
                                                                          0.15,
                                                                  width: size
                                                                          .width *
                                                                      0.6,
                                                                      child: Image.network(jobListData[index]
                                                                          .file!
                                                                          .mainImageUrl
                                                                          .toString(), width: size.width),
                                                                ),
                                                              ),
                                                      ],
                                                    ),*/
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
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int index = 0;

  Future<void> _onShare(BuildContext context) async {
    // RenderBox? renderBox = context.findRenderObject() as RenderBox;
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
      isLoading = true;
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
        isLoading = false;
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
        isLoading = false;
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
                  "Are you want to save this job ?",
                  style: TextStyle(
                      fontFamily: "railway",
                      fontWeight: FontWeight.w700,
                      color: appText,
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

        ],
      ),
      context: ctx,
      barrierDismissible: true,
    );
  }

  Future<void> getJobsData(String endPoint, [int? id]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    final headers = {'x-session-token': prefs.getString('sessionToken')!};

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/$endPoint',
    );

    final encoding = Encoding.getByName('utf-8');

    Map<String, dynamic> body = {
      'cetegory_id': id.toString(),
    };
    int statusCode;
    String responseBody;

    if (endPoint == "cetegory-wise-job") {
      print("cetegory-wise");
      Response response = await post(uri, headers: headers, body: body);
      statusCode = response.statusCode;
      responseBody = response.body;
    } else {
      Response response = await get(
        uri,
        headers: headers,
      );
      statusCode = response.statusCode;
      responseBody = response.body;
    }

    print("getUserPostJobs::$responseBody");
    if (statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      getAllMyJobPosts = GetAllMyJobPosts.fromJson(jsonDecode(responseBody));
      jobListData.addAll(getAllMyJobPosts.data!);
    }
  }

}
