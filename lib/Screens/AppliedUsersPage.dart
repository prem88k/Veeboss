import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:veeboss/Models/Employee/MyJobs.dart';
import 'package:http/http.dart' as http;
import '../Contants/Colors.dart';
import '../Models/Agent/GetAllCompanyData.dart';
import '../Models/Agent/GetAllHiredUserData.dart';
import '../Models/Agent/GetApplicantUserData.dart';
import '../Models/Employee/AppliedJobs.dart';
import '../Models/Employer/CompanySelectedHiredList.dart';
import '../Models/Employer/CompanyUserHiredList.dart';
import '../Models/Employer/GetAssignAllCompany.dart';
import 'Employee/JobProcessScreen.dart';
import 'Employee/PdfViewr.dart';
import 'HiredUserTracker.dart';
import 'LoginScreen.dart';
import 'agent/AppliedUserProcessTracker.dart';
import 'package:share_plus/share_plus.dart';

class AppliedUsersPage extends StatefulWidget {
  int? id;
  jobList jobListData;

  AppliedUsersPage(this.id, this.jobListData);

  @override
  State<AppliedUsersPage> createState() => _AppliedUsersPageState();
}

class _AppliedUsersPageState extends State<AppliedUsersPage> {
  bool isLoading = false;
  bool _isStart = false;
  String currentpostlabel = "0:0:0";
  late GetApplicantUserData getApplicantUserData;
  List<AppliedUserList>? userList = [];

  late GetAllHiredUserData getAllHiredUserData;
  List<HiredUserList>? hiredUserList = [];

  late CompanySelectedHiredList companySelectedHiredList;
  List<CompanyHiredSList> companyList = [];

  late GetAllCompanyData getAllCompanyData;
  List<CompanyList> companyrList = [];
  String selectedCity = "";
  var dropdownCityValue;

  List<Jobs> jobListData = [];
  AudioPlayer myAudioPlayer = AudioPlayer();
  int currentpos = 0;
  int maxduration = 100;
  Duration position = new Duration();
  Duration duration = new Duration();
  String? callEnd;

