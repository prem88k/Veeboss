import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Models/Employee/MyJobs.dart';
import 'package:veeboss/Models/Vendor/GetAppCountData.dart';
import 'package:veeboss/Screens/agent/EditJobPost.dart';
import '../../Models/Employee/GetBannerData.dart';
import '../../Presentation/PagerState.dart';
import '../AppliedUsersPage.dart';
import '../Employer/JobHistory.dart';
import '../LoginScreen.dart';
import 'package:fl_chart/fl_chart.dart';

class RecruiterAppCount extends StatefulWidget {

  String id;
  RecruiterAppCount(this.id);

  @override
  State<RecruiterAppCount> createState() => _RecruiterAppCountState();
}

class _RecruiterAppCountState extends State<RecruiterAppCount> {

  bool isLoading = false;

  late GetAppCountData getAppCountData;
  List<CountList> countList = [];

  @override
  void initState() {
    AppCount();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBackground,
        shape: Border(bottom: BorderSide(color: borderColors, width: 0.1)),
        iconTheme: IconThemeData(color: appText),
        elevation: 0,
        shadowColor: primaryColor,
        centerTitle: true,
        title: Text(
          "Analytics",
          style: TextStyle(
              fontFamily: 'railway',
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.05,
              color: appText),
        ),
      ),
      backgroundColor: appBackground,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.035,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: size.width * 0.4,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              'All Jobs',
                              style: TextStyle(fontSize:size.width*0.035,fontWeight: FontWeight.bold, color: Colors.white,fontFamily:"railway" ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              getAppCountData.data![0].totalJobs.toString(),
                              style: TextStyle(fontSize:size.width*0.040, color: Colors.white,fontFamily:"railway" ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.4,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              'Hired User',
                              style: TextStyle(fontSize:size.width*0.035,fontWeight: FontWeight.bold, color: Colors.white,fontFamily:"railway" ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              getAppCountData.data![0].hired.toString(),
                              style: TextStyle(fontSize:size.width*0.040, color: Colors.white,fontFamily:"railway" ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: size.width * 0.4,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            'Rejected',
                            style: TextStyle(fontSize:size.width*0.035,fontWeight: FontWeight.bold, color: Colors.white,fontFamily:"railway" ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            getAppCountData.data![0].rejected.toString(),
                            style: TextStyle(fontSize:size.width*0.040, color: Colors.white,fontFamily:"railway" ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.4,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              'Rejected User',
                              style: TextStyle(fontSize:size.width*0.035, fontWeight: FontWeight.bold, color: Colors.white,fontFamily:"railway" ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              getAppCountData.data![0].rejected.toString(),
                              style: TextStyle(fontSize:size.width*0.040, color: Colors.white,fontFamily:"railway" ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: size.width * 0.4,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              'Applied',
                              style: TextStyle(fontSize:size.width*0.035, fontWeight: FontWeight.bold, color: Colors.white,fontFamily:"railway" ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              getAppCountData.data![0].applied.toString(),
                              style: TextStyle(fontSize:size.width*0.040, color: Colors.white,fontFamily:"railway" ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.020,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getAppCountData.data![0].totalJobs!.toDouble() != 0.0 ?
                  Container(
                    height: size.height * 0.45,
                    width: size.width * 0.5,
                    child: PieChart(PieChartData(
                      centerSpaceRadius: 15,
                      borderData: FlBorderData(show: false),
                      sections: [
                        PieChartSectionData(value: getAppCountData.data![0].totalJobs!.toDouble() , color: Colors.purple, radius: 100,),
                        PieChartSectionData(value: getAppCountData.data![0].applied!.toDouble(), color: Colors.amber, radius: 100,),
                        PieChartSectionData(value: getAppCountData.data![0].sortlisted!.toDouble(), color: Colors.green,radius: 100, ),
                        PieChartSectionData(value: getAppCountData.data![0].hired!.toDouble(), color: Colors.yellow,radius: 100, ),
                        PieChartSectionData(value: getAppCountData.data![0].rejected!.toDouble(), color: Colors.blue,radius: 100,),
                      ],
                    )),
                  )
                 : Container()
                ],
              ),

              getAppCountData.data![0].totalJobs!.toDouble() != 0.0 ?
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.020,
                          width: size.width * 0.035,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              shape: BoxShape.rectangle
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding:  EdgeInsets.only(left: 8.0),
                            child: Text(
                                "Total Jobs"
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.020,
                          width: size.width * 0.035,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.rectangle
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding:  EdgeInsets.only(left: 8.0),
                            child: Text(
                                "Applied"
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.020,
                          width: size.width * 0.035,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.rectangle
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding:  EdgeInsets.only(left: 8.0),
                            child: Text(
                                "Shortlisted"
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.020,
                          width: size.width * 0.035,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              shape: BoxShape.rectangle
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding:  EdgeInsets.only(left: 8.0),
                            child: Text(
                                "Hired"
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.020,
                          width: size.width * 0.035,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.rectangle
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding:  EdgeInsets.only(left: 8.0),
                            child: Text(
                                "Rejected"
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.020,
                            width: size.width * 0.035,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.rectangle
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding:  EdgeInsets.only(left: 8.0),
                              child: Text(
                                  "Contected"
                              ),
                            ),
                          ),
                        ],
                      ),*/
                  ],
                ),
              )
              : Container(),
              SizedBox(
                height: size.height * 0.035,
              ),
            ],
          ),
        ),
      ),

    );
  }
  Future<void> AppCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(widget.id);
    //print((int.parse(bidValueController.text)*100)/int.parse(contestPrice));
    setState(() {
      isLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/getcounts',
    );
    final headers = {'x-session-token': '${prefs.getString('sessionToken')}'};

    Map<String, dynamic> body = {
      'user_id': widget.id,
    };

    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    var getdata = json.decode(response.body);

    int statusCode = response.statusCode;
    String responseBody = response.body;

    print("App Count::$responseBody");
    if (statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      getAppCountData = GetAppCountData.fromJson(jsonDecode(responseBody));
      countList.addAll(getAppCountData.data!);
    } else {
      Message(context, getdata["message"]);
      setState(() {
        isLoading = false;
      });
    }
  }
}
