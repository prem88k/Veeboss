import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../Contants/Colors.dart';
import '../../Models/Agent/GetApplicantUserData.dart';
import '../../Models/Employee/MyJobs.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import '../Employee/PdfViewr.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorAllUserList extends StatefulWidget {
  const VendorAllUserList({Key? key}) : super(key: key);

  @override
  State<VendorAllUserList> createState() => _VendorAllUserListState();
}

class _VendorAllUserListState extends State<VendorAllUserList> {

  bool jobsLoading = false;
  late GetApplicantUserData getApplicantUserData;
  List<AppliedUserList>? userList = [];

  final TextEditingController _searchController = TextEditingController();

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
                child: userList!.length == 0 ?
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
                    :ListView.builder(
                  primary: false,
                  scrollDirection:
                  Axis.vertical,
                  shrinkWrap: true,
                  itemCount: userList!.length,
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
                                        userList![index].profileImage ==
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
                                                image: DecorationImage(image: NetworkImage(userList![index].profileImage.toString()), fit: BoxFit.fill))),
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
                                                        userList![index].name!,
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
                                                        userList![index].location!=null?userList![index].location!:"-",
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
                                            userList![index]
                                                .experience == null ?
                                            "-" :
                                            userList![index]
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
                                            userList![index]
                                                .gender == null ?
                                            "-":
                                            userList![index]
                                                .gender!,
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
                                            size.width * 0.7,
                                            child: Text(
                                              userList![index]
                                                  .bio == null ?
                                              "-" :
                                              userList![index]
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
                                            userList![index].age != null
                                                ? userList![index].age!.toString() + " Year"
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
                                    userList![index].compayStatus != null ?
                                    Text(
                                      userList![index].compayStatus!,
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height * 0.018,
                                          fontWeight: FontWeight.bold,
                                          color: appHeader),
                                    ):Container(),

                                    SizedBox(width: size.width * 0.015,),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator
                                            .push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) {
                                              return PdfView(userList![index].resume!);
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
                                    GestureDetector(
                                      onTap: () {
                                        _launchWhatsapp(
                                            userList![index]
                                                .contactNo,userList![index]);
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
                                    ),
                                    SizedBox(
                                      width: size
                                          .width *
                                          0.035,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch(
                                            "tel://${userList![index].contactNo}");
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
                                                  /* SizedBox(width: size.width*0.012,),
                                                                        Text("Call",style: TextStyle(
                                                                            fontFamily: 'railway',
                                                                            fontSize: size.height * 0.015,
                                                                            fontWeight: FontWeight.normal,
                                                                            color: whiteTextColor),),*/
                                                ],
                                              ))),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.020,)
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

  Future<void> _launchWhatsapp(String? contactNo, AppliedUserList appliedUserList) async {
    var whatsapp = contactNo;
    var whatsappAndroid =
    Uri.parse("whatsapp://send?phone=$whatsapp&text=Dear ${appliedUserList.name}\nI am recruiter person from veeboss technology. \n Your profile looks impressive for one of the job");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  Future<void> getPostData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("---${prefs.getString('sessionToken')}--");
    setState(() {
      jobsLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/allresume',
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
    print("getAllResumeData::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;
      print("object");
      setState(() {
        jobsLoading = false;
      });
      getApplicantUserData = GetApplicantUserData.fromJson(jsonDecode(responseBody));
      userList!.addAll(getApplicantUserData.data!);
    }
  }
}
