import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Models/Employee/MyJobs.dart';
import 'package:veeboss/Screens/agent/EditJobPost.dart';



class MyJobs extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyJobs>  with TickerProviderStateMixin{

  bool jobsLoading=false;
  late GetAllMyJobPosts getAllMyJobPosts;
  List<jobList> jobListData= [];
  bool profileLoading = false;

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
          height:size.height,
          child: ListView.builder(
            primary: false,
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            itemCount:jobListData.length,
            itemBuilder: (BuildContext context, int index) {
              //  status = "pending";

              return Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0,left: 5.0,right: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            if (jobListData[index].isClosed==1) Container() else Container(
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
                                            jobListData[index].isClosed==1? Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
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
                                                        width: 90.0,
                                                        decoration:
                                                        new BoxDecoration(
                                                          color: Colors.red,
                                                          border: new Border.all(
                                                              color: Colors.white,
                                                              width: 2.0),
                                                          borderRadius:
                                                          new BorderRadius
                                                              .circular(10.0),
                                                        ),
                                                        child: new Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              new Text(
                                                                'Closed Job',
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
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 12.0,
                                                ),
                                              ],
                                            ):Container(),
                                            SizedBox(
                                              height: 12.0,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 12.0),
                                              child: Row(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      height: size.height * 0.090,
                                                      width: size.width * 0.15,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                              image:  AssetImage("assets/images/profile_photo.jpg",),
                                                              fit: BoxFit.fill
                                                          )
                                                      )
                                                  ),
                                                  SizedBox(width: size.width * 0.030,),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            jobListData[index].post!,
                                                            style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontSize: size.height * 0.020,
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
                                                                        jobListData[index].id!, jobListData[index]);
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
                                                                  color: Colors.black,
                                                                  size: 16,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Number of Vacancy :",
                                                            textAlign: TextAlign.left,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: primaryTextColor,
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
                                                              color: primaryTextColor,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Container(
                                              margin:
                                              EdgeInsets.only(left: 12.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Job Id :",
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
                                                    jobListData[index].id
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
                                              height: 5.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 12.0, right: 0.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  DescriptionTextWidget(text: jobListData[index].description.toString()),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                jobListData[index].file == null ? Container()
                                                    : Container(
                                                  height: size.height * 0.20,
                                                  width: size.width * 0.85,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          jobListData[index].file!.mainImageUrl.toString()),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
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
                                                    width: 120.0,
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
                                                          CloseJob(jobListData[index].id!);
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
                                                                Icons.cancel,
                                                                color: Colors
                                                                    .white,
                                                                size: 16,
                                                              ),
                                                            ),
                                                            new Text(
                                                              'Close Job',
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ),
    );
  }


  Future<void> getPostData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("---${prefs.getString('sessionToken')}--");
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

  Future<void> CloseJob(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profileLoading = true;
    });

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/job/close/${id.toString()}',
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
      profileLoading = false;
    }
  } }

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 40) {
      firstHalf = widget.text.substring(0, 40);
      secondHalf = widget.text.substring(40, widget.text.length);
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
          ? new Text(firstHalf)
          : new Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0),
            child: Row(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    width: size.width * 0.65,
                    child:  Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf) ,  style:  TextStyle(color: appText),)),

                InkWell(
                  child:  Container(
                    child: Text(
                      flag ? "Read More" : "Read Less",
                      style:  TextStyle(color: appButton),
                    ),
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
        ],
      ),
    );
  }
}

