import 'package:flutter/material.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Models/Vendor/GetAllRecruiterData.dart';
import 'package:veeboss/Screens/Vendor/VendorAddRecruiter.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Models/Employee/MyJobs.dart';
import '../Employer/homepage.dart';
import 'RecruiterAppCount.dart';

class VendorAllRecruiter extends StatefulWidget {
  const VendorAllRecruiter({Key? key}) : super(key: key);

  @override
  State<VendorAllRecruiter> createState() => _VendorAllRecruiterState();
}

class _VendorAllRecruiterState extends State<VendorAllRecruiter> {

  late GetAllRecruiterData getAllRecruiterData;
  List<RecruiterList> recruiterList = [];
  bool jobsLoading = false;

  void initState() {
  getRecruiterPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
    backgroundColor: appBackground,
    body: jobsLoading
        ? Center(
        child: CircularProgressIndicator(
          backgroundColor: buttonTextColor,
        ))
        : SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: size.height * 0.020,
            left: size.height * 0.015,
            right: size.height * 0.015,
            bottom: size.height * 0.015
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(

                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return VendorAddRecruiter();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: size.height * 0.055,
                    width: size.width * 0.36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: appButton,
                        borderRadius: BorderRadius.circular((10.0)),
                        border: Border.all(color: appHeader)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " Add Recruiter ",
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.bold,
                                color: appBackground),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height*0.020,),

            Column(
              children: [
                Container(
                  child: ListView.builder(
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recruiterList.length,
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
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                            return RecruiterAppCount(recruiterList[index].id.toString());
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Icon(
                                                                      Icons.remove_red_eye_rounded,
                                                                      color: appText,
                                                                      size: size.height*0.03,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: size.height*0.002,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        recruiterList[index].profileImage ==
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
                                                            : Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), image: DecorationImage(image: NetworkImage(recruiterList[index].profileImage.toString()), fit: BoxFit.cover))),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              left:
                                                              5.0,
                                                              right:
                                                              2.0),
                                                          child: recruiterList[index].name ==
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
                                                              SizedBox(width: size.width*0.015,),
                                                              Container(
                                                                width:
                                                                size.width * 0.6,
                                                                child:
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets.only(
                                                                    right: 0.0,
                                                                    left: 0.0,
                                                                  ),
                                                                  child:
                                                                  Text(
                                                                    recruiterList[index].name!,
                                                                    style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.022,
                                                                        fontWeight: FontWeight.bold, color: appButton),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
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
                                                      child: recruiterList[index].email ==
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
                                                                recruiterList[index].email!,
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
                                                    Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left:
                                                                  12.0,
                                                                  right:
                                                                  0.0),
                                                              child:  Row(
                                                                children: [
                                                                  Text(
                                                                    recruiterList[index].contactNo == null ?
                                                                    "-" : "${recruiterList[index].contactNo}" ,
                                                                    style: TextStyle(
                                                                        fontFamily: 'railway',
                                                                        fontSize: size.height * 0.020,
                                                                        fontWeight: FontWeight.normal,
                                                                        color: appText),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                  /*  Padding(
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
                                                              recruiterList[index].companyInfo == null ?
                                                              "-" : "${recruiterList[index].companyInfo}" ,
                                                              style: TextStyle(
                                                                  fontFamily: 'railway',
                                                                  fontSize: size.height * 0.020,
                                                                  fontWeight: FontWeight.normal,
                                                                  color: appText),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),*/
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
                                                              recruiterList[index]
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
    );
  }

  Future<void> getRecruiterPostData() async {
    recruiterList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("---${prefs.getString('sessionToken')}--");
    setState(() {
      jobsLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/getAgent',
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
    print("Get Recruiter::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;
      print("object");
      setState(() {
        jobsLoading = false;
      });
      getAllRecruiterData = GetAllRecruiterData.fromJson(jsonDecode(responseBody));
      recruiterList.addAll(getAllRecruiterData.data!);
    }
  }
}

