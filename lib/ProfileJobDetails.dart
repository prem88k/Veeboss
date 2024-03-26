import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:veeboss/Models/Employee/MyJobs.dart';
import '../Contants/Colors.dart';
import 'Screens/Employee/VoiceNoteScreen.dart';
import 'Screens/Employer/homepage.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileJobDetails extends StatefulWidget {
  jobList jobListData;
  ProfileJobDetails(this.jobListData);

  @override
  State<ProfileJobDetails> createState() => _ProfileJobDetailsState();
}

class _ProfileJobDetailsState extends State<ProfileJobDetails> {
  bool isVisible = true;
  bool jobsLoading=false;
  List<jobList> jobListData= [];


  void showWidget(){

    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackground,
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
        title: Text("Job Details",
            style: TextStyle(fontFamily: "railway", color: appText)),
        actions: <Widget>[
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: size.height*0.025, bottom: size.height*0.1,left: size.width*0.050,right:  size.width*0.045),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
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
                          child: widget.jobListData.file == null ? Container(
                              alignment: Alignment.topCenter,
                              height: size.height * 0.080,
                              width: size.height * 0.080,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appText),
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      image: AssetImage ("assets/images/profile.png"),
                                      fit: BoxFit.fill
                                  )
                              )
                          ):  Container(
                              alignment: Alignment.topCenter,
                              height: size.height * 0.080,
                              width: size.height * 0.080,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appText),
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      image:  NetworkImage(widget.jobListData.file!.mainImageUrl.toString()),
                                      fit: BoxFit.cover
                                  )
                              )
                          )
                      ),
                      SizedBox(width: size.width * 0.030,),
                      SizedBox(
                        width: size.width * 0.030,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 0.67,
                            padding: EdgeInsets.all(0.020),
                            child: Text(
                              widget.jobListData.post!,
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.height * 0.025,
                                  fontWeight: FontWeight.bold,
                                  color: appButton),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.008,
                          ),
                          Container(
                            width: size.width * 0.67,
                            padding: EdgeInsets.all(0.020),
                            child: Text(
                              widget.jobListData.companyInfo == null ?
                              "-" : widget.jobListData.companyInfo! ,

                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.normal,
                                  color: appText),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.030,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Icon(Icons.location_on_outlined,
                                color: appText),
                          ),
                          SizedBox(
                            width: size.width * 0.030,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            /*  Text(
                                widget.jobListData.city == null ? "-" :  widget.jobListData.city! + " , ",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.020,
                                    fontWeight: FontWeight.normal,
                                    color: appText),
                              ),
*/
                              Text(
                                widget.jobListData.location == null ? "-" :  widget.jobListData.location!,
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
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Icon(Icons.work_history_outlined,
                                color: appText),
                          ),
                          SizedBox(
                            width: size.width * 0.030,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.jobListData.jobSTime == null ? "-" : widget.jobListData.jobSTime! + " , ",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.020,
                                    fontWeight: FontWeight.normal,
                                    color: appText),
                              ),
                              Text(
                                 widget.jobListData.jobETime == null ? "-" :  widget.jobListData.jobETime!,
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
                      SizedBox(
                        height: size.height * 0.010,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Icon(Icons.calendar_month_rounded,
                                color: appText),
                          ),
                          SizedBox(
                            width: size.width * 0.030,
                          ),

                          Row(
                            children: [
                              Text(
                               widget.jobListData.shiftTiming == null ?
                                "-" : widget.jobListData.shiftTiming! + " , ",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.020,
                                    fontWeight: FontWeight.normal,
                                    color: appText),
                              ),
                              Text(
                                widget.jobListData.shift == null ?
                                "-" : widget.jobListData.shift!,
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
                      SizedBox(
                        height: size.height * 0.010,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left:  5.0),
                            child: Text("₹", style: TextStyle( color: appText, fontSize: size.height * 0.030),
                               ),
                          ),
                          SizedBox(
                            width: size.width * 0.030,
                          ),

                          Text(
                            widget.jobListData.salary == null ?
                            "-" : "${widget.jobListData.salary!} - " ,
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.020,
                                fontWeight: FontWeight.normal,
                                color: appText),
                          ),
                          Text(
                            widget.jobListData.salaryEnd == null ?
                            "-" : "${widget.jobListData.salaryEnd!} per month" ,
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.020,
                                fontWeight: FontWeight.normal,
                                color: appText),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Icon(Icons.add_chart_sharp,
                                color: appText),
                          ),
                          SizedBox(
                            width: size.width * 0.030,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.jobListData.minExp == null ? " - ": widget.jobListData.minExp! +" to ",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.020,
                                    fontWeight: FontWeight.normal,
                                    color: appText),
                              ),
                              Text(
                                    widget.jobListData.maxExp == null ? "-" : widget.jobListData.maxExp!,
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
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Image(
                              image: AssetImage("assets/images/graduate.png",),
                              height: size.height * 0.050,
                              width: size.width * 0.060,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.030,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.jobListData.qualification == null ? " - ": _textSelect(widget.jobListData.qualification!),
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
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Icon(Icons.comment_bank_rounded,
                                    color: primaryTextColor),
                              ),
                              SizedBox(
                                width: size.width * 0.030,
                              ),
                              Container(
                                width: size.width * 0.45 ,
                                child: Text(
                                  "₹ 15,000 - ₹ 21,000 monthly ",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.normal,
                                      color: primaryTextColor),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(
                                    "Salary Details",
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.022,
                                        fontWeight: FontWeight.normal,
                                        color: buttonTextColor),)
                              ),
                              GestureDetector(
                                onTap: () {
                                  showWidget();
                                },
                                child: Container(
                                  child: Icon(Icons.keyboard_arrow_up_outlined,
                                      color: buttonTextColor),
                                ),
                              ),
                            ],
                          )
                        ],
                      )*/
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                 /* isVisible ?
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: isVisible,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                           width: size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Fixed",
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.020,
                                            color: primaryTextColor),
                                      ),
                                      Text(
                                        "₹ 15,000 - ₹ 20,000",
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.022,
                                            fontWeight: FontWeight.bold,
                                            color: primaryTextColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.005,
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: primaryTextColor,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Average Incentives *",
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.020,
                                            color: primaryTextColor),
                                      ),
                                      Text(
                                        "₹ 1000",
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.022,
                                            fontWeight: FontWeight.bold,
                                            color: primaryTextColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.005,
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: primaryTextColor,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Earning Potential",
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.020,
                                            fontWeight: FontWeight.bold,
                                            color: primaryTextColor),
                                      ),
                                      Text(
                                        "₹ 21,000",
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.022,
                                            fontWeight: FontWeight.bold,
                                            color: primaryTextColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.015,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Icon(Icons.info,
                                          color: primaryTextColor,
                                          size:size.height * 0.023,
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.015,
                                      ),
                                      Text(
                                        'You can earn more incentive if you perform well',
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.016,
                                            fontWeight: FontWeight.bold,
                                            color: primaryTextColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ): Container(),*/
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Job Description",
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: appHeader),
                          ),
                          /*SizedBox(
                            height: size.height * 0.015,
                          ),
                          Text(
                            "Roles and Responsibilities",
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.015,
                                color: appText),
                          ),*/
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          Container(
                            width: size.width * 0.9,
                            child: Text(widget.jobListData.description!,
                                style: TextStyle(
                                  fontFamily: 'railway',
                                  color: appText,
                                  fontSize: size.height * 0.018,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * 0.67,
                        padding: EdgeInsets.all(0.020),
                        child: Text(
                          "Job Skills :-" ,
                          style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                              color: appHeader),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.010,
                      ),
                      Container(
                        width: size.width * 0.9,
                        child: Text(
                          widget.jobListData.skills == null ?
                          "-" : widget.jobListData.skills!,
                          style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.normal,
                              color: appText),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * 0.67,
                        padding: EdgeInsets.all(0.020),
                        child: Text(
                          "Communication Language :-" ,
                          style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                              color: appHeader),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.010,
                      ),
                      Container(
                        width: size.width * 0.9,
                        child: Text(
                          widget.jobListData.communicationCategory == null ?
                          "-" : widget.jobListData.communicationCategory!,
                          style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.normal,
                              color: appText),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * 0.67,
                        padding: EdgeInsets.all(0.020),
                        child: Text(
                          "Job Benefits :-" ,
                          style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                              color: appHeader),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.010,
                      ),
                      Container(
                        width: size.width * 0.9,
                        padding: EdgeInsets.all(0.020),
                        child: Text(
                          widget.jobListData.jobbenefits == null ?
                          "-" :_textSelect(widget.jobListData.jobbenefits!) ,
                          style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.normal,
                              color: appText),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * 0.67,
                        padding: EdgeInsets.all(0.020),
                        child: Text(
                          "Required Language :-" ,
                          style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                              color: appHeader),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.010,
                      ),
                      Container(
                        width: size.width * 0.9,
                        padding: EdgeInsets.all(0.020),
                        child: Text(
                          widget.jobListData.language == null ?
                          "-" :_textSelect(widget.jobListData.language!) ,
                          style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.normal,
                              color: appText),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.040,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: appBackground,
                            border: Border.all(
                                width: 0.5,
                                color: appButton,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(widget.jobListData.workingDays == null ?
                                "-"
                                :widget.jobListData.workingDays!,
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.020,
                                    fontWeight: FontWeight.bold,
                                    color: appText),
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
                  /*Divider(
                    thickness: 0.8,
                    color: primaryTextColor,
                  ),*/
                /*  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Posted by",
                          style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.023,
                              fontWeight: FontWeight.normal,
                              color: primaryTextColor),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.020,
                      ),
                      Container(
                        child: Text(
                          "TechcodersItSolution Private...",
                          style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.023,
                              fontWeight: FontWeight.normal,
                              color: buttonTextColor),
                        ),
                      ),
                    ],
                  ),*/
                  /*SizedBox(
                    height: size.height * 0.010,
                  ),
                  Divider(
                    thickness: 0.8,
                    color: primaryTextColor,
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),*/

                  SizedBox(
                    height: size.height * 0.020,
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: size.height*0.035,),
          Padding(
            padding:  EdgeInsets.only(bottom: size.height*0.0,),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return VoiceNote(
                                widget.jobListData.id!
                                    .toInt());
                          },
                        ),
                      );
                    },

                    child: Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: appButton,
                          /*boxShadow: [
                            BoxShadow(
                                color: primaryTextColor,
                                spreadRadius: 0),
                          ],*/
                        ),
                        width: size.width,
                        height: size.height * 0.075,
                        child: Center(
                            child: Text(
                              "Apply",
                              style: TextStyle(
                                  fontFamily: 'sans',
                                  fontSize: size.width * 0.04,
                                  color: whiteTextColor),
                            ))),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      
    );
  }
  Future<void> ApplyJobs(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      jobsLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/job/apply',
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
          _showDialog(context);
        });
      });
    } else {
      setState(() {
        jobsLoading = false;
      });
    }
  }

  _showDialog(BuildContext ctx) {
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
                  "Job Placed Successfully",
                  style: TextStyle(
                      fontFamily: "railway",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      fontSize: 22.0),
                ),
              )),
          Center(
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
              )),
        ],
      ), context: ctx,
      barrierDismissible: true,
    );
  }
}

String _textSelect(String str) {
  str = str.replaceAll('[', '');
  str = str.replaceAll(']', '');
  return str;
}

