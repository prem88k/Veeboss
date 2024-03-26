import 'package:flutter/material.dart';
import 'package:veeboss/Models/Employer/CompanyUserHiredList.dart';
import '../../Contants/Colors.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import '../../Models/Agent/GetApplicantUserData.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../Employee/PdfViewr.dart';
import 'package:url_launcher/url_launcher.dart';
import '../LoginScreen.dart';

class EmployerUserList extends StatefulWidget {
  const EmployerUserList({Key? key}) : super(key: key);

  @override
  State<EmployerUserList> createState() => _EmployerUserListState();
}

class _EmployerUserListState extends State<EmployerUserList> {

  late CompanyUserHiredList companyUserHiredList;
  List<CompanyHiredList> companyList = [];
  bool isLoading = false;
  bool jobsLoading = false;
  
  @override
  void initState() {
    getPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: appBackground,
        resizeToAvoidBottomInset: false,
        body: jobsLoading?Center(child: CircularProgressIndicator(color: appText,)):SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: companyList.length == 0 ?
                Center(
                    child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.4),
                        child: Text(
                          "User Not Found",
                          style: TextStyle(
                              fontFamily: 'railway',
                              color: appText,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500),
                        )))
                    :
                ListView.builder(
                  primary: false,
                  scrollDirection:
                  Axis.vertical,
                  shrinkWrap: true,
                  itemCount: companyList.length,
                  itemBuilder:
                      (BuildContext context,
                      int index) {
                    //  status = "pending";
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: size.width*0.015,right: size.width*0.015,bottom: size.width*0.015, top: size.height*0.020),
                          decoration:
                          BoxDecoration(
                            border: Border.all(
                                color:
                                borderColors,
                                width:0.5,
                                style: BorderStyle
                                    .solid),
                            borderRadius:
                            BorderRadius
                                .circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left:
                                        12.0,
                                        top: 15.0,
                                        bottom:
                                        0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        companyList[index].profileImage ==
                                            null
                                            ? Container(
                                            alignment: Alignment.topCenter,
                                            height: size.height * 0.080,
                                            width: size.height * 0.080,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                                border:Border.all(color: appText),
                                                image: DecorationImage(image: AssetImage("assets/images/profile.png"), fit: BoxFit.fill)))
                                            : Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                                border:Border.all(color: appText),
                                                image: DecorationImage(image: NetworkImage(companyList[index].profileImage.toString()), fit: BoxFit.fill))),
                                        SizedBox(
                                          width: size.width *
                                              0.030,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top:
                                              size.height * 0.0),
                                          child:
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: size.width * 0.5,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                        right: 0.0,
                                                        left: 0.0,
                                                      ),
                                                      child: Text(
                                                        companyList[index].name!,
                                                        style: TextStyle(fontFamily: 'railway',
                                                            fontSize: size.height * 0.023, fontWeight: FontWeight.bold, color: appHeader),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 0.0,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.010,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: size.width * 0.5,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                        right: 0.0,
                                                        left: 0.0,
                                                      ),
                                                      child: Text(
                                                        companyList[index].location!=null?companyList[index].location!:"-",
                                                        style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017,
                                                            fontWeight: FontWeight.normal, color: appText),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 0.0,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.010,
                              ),
                              SizedBox(
                                height:
                                size.height *
                                    0.015,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                                children: [
                                  Container(
                                    width:
                                    size.width *
                                        0.85,
                                    child:
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                          12.0,
                                          right:
                                          12.0,
                                          bottom:
                                          8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .school,
                                            color:
                                            appText,
                                          ),
                                          SizedBox(
                                            width:
                                            size.width * 0.025,
                                          ),
                                          Text(
                                            companyList[index]
                                                .experience == null ?
                                            "-" :
                                            companyList[index]
                                                .experience!,
                                            style: TextStyle(
                                                fontFamily: 'railway',
                                                fontSize: size.height * 0.017,
                                                fontWeight: FontWeight.normal,
                                                color: appText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                                children: [
                                  Container(
                                    width:
                                    size.width *
                                        0.85,
                                    child:
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                          12.0,
                                          right:
                                          12.0,
                                          bottom:
                                          8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .person,
                                            color:
                                            appText,
                                          ),
                                          SizedBox(
                                            width:
                                            size.width * 0.025,
                                          ),

                                          Text(
                                            companyList[index].gender == null ?
                                            "-":
                                            companyList[index].gender!,
                                            style: TextStyle(
                                                fontFamily: 'railway',
                                                fontSize: size.height * 0.017,
                                                fontWeight: FontWeight.normal,
                                                color: appText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                                children: [
                                  Container(
                                    width:
                                    size.width *
                                        0.85,
                                    child:
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                          12.0,
                                          right:
                                          12.0,
                                          bottom:
                                          8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .chat,
                                            color:
                                            appText,
                                          ),
                                          SizedBox(
                                            width:
                                            size.width * 0.025,
                                          ),
                                          Container(
                                            width:
                                            size.width * 0.67,
                                            child: Text(
                                              companyList[index]
                                                  .bio == null ?
                                              "-" :
                                              companyList[index]
                                                  .bio!,
                                              style: TextStyle(
                                                  fontFamily: 'railway',
                                                  fontSize: size.height * 0.017,
                                                  fontWeight: FontWeight.normal,
                                                  color: appText),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                                children: [
                                  Container(
                                    width:
                                    size.width *
                                        0.85,
                                    child:
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                          12.0,
                                          right:
                                          12.0,
                                          bottom:
                                          8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.av_timer,
                                            color:
                                            appText,
                                          ),
                                          SizedBox(
                                            width:
                                            size.width * 0.025,
                                          ),
                                          Text(
                                            companyList[index].age != null
                                                ? companyList[index].age!.toString() + " Year"
                                                : "-",
                                            style: TextStyle(
                                                fontFamily: 'railway',
                                                fontSize: size.height * 0.017,
                                                fontWeight: FontWeight.normal,
                                                color: appText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),

                              Padding(
                                padding: EdgeInsets
                                    .only(
                                    left:
                                    15.0,
                                    bottom:
                                    15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: size.width * 0.015,),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator
                                            .push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) {
                                              return PdfView(companyList[index].resume!);
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                          height: size.height * 0.05,
                                          width: size.width * 0.25,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: primaryTextColor,
                                                width: 0.5,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.picture_as_pdf,
                                                    size: size.height * 0.03,
                                                    color: appText,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.012,
                                                  ),
                                                  Text(
                                                    "Resume",
                                                    style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.015,
                                                        fontWeight: FontWeight.normal, color: appText),
                                                  ),
                                                ],
                                              ))),
                                    ),
                                    SizedBox(
                                      width: size
                                          .width *
                                          0.035,
                                    ),
                                   /* GestureDetector(
                                      onTap: () {
                                      *//*  _launchWhatsapp(
                                            companyList![index]
                                                .contactNo,companyList![index]);*//*
                                      },
                                      child: Container(
                                          height: size.height * 0.05,
                                          width: size.width * 0.3,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: primaryTextColor,
                                                width: 0.5,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),

                                          child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                 MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/chat.png",
                                                    height: size.height * 0.03,
                                                    color: appText,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.012,
                                                  ),
                                                  Text(
                                                    "Whatsapp",
                                                    style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.015,
                                                        fontWeight: FontWeight.normal, color: appText),
                                                  ),
                                                ],
                                              ))),
                                    ),*/
                                   /* SizedBox(
                                      width: size
                                          .width *
                                          0.035,
                                    ),*/
                                  /*  GestureDetector(
                                      onTap: () {
                                        launch(
                                            "tel://${companyList![index].contactNo}");
                                      },
                                      child: Container(
                                          height: size.height * 0.050,
                                          width: size.width * 0.1,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: primaryTextColor,

                                                width: 0.5,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                            BorderRadius.circular(50),
                                          ),
                                          child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    size: size.height * 0.03,
                                                    color: appText,
                                                  ),
                                                  *//* SizedBox(width: size.width*0.012,),
                                                                        Text("Call",style: TextStyle(
                                                                            fontFamily: 'railway',
                                                                            fontSize: size.height * 0.015,
                                                                            fontWeight: FontWeight.normal,
                                                                            color: whiteTextColor),),*//*
                                                ],
                                              ))),
                                    ),*/
                                  ],
                                ),
                              ),

                              Divider(
                                color: appText,
                                thickness: 0.5,
                              ),

                              SizedBox(
                                height: 10.0,
                              ),

                              companyList[index].com_shortlist_status == null ?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ApplyUserStatus(companyList[index].id,companyList[index].jobId!, "accepted", "shortlist");
                                    },
                                    child: Container(
                                      height: size.height * 0.050,
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: appButton,
                                      ),
                                      child:
                                      Center(
                                        child: Text("Accepted",
                                          style: TextStyle(
                                              fontFamily: 'railway',
                                              fontSize: size.height * 0.017,
                                              fontWeight: FontWeight.normal,
                                          color: appBackground
                                        ),),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ApplyUserStatus(companyList[index].id,companyList[index].jobId!, "rejected", "shortlist");
                                    },
                                    child: Container(
                                      height: size.height * 0.050,
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: appButton,
                                      ),
                                      child:
                                      Center(
                                        child: Text("Rejected",
                                          style: TextStyle(
                                              fontFamily: 'railway',
                                              fontSize: size.height * 0.017,
                                              fontWeight: FontWeight.normal,
                                              color: appBackground
                                          ),),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                              : companyList[index].com_shortlist_status == "accepted" && companyList[index].hiringStatus == null ?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ApplyUserStatus(companyList[index].id,companyList[index].jobId!, "hired", "hired");
                                    },
                                    child: Container(
                                      height: size.height * 0.050,
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: appButton,
                                      ),
                                      child:
                                      Center(
                                        child: Text("Hired",
                                          style: TextStyle(
                                              fontFamily: 'railway',
                                              fontSize: size.height * 0.017,
                                              fontWeight: FontWeight.normal,
                                              color: appBackground
                                          ),),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ApplyUserStatus(companyList[index].id,companyList[index].jobId!, "rejected", "hired");
                                    },
                                    child: Container(
                                      height: size.height * 0.050,
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: appButton,
                                      ),
                                      child:
                                      Center(
                                        child: Text("Rejected",
                                          style: TextStyle(
                                              fontFamily: 'railway',
                                              fontSize: size.height * 0.017,
                                              fontWeight: FontWeight.normal,
                                              color: appBackground
                                          ),),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                              : Container() /*Container(
                                margin: EdgeInsets.only(left: 15.0),
                                alignment: Alignment.topLeft,
                                child: Text(companyList[index].hiringStatus == "hired" ? "You Are Hired." : companyList[index].hiringStatus == "rejected" ? "You Are Rejected." : "",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      fontSize: size.height * 0.017,
                                      fontWeight: FontWeight.normal,
                                      color: appText
                                  ),),
                              )*/,

                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              companyList[index].com_shortlist_status == null  && companyList[index].hiringStatus == null ?
                              Container() :
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(companyList[index].com_shortlist_status == "accepted"  && companyList[index].hiringStatus == null   ? "Profile was shortlisted" :
                                    companyList[index].com_shortlist_status == "rejected" && companyList[index].hiringStatus == null ? "Profile was Rejected." :  companyList[index].hiring_status == "hired" ? "This profile was successfully hired."
                                        : "This profile was rejected by interviewer.",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height * 0.017,
                                          fontWeight: FontWeight.normal,
                                          color: appText
                                      ),),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: EdgeInsets
                                  .only(
                                  top: 0.0,
                                  left:
                                  15.0,
                                    right:
                                    15.0,
                                  bottom:
                                  15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Assigned by, ",
                                          style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020,
                                              fontWeight: FontWeight.bold, color: appButton),
                                        ),
                                        Text(
                                          "${companyList[index].createName}",
                                          style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020,
                                              fontWeight: FontWeight.normal, color: appText),
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        "${companyList[index].createEmail}",
                                        style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020,
                                            fontWeight: FontWeight.normal, color: appText),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              /* Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.050,
                        vertical: size.height * 0.01),
                    child: Card(
                        child: ListTile(
                            title: Text("PDF Files"),
                            leading: Image(
                                image: AssetImage("assets/images/pdf.png"),
                                height: size.height * 0.035),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color: Color(0xff1AA5FF),
                            ),
                            onTap: () {
                              *//*Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ViewPDF();*//*
                              //open viewPDF page on click
                            })),
                  );*/
            ],
          ),
        )
    );
  }

  Future<void> ApplyUserStatus(int? id, int jobId,String s, String position) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    var url = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/applied-user-satus-update',
    );

    print(position);
    var request = new http.MultipartRequest("POST", url);

    request.headers['x-session-token'] = '${prefs.getString('sessionToken')}';

    if (position == "shortlist")
      {
        request.fields['com_shortlist_status'] = s.toString();
      }
    else {
      request.fields['final_status'] = s.toString();
    }
    request.fields['job_id'] = jobId.toString();
    request.fields['user_id'] = id.toString();

    request.send().then((response) {
      if (response.statusCode == 200) {
        print("Uploaded!");
        int statusCode = response.statusCode;
        print("response::$response");
        Message(context, "Applied User Status Edit Successfully");
        response.stream.transform(utf8.decoder).listen((value) {
          print("ResponseSellerVerification" + value);
          setState(() {
            //  _showDialog(context);
            isLoading = false;
          });
          getPostData();
          FocusScope.of(context).requestFocus(FocusNode());
        });
      } else {
        setState(() {
          if (!mounted) return;
          isLoading = false;
        });
        Message(context, " Something went Wrong");
      }
    });
  }



  Future<void> getPostData() async {
    companyList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("---${prefs.getString('sessionToken')}--");
    setState(() {
      jobsLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/getassigednuser',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("Company Hired List::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;
      print("object");
      setState(() {
        jobsLoading = false;
      });
      companyUserHiredList = CompanyUserHiredList.fromJson(jsonDecode(responseBody));
      companyList.addAll(companyUserHiredList.data!);
    }
  }
}