  @override
  void initState() {
    getApplicantUserData = GetApplicantUserData();
    // TODO: implement initState
    getAllUSer();
    getAllShortListedUser();
    getAllHiredUser();
    getAllCompany();
    Future.delayed(Duration.zero, () async {
      myAudioPlayer.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxduration = d.inMilliseconds;
        setState(() {});
      });
      myAudioPlayer.onPlayerComplete.listen((event) {
        // resetPlayer();
      });
      myAudioPlayer.onPositionChanged.listen((Duration p) {
        currentpos =
            p.inMilliseconds; //get the current position of playing audio
        //generating the duration label
        int shours = Duration(milliseconds: currentpos).inHours;
        int sminutes = Duration(milliseconds: currentpos).inMinutes;
        int sseconds = Duration(milliseconds: currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      }, cancelOnError: true);
    });
    super.initState();
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    myAudioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: appBackground,
        appBar: AppBar(
          backgroundColor: appBackground,
          shape: Border(bottom: BorderSide(color: borderColors, width: 0.5)),
          elevation: 1,
          centerTitle: true,
          iconTheme: IconThemeData(color: appText),
          title: Text("Applied Users",
              style: TextStyle(fontFamily: "railway", color: appText)),
          actions: <Widget>[],
        ),
        body:isLoading
            ? Center(
            child: CircularProgressIndicator(
              backgroundColor: buttonTextColor,
            ))
            : Container(
                width: MediaQuery.of(context).size.width,
                height: size.height,
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: buttonTextColor,
                      ))
                    /*: userList!.length == 0
              ? Center(
              child: Container(
                //  margin: EdgeInsets.only(top: size.height * 0.4),
                  child: Text(
                    "Applied Users Not Found",
                    style: TextStyle(
                        fontFamily: 'railway',
                        color: appText,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  )))*/
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, bottom: 8.0, top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 5.0,
                                          left: 0.0,
                                        ),
                                        child: Text(
                                          widget.jobListData.post!,
                                          style: TextStyle(
                                              fontFamily: 'railway',
                                              fontSize: size.height * 0.022,
                                              fontWeight: FontWeight.bold,
                                              color: appButton),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.005,
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 5.0,
                                          left: 0.0,
                                        ),
                                        child: Text(
                                          "${userList!.length.toString()} candidates",
                                          style: TextStyle(
                                              fontFamily: 'railway',
                                              fontSize: size.height * 0.017,
                                              fontWeight: FontWeight.normal,
                                              color: appText),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    /*Container(
                            height: size.height * 0.050,
                            width: size.width * 0.1,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: primaryTextColor,
                                  width: 0.5,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cached_rounded,
                                      size: size.height * 0.03,
                                      color: primaryTextColor,
                                    ),
                                    */ /* SizedBox(width: size.width*0.012,),
                                                                    Text("Call",style: TextStyle(
                                                                        fontFamily: 'railway',
                                                                        fontSize: size.height * 0.015,
                                                                        fontWeight: FontWeight.normal,
                                                                        color: whiteTextColor),),*/ /*
                                  ],
                                ))),
                        SizedBox(
                          width: size.width * 0.020,
                        ),*/

                                    Container(
                                        height: size.height * 0.050,
                                        width: size.width * 0.1,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: appText,
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
                                            GestureDetector(
                                              onTap: () {
                                                _onShare(context);
                                              },
                                              child: Icon(
                                                Icons.share,
                                                size: size.height * 0.03,
                                                color: appText,
                                              ),
                                            ),
                                            /* SizedBox(width: size.width*0.012,),
                                                                Text("Call",style: TextStyle(
                                                                    fontFamily: 'railway',
                                                                    fontSize: size.height * 0.015,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: whiteTextColor),),*/
                                          ],
                                        )))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          DefaultTabController(
                              length: 3, // length of tabs
                              initialIndex: 0,
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: size.height * 0.010,
                                          right: size.height * 0.010),
                                      child: TabBar(
                                        labelColor: appText,
                                        unselectedLabelColor: primaryTextColor,
                                        labelStyle: TextStyle(
                                            fontSize: size.height * 0.015,
                                            fontFamily: 'railway'),
                                        //For Selected tab
                                        unselectedLabelStyle: TextStyle(
                                            fontSize: size.height * 0.015,
                                            fontFamily: 'railway'),
                                        //For Un-selected Tabs
                                        indicatorColor: appButton,
                                        tabs: [
                                          Container(
                                              alignment: Alignment.center,
                                              child: Tab(text: 'To Review')),
                                          Container(
                                              alignment: Alignment.center,
                                              child: Tab(text: 'ShortListed')),
                                          Container(
                                              alignment: Alignment.center,
                                              child: Tab(text: 'Hired')),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
                                    SingleChildScrollView(
                                      child: Container(
                                          height: size.height *
                                              0.7, //height of TabBarView
                                          child: TabBarView(children: <Widget>[

                                            //// All user List
                                            userList!.length == 0
                                                ? Center(
                                                    child: Container(
                                                        //  margin: EdgeInsets.only(top: size.height * 0.4),
                                                        child: Text(
                                                    "Applied Users Not Found",
                                                    style: TextStyle(
                                                        fontFamily: 'railway',
                                                        color: appText,
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )))
                                                : Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height:
                                                              size.height * 0.7,
                                                          child:
                                                              ListView.builder(
                                                            primary: false,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            shrinkWrap: false,
                                                            itemCount: userList!
                                                                .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Column(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: size.width *
                                                                            0.015,
                                                                        right: size.width *
                                                                            0.015,
                                                                        bottom: size.width *
                                                                            0.015),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              borderColors,
                                                                          width:
                                                                              0.5,
                                                                          style:
                                                                              BorderStyle.solid),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              padding: EdgeInsets.only(left: 12.0, top: 15.0, bottom: 0.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  userList![index].profileImage == null ? Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), image: DecorationImage(image: AssetImage("assets/images/profile.png"), fit: BoxFit.fill))) : Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), image: DecorationImage(image: NetworkImage(userList![index].profileImage.toString()), fit: BoxFit.fill))),
                                                                                  SizedBox(
                                                                                    width: size.width * 0.030,
                                                                                  ),
                                                                                  Container(
                                                                                    margin: EdgeInsets.only(top: size.height * 0.015),
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                                                                                  style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.022, fontWeight: FontWeight.bold, color: appHeader),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 0.0,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: size.height * 0.005,
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
                                                                                                  userList![index].location != null ? userList![index].location! : "-",
                                                                                                  style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
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
                                                                          height:
                                                                              size.height * 0.020,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              size.height * 0.015,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.6,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.school,
                                                                                      color: primaryTextColor,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: size.width * 0.025,
                                                                                    ),
                                                                                    Text(
                                                                                      userList![index].qualification == null ? "-" : userList![index].qualification!,
                                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.6,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.person,
                                                                                      color: primaryTextColor,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: size.width * 0.025,
                                                                                    ),
                                                                                    Text(
                                                                                      " ${userList![index].age} | ${userList![index].gender!} ",
                                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.6,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.chat,
                                                                                      color: primaryTextColor,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: size.width * 0.025,
                                                                                    ),
                                                                                    Text(
                                                                                      userList![index].bio!,
                                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.6,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.shopping_bag_outlined,
                                                                                      color: primaryTextColor,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: size.width * 0.025,
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          userList![index].experience == null ? "-" : userList![index].experience! + " | ",
                                                                                          style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                                                        ),
                                                                                        Text(
                                                                                          userList![index].expectedSalary == null ? "-" : userList![index].expectedSalary!,
                                                                                          style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.6,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.star_border,
                                                                                      color: primaryTextColor,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: size.width * 0.025,
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          userList![index].userDescription == null ? "-" : userList![index].userDescription!,
                                                                                          style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                                                        ),
                                                                                        /*Text(
                                                                        userList![index]
                                                                            .language !=
                                                                            null
                                                                            ? userList![index]
                                                                            .language!
                                                                            : "-",
                                                                        style: TextStyle(
                                                                            fontFamily: 'railway',
                                                                            fontSize: size
                                                                                .height *
                                                                                0.017,
                                                                            fontWeight: FontWeight
                                                                                .normal,
                                                                            color: appText),
                                                                      ),*/
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        userList![index].voiceNote! == null ?
                                                                        Container():
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            GestureDetector(
                                                                              child: Container(
                                                                                width: size.width * 0.8,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(left: 0.0, bottom: 8.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      GestureDetector(
                                                                                        onTap: () {
                                                                                          /* myAudioPlayer.play(
                                                                                      UrlSource(
                                                                                          userList![index].voiceNote!), mode: PlayerMode.mediaPlayer,
                                                                                      volume: 200,position: duration );*/
                                                                                        },
                                                                                        child: IconButton(
                                                                                          icon: Icon(_isStart ? Icons.stop_circle_outlined : Icons.play_circle_outline),
                                                                                          color: primaryTextColor,
                                                                                          onPressed: () {
                                                                                            _isStart = !_isStart;

                                                                                            myAudioPlayer.play(UrlSource(userList![index].voiceNote!), mode: PlayerMode.mediaPlayer, volume: 200, position: duration);
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: size.width * 0.0,
                                                                                      ),
                                                                                      Container(
                                                                                          child: Slider(
                                                                                        activeColor: appButton,
                                                                                        value: double.parse(currentpos.toString()),
                                                                                        min: 0,
                                                                                        max: double.parse(maxduration.toString()),
                                                                                        divisions: maxduration,
                                                                                        label: currentpostlabel,
                                                                                        onChanged: (double value) async {
                                                                                          int seekval = value.round();
                                                                                          int result = seekval; /*await audioPlayer.seek(Duration(milliseconds: seekval));*/
                                                                                          if (result == 1) {
                                                                                            seekToSecond(value.toInt());
                                                                                            value = value;
                                                                                          } else {
                                                                                            print("Seek unsuccessful.");
                                                                                          }
                                                                                        },
                                                                                      )),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 0.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 15.0,
                                                                              bottom: 15.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              userList![index].compayStatus != null
                                                                                  ? Text(
                                                                                      userList![index].compayStatus!,
                                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.018, fontWeight: FontWeight.bold, color: appHeader),
                                                                                    )
                                                                                  : Container(),
                                                                              SizedBox(
                                                                                width: size.width * 0.020,
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                      builder: (context) {
                                                                                        return PdfView(userList![index].resume!);
                                                                                      },
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                    height: size.height * 0.05,
                                                                                    width: size.width * 0.25,
                                                                                    decoration: BoxDecoration(
                                                                                      border: Border.all(color: primaryTextColor, width: 0.5, style: BorderStyle.solid),
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: Center(
                                                                                        child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                                                                          style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.015, fontWeight: FontWeight.normal, color: appText),
                                                                                        ),
                                                                                      ],
                                                                                    ))),
                                                                              ),
                                                                              SizedBox(
                                                                                width: size.width * 0.035,
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  _launchWhatsapp(userList![index].contactNo, userList![index]);
                                                                                },
                                                                                child: Container(
                                                                                    height: size.height * 0.05,
                                                                                    width: size.width * 0.3,
                                                                                    decoration: BoxDecoration(
                                                                                      border: Border.all(color: primaryTextColor, width: 0.5, style: BorderStyle.solid),
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: Center(
                                                                                        child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                                                                          style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.015, fontWeight: FontWeight.normal, color: appText),
                                                                                        ),
                                                                                      ],
                                                                                    ))),
                                                                              ),
                                                                              SizedBox(
                                                                                width: size.width * 0.035,
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  _showCallEndDialog(context, userList![index].id.toString(), widget.id.toString());
                                                                                  launch("tel://${userList![index].contactNo}");
                                                                                },
                                                                                child: Container(
                                                                                    height: size.height * 0.050,
                                                                                    width: size.width * 0.1,
                                                                                    decoration: BoxDecoration(
                                                                                      border: Border.all(color: primaryTextColor, width: 0.5, style: BorderStyle.solid),
                                                                                      borderRadius: BorderRadius.circular(50),
                                                                                    ),
                                                                                    child: Center(
                                                                                        child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.call,
                                                                                          size: size.height * 0.03,
                                                                                          color: appText,
                                                                                        ),
                                                                                      ],
                                                                                    ))),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        userList![index].compayStatus ==
                                                                                null
                                                                            ? Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  GestureDetector(
                                                                                      onTap: () {
                                                                                        ApplyUserStatus(userList![index].id, "selected");
                                                                                      },
                                                                                      child: Container(
                                                                                          margin: EdgeInsets.only(bottom: size.height * 0.01),
                                                                                          width: size.width * 0.2,
                                                                                          height: size.height * 0.045,
                                                                                          decoration: BoxDecoration(
                                                                                            color: appHeader,
                                                                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                                                                                            border: Border.all(width: 0.4, color: appButton, style: BorderStyle.solid),
                                                                                          ),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              "Accept",
                                                                                              style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.018, fontWeight: FontWeight.bold, color: appText),
                                                                                            ),
                                                                                          ))),
                                                                                  GestureDetector(
                                                                                      onTap: () {
                                                                                        ApplyUserStatus(userList![index].id, "rejected");
                                                                                      },
                                                                                      child: Container(
                                                                                          margin: EdgeInsets.only(bottom: size.height * 0.01),
                                                                                          width: size.width * 0.2,
                                                                                          height: size.height * 0.045,
                                                                                          decoration: BoxDecoration(
                                                                                            color: appHeader,
                                                                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                                                                                            border: Border.all(width: 0.4, color: appButton, style: BorderStyle.solid),
                                                                                          ),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              "Reject",
                                                                                              style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.018, fontWeight: FontWeight.bold, color: appText),
                                                                                            ),
                                                                                          )))
                                                                                ],
                                                                              )
                                                                            : Container(),
                                                                        SizedBox(
                                                                          height:
                                                                              size.height * 0.020,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: size
                                                                            .height *
                                                                        0.020,
                                                                  )
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                            //// Hired User List
                                            hiredUserList!.length == 0
                                                ? Center(
                                                    child: Container(
                                                        //  margin: EdgeInsets.only(top: size.height * 0.4),
                                                        child: Text(
                                                    "Shortlisted Users Not Found",
                                                    style: TextStyle(
                                                        fontFamily: 'railway',
                                                        color: appText,
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )))
                                                : Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height:
                                                              size.height * 0.7,
                                                          child:
                                                              ListView.builder(
                                                            primary: false,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            shrinkWrap: false,
                                                            itemCount:
                                                                hiredUserList!
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              //  status = "pending";

                                                              return Column(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: size.width *
                                                                            0.015,
                                                                        right: size.width *
                                                                            0.015,
                                                                        bottom: size.width *
                                                                            0.015),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              borderColors,
                                                                          width:
                                                                              0.5,
                                                                          style:
                                                                              BorderStyle.solid),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              padding: EdgeInsets.only(left: 12.0, top: 15.0, bottom: 0.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  hiredUserList![index].profileImage == null ?
                                                                                  Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080,
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: appText),
                                                                                          image: DecorationImage(image: AssetImage("assets/images/profile.png"), fit: BoxFit.fill))) :
                                                                                  Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080,
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: appText),
                                                                                          image: DecorationImage(image: NetworkImage(hiredUserList![index].profileImage.toString()), fit: BoxFit.fill))),
                                                                                  SizedBox(
                                                                                    width: size.width * 0.030,
                                                                                  ),
                                                                                  Container(
                                                                                    margin: EdgeInsets.only(top: size.height * 0.015),
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                                                                                  hiredUserList![index].name!,
                                                                                                  style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.022, fontWeight: FontWeight.bold, color: appHeader),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 0.0,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: size.height * 0.005,
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
                                                                                                  hiredUserList![index].location != null ? hiredUserList![index].location! : "-",
                                                                                                  style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
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

                                                                                  Column(
                                                                                    children: [
                                                                                      hiredUserList![index].hiring_status == "hired"
                                                                                          ? GestureDetector(
                                                                                          onTap: () {
                                                                                            Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                builder: (context) {
                                                                                                  return AppliedUserProcessTracker(hiredUserList![index].hiring_time.toString());
                                                                                                },
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                          child: Container(
                                                                                              margin: EdgeInsets.only(bottom: size.height * 0.01),
                                                                                              width: size.width * 0.2,
                                                                                              height: size.height * 0.045,
                                                                                              decoration: BoxDecoration(
                                                                                                color: appBackground,
                                                                                                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                                                                                                border: Border.all(width: 0.4, color: appButton, style: BorderStyle.solid),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Text(
                                                                                                  "Track",
                                                                                                  style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.018, fontWeight: FontWeight.bold, color: buttonTextColor),
                                                                                                ),
                                                                                              )))
                                                                                          : Container(),

                                                                                      SizedBox(
                                                                                        height: size.height * 0.015,
                                                                                      ),

                                                                                      GestureDetector(
                                                                                          onTap: () {
                                                                                            Navigator
                                                                                                .push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                builder:
                                                                                                    (context) {
                                                                                                  return HiredUserTracker(
                                                                                                      hiredUserList![index]);
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
                                                                                                  "User Track",
                                                                                                  style: TextStyle(
                                                                                                      fontFamily: 'railway',
                                                                                                      fontSize: size.height * 0.018,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      color: appHeader),
                                                                                                ),
                                                                                              )))
                                                                                    ],
                                                                                  )

                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              size.height * 0.010,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              size.height * 0.015,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.6,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.school,
                                                                                      color: primaryTextColor,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: size.width * 0.025,
                                                                                    ),
                                                                                    Text(
                                                                                      hiredUserList![index].qualification == null ? "-" : hiredUserList![index].qualification!,
                                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.6,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.person,
                                                                                      color: primaryTextColor,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: size.width * 0.025,
                                                                                    ),
                                                                                    Text(
                                                                                      " ${hiredUserList![index].age} | ${hiredUserList![index].gender!} ",
                                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.6,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.chat,
                                                                                      color: primaryTextColor,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: size.width * 0.025,
                                                                                    ),
                                                                                    Text(
                                                                                      hiredUserList![index].bio!,
                                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.6,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.shopping_bag_outlined,
                                                                                      color: primaryTextColor,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: size.width * 0.025,
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          hiredUserList![index].experience == null ? "-" : hiredUserList![index].experience! + " | ",
                                                                                          style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                                                        ),
                                                                                        Text(
                                                                                          hiredUserList![index].expectedSalary == null ? "-" : hiredUserList![index].expectedSalary!,
                                                                                          style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.6,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.star_border,
                                                                                      color: primaryTextColor,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: size.width * 0.025,
                                                                                    ),
                                                                                    Text(
                                                                                      hiredUserList![index].userDescription != null ? hiredUserList![index].userDescription! : "-",
                                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            GestureDetector(
                                                                              child: Container(
                                                                                width: size.width * 0.8,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(left: 0.0, bottom: 8.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      GestureDetector(
                                                                                        onTap: () {
                                                                                          /* myAudioPlayer.play(
                                                                                      UrlSource(
                                                                                          userList![index].voiceNote!), mode: PlayerMode.mediaPlayer,
                                                                                      volume: 200,position: duration );*/
                                                                                        },
                                                                                        child: IconButton(
                                                                                          icon: Icon(_isStart ? Icons.stop_circle_outlined : Icons.play_circle_outline),
                                                                                          color: primaryTextColor,
                                                                                          onPressed: () {
                                                                                            _isStart = !_isStart;

                                                                                            myAudioPlayer.play(UrlSource(hiredUserList![index].voiceNote!), mode: PlayerMode.mediaPlayer, volume: 200, position: duration);
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: size.width * 0.0,
                                                                                      ),
                                                                                      Container(
                                                                                          child: Slider(
                                                                                        activeColor: appButton,
                                                                                        value: double.parse(currentpos.toString()),
                                                                                        min: 0,
                                                                                        max: double.parse(maxduration.toString()),
                                                                                        divisions: maxduration,
                                                                                        label: currentpostlabel,
                                                                                        onChanged: (double value) async {
                                                                                          int seekval = value.round();
                                                                                          int result = seekval; /*await audioPlayer.seek(Duration(milliseconds: seekval));*/
                                                                                          if (result == 1) {
                                                                                            seekToSecond(value.toInt());
                                                                                            value = value;
                                                                                          } else {
                                                                                            print("Seek unsuccessful.");
                                                                                          }
                                                                                        },
                                                                                      )),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 0.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 15.0,
                                                                              bottom: 15.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              hiredUserList![index].compayStatus != null
                                                                                  ? Text(
                                                                                      hiredUserList![index].compayStatus!,
                                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.018, fontWeight: FontWeight.bold, color: appHeader),
                                                                                    )
                                                                                  : Container(),
                                                                              SizedBox(
                                                                                width: size.width * 0.010,
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                      builder: (context) {
                                                                                        return PdfView(hiredUserList![index].resume!);
                                                                                      },
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                    height: size.height * 0.05,
                                                                                    width: size.width * 0.25,
                                                                                    decoration: BoxDecoration(
                                                                                      border: Border.all(color: primaryTextColor, width: 0.5, style: BorderStyle.solid),
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: Center(
                                                                                        child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                                                                          style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.015, fontWeight: FontWeight.normal, color: appText),
                                                                                        ),
                                                                                      ],
                                                                                    ))),
                                                                              ),
                                                                              SizedBox(
                                                                                width: size.width * 0.035,
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  _launchWhatsapp(hiredUserList![index].contactNo, userList![index]);
                                                                                },
                                                                                child: Container(
                                                                                    height: size.height * 0.05,
                                                                                    width: size.width * 0.3,
                                                                                    decoration: BoxDecoration(
                                                                                      border: Border.all(color: primaryTextColor, width: 0.5, style: BorderStyle.solid),
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: Center(
                                                                                        child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                                                                          style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.015, fontWeight: FontWeight.normal, color: appText),
                                                                                        ),
                                                                                      ],
                                                                                    ))),
                                                                              ),
                                                                              SizedBox(
                                                                                width: size.width * 0.035,
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  _showCallEndDialog(context, hiredUserList![index].id.toString(), widget.id.toString());
                                                                                  launch("tel://${hiredUserList![index].contactNo}");
                                                                                },
                                                                                child: Container(
                                                                                    height: size.height * 0.050,
                                                                                    width: size.width * 0.1,
                                                                                    decoration: BoxDecoration(
                                                                                      border: Border.all(color: primaryTextColor, width: 0.5, style: BorderStyle.solid),
                                                                                      borderRadius: BorderRadius.circular(50),
                                                                                    ),
                                                                                    child: Center(
                                                                                        child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.call,
                                                                                          size: size.height * 0.03,
                                                                                          color: appText,
                                                                                        ),
                                                                                      ],
                                                                                    ))),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            GestureDetector(
                                                                                onTap: () {
                                                                                  _showSaveJobDialog(hiredUserList![index].id.toString(), context, setState);
                                                                                  //   ShareCompany(userList![index].id, "rejected");
                                                                                },
                                                                                child: Container(
                                                                                    margin: EdgeInsets.only(right: size.width * 0.050),
                                                                                    decoration: BoxDecoration(
                                                                                      color: appBackground,
                                                                                      borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                                                                                      border: Border.all(width: 0.4, color: appButton, style: BorderStyle.solid),
                                                                                    ),
                                                                                    child: Container(
                                                                                      margin: EdgeInsets.all(7.0),
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          "Share To Company",
                                                                                          style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.018, fontWeight: FontWeight.normal, color: appText),
                                                                                        ),
                                                                                      ),
                                                                                    )))
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              size.height * 0.010,
                                                                        ),
                                                                        hiredUserList![index].callFeedback == null ?
                                                                        Container() :
                                                                        Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                 "Call Feedback :- ",
                                                                                style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.022, fontWeight: FontWeight.normal, color: appHeader),
                                                                              ),
                                                                              Text(
                                                                                hiredUserList![index].callFeedback!,
                                                                                style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020, fontWeight: FontWeight.normal, color: appText),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: size
                                                                            .height *
                                                                        0.020,
                                                                  ),

                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                            companyList.length == 0 ?
                                            Center(
                                                child: Container(
                                                 //   margin: EdgeInsets.only(top: size.height * 0.4),
                                                    child: Text(
                                                      "Hired Users Not Found",
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
                                                      margin: EdgeInsets.only(left: size.width*0.015,right: size.width*0.015,bottom: size.width*0.015, top: size.height*0.0),
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

                                                                    companyList![index].hiringStatus == "hired"
                                                                        ? GestureDetector(
                                                                        onTap: () {
                                                                          Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) {
                                                                                return AppliedUserProcessTracker(companyList![index].hiring_time.toString());
                                                                              },
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: Container(
                                                                            margin: EdgeInsets.only(bottom: size.height * 0.01),
                                                                            width: size.width * 0.2,
                                                                            height: size.height * 0.045,
                                                                            decoration: BoxDecoration(
                                                                              color: appBackground,
                                                                              borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                                                                              border: Border.all(width: 0.4, color: appButton, style: BorderStyle.solid),
                                                                            ),
                                                                            child: Center(
                                                                              child: Text(
                                                                                "Track",
                                                                                style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.018, fontWeight: FontWeight.bold, color: buttonTextColor),
                                                                              ),
                                                                            )))
                                                                        : Container()
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

                                                          /*companyList[index].hiringStatus == null ?

                                                              :Container(
                                                            margin: EdgeInsets.only(left: 15.0),
                                                            alignment: Alignment.topLeft,
                                                            child: Text(companyList[index].hiringStatus == "hired" ? "You Are Hired." : companyList[index].hiringStatus == "rejected" ? "You Are Rejected." : "",
                                                              style: TextStyle(
                                                                  fontFamily: 'railway',
                                                                  fontSize: size.height * 0.017,
                                                                  fontWeight: FontWeight.normal,
                                                                  color: appText
                                                              ),),
                                                          ),*/

                                                          SizedBox(
                                                            height: 10.0,
                                                          ),

                                                          companyList[index].hiringStatus == null ?
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
                                                                      "Profile is under review.",
                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020,
                                                                          fontWeight: FontWeight.bold, color: appButton),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        :  companyList[index].hiringStatus == "hired" ?
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
                                                                      "Hired by, ",
                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020,
                                                                          fontWeight: FontWeight.bold, color: appButton),
                                                                    ),
                                                                    Text(
                                                                      "${companyList[index].companyName}",
                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020,
                                                                          fontWeight: FontWeight.normal, color: appText),
                                                                    ),
                                                                  ],
                                                                ),

                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 5.0),
                                                                  child: Text(
                                                                    "${companyList[index].companyEmail}",
                                                                    style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020,
                                                                        fontWeight: FontWeight.normal, color: appText),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                         : companyList[index].hiringStatus == "rejected" ?
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
                                                                      "Rejected by, ",
                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020,
                                                                          fontWeight: FontWeight.bold, color: appButton),
                                                                    ),
                                                                    Text(
                                                                      "${companyList[index].companyName}",
                                                                      style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020,
                                                                          fontWeight: FontWeight.normal, color: appText),
                                                                    ),
                                                                  ],
                                                                ),

                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 5.0),
                                                                  child: Text(
                                                                    "${companyList[index].companyEmail}",
                                                                    style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020,
                                                                        fontWeight: FontWeight.normal, color: appText),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                          :Container(),

                                                          SizedBox(
                                                            height: 10.0,
                                                          ),

                                                          Row(
                                                            children: [
                                                              Text(
                                                                companyList![index].callFeedback == null ? "-" : companyList![index].callFeedback!,
                                                                style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            //// Selected User List

                                          ])),
                                    )
                                  ])),
                        ],
                      ),
              ));
  }

  Future<void> _onShare(BuildContext context) async {
    // RenderBox? renderBox = context.findRenderObject() as RenderBox;
    await Share.shareWithResult(
        "${widget.jobListData.description!}, ${widget.jobListData.post!},"
        "${widget.jobListData.vacancy.toString()}, "
        "${widget.jobListData.file!.mainImageUrl.toString()}",
        subject: 'Welcome Message',
        sharePositionOrigin: Rect.fromLTWH(15, 50, 15, 50));
  }

  Future<void> ApplyUserStatus(
    int? id,
    String s,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    var url = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/applied-user-satus-update',
    );

    var request = new http.MultipartRequest("POST", url);
    print(widget.id.toString());
    request.headers['x-session-token'] = '${prefs.getString('sessionToken')}';
    request.fields['job_id'] = widget.id.toString();
    request.fields['user_id'] = id.toString();
    request.fields['satus'] = s.toString();

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
          getAllUSer();
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

  Future<void> getAllUSer() async {
    userList!.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/job/user/wise',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };
    Map<String, dynamic> body = {
      'job_id': widget.id.toString(),
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: body,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    var getdata = json.decode(response.body);

    print("applicantsData::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      if (getdata["success"]) {
        getApplicantUserData =
            GetApplicantUserData.fromJson(jsonDecode(responseBody));
        userList!.addAll(getApplicantUserData.data!);
      }
    }
  }

  Future<void> getAllShortListedUser() async {
    userList!.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/job/user/hired',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };
    Map<String, dynamic> body = {
      'job_id': widget.id.toString(),
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: body,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    var getdata = json.decode(response.body);

    print("Hired User Data::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      getAllUSer();
      if (getdata["success"]) {
        getAllHiredUserData =
            GetAllHiredUserData.fromJson(jsonDecode(responseBody));
        hiredUserList!.addAll(getAllHiredUserData.data!);
      }
    }
  }

  Future<void> getAllHiredUser() async {
    companyList!.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/job/companyhired',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };
    Map<String, dynamic> body = {
      'job_id': widget.id.toString(),
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: body,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    var getdata = json.decode(response.body);

    print("Company Hired User Data::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      getAllUSer();
      if (getdata["success"]) {
        companySelectedHiredList = CompanySelectedHiredList.fromJson(jsonDecode(responseBody));
        companyList.addAll(companySelectedHiredList.data!);
      }
    }
  }

  Future<void> postAssignUser(String id, String cID, String uID) async {
    userList!.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/assignuser',
    );

    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };

    Map<String, dynamic> body = {
      'user_id': uID,
      'job_id': id,
      'company_id': cID,
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: body,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    var getdata = json.decode(response.body);

    print("Hired User Data::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });

      Navigator.pop(context);
      if (getdata["success"]) {
        /* getAllHiredUserData =
            GetAllHiredUserData.fromJson(jsonDecode(responseBody));
        hiredUserList!.addAll(getAllHiredUserData.data!);*/
      }
    }
  }

  Future<void> getAllCompany() async {
    companyrList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/getallcompany',
    );

    Response response = await get(uri, headers: headers);

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("AllCompanyUser::   $responseBody");
    if (statusCode == 200) {
      setState(() {
        isLoading = false;
        getAllCompanyData =
            GetAllCompanyData.fromJson(jsonDecode(responseBody));
        companyrList.addAll(getAllCompanyData.data!);
      });
    }
  }

  Future<void> _launchWhatsapp(
      String? contactNo, AppliedUserList appliedUserList) async {
    var whatsapp = contactNo;
    var whatsappAndroid = Uri.parse(
        "whatsapp://send?phone=$whatsapp&text=Dear ${appliedUserList.name}\nI found your profile on Veeboss technology. i Have\na vacancy for :\n\n ${widget.jobListData.post}\nCompany- ${widget.jobListData.description}\nlocation- ${widget.jobListData.city} \n\n Please call me on * +91 7975915859* \n\n VEEBOSS TECHNOLOGY PVT LTD");
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

  _showSaveJobDialog(String id, BuildContext ctx, setState) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return SimpleDialog(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
              child: Text(
                "Select Company",
                style: TextStyle(
                    fontFamily: "railway",
                    fontWeight: FontWeight.w700,
                    color: appHeader,
                    letterSpacing: 0.5,
                    fontSize: 15.0),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 20.0, left: 15.0, right: 15.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: size.width * 0.025,
                        right: size.width * 0.05,
                      ),
                      margin: EdgeInsets.only(left: size.width * 0.002),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: primaryTextColor,
                          width: 1.0,
                        ),
                      ),
                      height: size.height * 0.075,
                      width: size.width * 0.6,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          iconSize: 30,
                          style: TextStyle(
                            color: appText,
                          ),
                          dropdownColor: appBackground,
                          isExpanded: true,
                          value: dropdownCityValue,
                          onChanged: (String? newValue) {
                            if (mounted) {
                              setState(() {
                                dropdownCityValue = newValue;
                                print("Company::$newValue");
                                selectedCity = newValue!;
                              });
                            }
                          },
                          hint: Row(
                            children: [
                              Text(
                                "Select Company",
                                style: TextStyle(
                                    color: appText,
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.018,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          icon: Icon(
                            // Add this
                            Icons.arrow_drop_down, // Add this
                            color: appText, // Add this
                          ),
                          items: companyrList.map((CompanyList value) {
                            return DropdownMenuItem<String>(
                              value: value.id.toString(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    value.name!,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        color: appText,
                                        fontSize: size.height * 0.018,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                              postAssignUser(widget.id.toString(), selectedCity,
                                  id.toString());
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
                                      "Send",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.width * 0.04,
                                          color: appBackground),
                                    ))),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
      context: ctx,
      barrierDismissible: true,
    );
  }

  Timer? _timer;

  Future<void> CallFeedBackApi(String id, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/addcallfeedback',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };
    Map<String, dynamic> body = {
      'job_id': userId,
      'user_id': id,
      'call_feedback':callEnd
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: body,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    var getdata = json.decode(response.body);

    print("Feedback Data::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;
      Message(context, getdata["message"]);
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          Navigator.pop(context);
          getAllUSer();
          // todo
          /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return App();
              },
            ),
          );*/
        });
      });
      setState(() {
        isLoading = false;
      });

      if (getdata["success"]) {
      }
    }
  }

  _showCallEndDialog(BuildContext ctx, String id, String user_id) {
    Size size = MediaQuery.of(context).size;
    _timer = Timer(Duration(seconds: 5), () {
      Navigator.of(ctx).push(DialogRoute(
        context: ctx,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SimpleDialog(
                children: <Widget>[
                  Container(
                    height: size.height * 0.45,
                    width: size.width * 0.55,
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
                          child: Text(
                            "How was the call ?",
                            style: TextStyle(
                                fontFamily: "railway",
                                fontWeight: FontWeight.w700,
                                color: appHeader,
                                letterSpacing: 0.5,
                                fontSize: 15.0),
                          ),
                        ),
                        Theme(
                          data: Theme.of(ctx).copyWith(
                              unselectedWidgetColor: appButton,
                              disabledColor: appText),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: RadioListTile(
                                  activeColor: appButton,
                                  title: Text("Invited for Interview",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.normal,
                                          color: appText)),
                                  value: "Invited for Interview",
                                  groupValue: callEnd,
                                  onChanged: (value) {
                                    setState(() {
                                      callEnd = value.toString();
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: RadioListTile(
                                  activeColor: appButton,
                                  title: Text("Call didnt Connect",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.normal,
                                          color: appText)),
                                  value: "Call didnt Connect",
                                  groupValue: callEnd,
                                  onChanged: (value) {
                                    setState(() {
                                      callEnd = value.toString();
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: RadioListTile(
                                  activeColor: appButton,
                                  title: Text("Candidate not Relevant",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.normal,
                                          color: appText)),
                                  value: "Candidate not Relevant",
                                  groupValue: callEnd,
                                  onChanged: (value) {
                                    setState(() {
                                      callEnd = value.toString();
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: RadioListTile(
                                  activeColor: appButton,
                                  title: Text("Other",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.normal,
                                          color: appText)),
                                  value: "Other",
                                  groupValue: callEnd,
                                  onChanged: (value) {
                                    setState(() {
                                      callEnd = value.toString();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.all(
                                                    size.width * 0.01),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                  "Cancel",
                                                  style: TextStyle(
                                                      fontFamily: 'railway',
                                                      fontSize:
                                                          size.width * 0.04,
                                                      color: appBackground),
                                                ))),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              CallFeedBackApi(id, user_id);
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.all(
                                                    size.width * 0.01),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: appButton,
                                                ),
                                                width: size.width * 0.25,
                                                height: size.height * 0.05,
                                                child: Center(
                                                    child: Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                      fontFamily: 'railway',
                                                      fontSize:
                                                          size.width * 0.04,
                                                      color: appBackground),
                                                ))),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ));
    });
  }

/* _showCallEndDialog(BuildContext ctx) {
    Size size = MediaQuery
        .of(context)
        .size;
    showDialog(
      builder: (context) {
        _timer = Timer(Duration(minutes: 1), () {
          Navigator.of(ctx).activate();
        });

        return SimpleDialog(
          children: <Widget>[
            Container(
              height: size.height * 0.45,
              width: size.width * 0.55,
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
                    child: Text(
                      "How was the call with ${getAllHiredUserData.data![0]
                          .name}",
                      style: TextStyle(
                          fontFamily: "railway",
                          fontWeight: FontWeight.w700,
                          color: appHeader,
                          letterSpacing: 0.5,
                          fontSize: 15.0),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                        unselectedWidgetColor: appButton,
                        disabledColor: appText
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: RadioListTile(
                            activeColor: appButton,
                            title: Text(
                                "Invited for Interview", style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.normal,
                                color: appText)),
                            value: "Invited for Interview",
                            groupValue: callEnd,
                            onChanged: (value) {
                              setState(() {
                                callEnd = value.toString();
                              });
                            },
                          ),
                        ),
                        Container(
                          child: RadioListTile(
                            activeColor: appButton,
                            title: Text("Call didnt Connect", style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.normal,
                                color: appText)),
                            value: "Call didnt Connect",
                            groupValue: callEnd,
                            onChanged: (value) {
                              setState(() {
                                callEnd = value.toString();
                              });
                            },
                          ),
                        ),
                        Container(
                          child: RadioListTile(
                            activeColor: appButton,
                            title: Text(
                                "Candidate not Relevant", style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.normal,
                                color: appText)),
                            value: "Candidate not Relevant",
                            groupValue: callEnd,
                            onChanged: (value) {
                              setState(() {
                                callEnd = value.toString();
                              });
                            },
                          ),
                        ),
                        Container(
                          child: RadioListTile(
                            activeColor: appButton,
                            title: Text("Other", style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.normal,
                                color: appText)),
                            value: "Other",
                            groupValue: callEnd,
                            onChanged: (value) {
                              setState(() {
                                callEnd = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

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
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(size.width * 0.01),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: appButton,
                                      */ /* boxShadow: [
                                              BoxShadow(
                                                  color: buttonTextColor,
                                                  spreadRadius: 1),
                                            ],*/ /*
                                    ),
                                    width: size.width * 0.25,
                                    height: size.height * 0.05,
                                    child: Center(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontFamily: 'railway',
                                              fontSize: size.width * 0.04,
                                              color: appBackground),
                                        ))),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(size.width * 0.01),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: appButton,
                                    ),
                                    width: size.width * 0.25,
                                    height: size.height * 0.05,
                                    child: Center(
                                        child: Text(
                                          "Submit",
                                          style: TextStyle(
                                              fontFamily: 'railway',
                                              fontSize: size.width * 0.04,
                                              color: appBackground),
                                        ))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        );
      }, context: ctx,

    ).then((val) {
      if (_timer!.isActive) {
        _timer!.cancel();
      }
    });
  }*/
}
