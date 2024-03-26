import 'package:flutter/material.dart';
import 'package:veeboss/Models/Agent/GetAllHiredUserData.dart';

import '../Contants/Colors.dart';

class HiredUserTracker extends StatefulWidget {
  HiredUserList jobListData;

  HiredUserTracker(this.jobListData);

  @override
  State<HiredUserTracker> createState() => _HiredUserTrackerState();
}

class _HiredUserTrackerState extends State<HiredUserTracker> {
  int current_step = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBackground,
        shape: Border(bottom: BorderSide(color: borderColors, width: 0.1)),
        iconTheme: IconThemeData(color: appText),
        elevation: 1,
        shadowColor: primaryColor,
        centerTitle: true,
        title: Text(
          "Job Process",
          style: TextStyle(
              fontFamily: 'railway',
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.05,
              color: appText),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 35.0, left: 15.0, right: 15.0, bottom: 15.0),
              child: Center(
                child: widget.jobListData.profileImage == null ? Container(
                    alignment: Alignment.topCenter,
                    height: size.height * 0.12,
                    width: size.height * 0.12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image:
                            AssetImage("assets/images/profile_photo.jpg"),
                            fit: BoxFit.fill)))
                   : Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: appText),
                        image: DecorationImage(image: NetworkImage(widget.jobListData.profileImage.toString()), fit: BoxFit.fill))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 5.0, left: 15.0, right: 15.0, bottom: 10.0),
              child: Center(
                child: Container(
                  child: Text(
                    widget.jobListData.name!,
                    style: TextStyle(
                        fontFamily: 'railway',
                        fontSize: size.height * 0.025,
                        fontWeight: FontWeight.bold,
                        color: appHeader),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 0.0, left: 15.0, right: 15.0, bottom: 15.0),
              child: Center(
                child: Container(
                  child: Text(
                    widget.jobListData.userDescription.toString(),
                    style: TextStyle(
                        fontFamily: 'railway',
                        fontSize: size.height * 0.020,
                        fontWeight: FontWeight.normal,
                        color: appText),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: 10.0, left: 15.0, right: 15.0, bottom: 15.0),
                child: Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: bookingCardColor)),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 0.0, right: 5.0, bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Container(
                                  child: Text(
                                    " Process ",
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.023,
                                        fontWeight: FontWeight.bold,
                                        color: appHeader),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, left: 0.0, right: 0.0, bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.88,
                                  child: Theme(
                                    data: ThemeData(
                                      colorScheme: Theme.of(context)
                                          .colorScheme
                                          .copyWith(
                                        primary: primaryColor,
                                      ),
                                    ),
                                    child: Stepper(
                                      currentStep: current_step,
                                      type: StepperType.vertical,
                                      onStepTapped: (step) {
                                        setState(() {
                                          /* if (current_step < step - 1) {
                                            current_step = current_step + 1;
                                          } else {
                                            current_step = 0;
                                          }*/
                                        });
                                      },
                                      steps: <Step>[

                                        Step(
                                            title: Container(
                                              width: size.width * 0.8,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Applied job successfully.",
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color:
                                                        buttonTextColor),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.005,
                                                  ),
                                                  Text(
                                                    widget.jobListData.appliedTime.toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color:
                                                        primaryTextColor),
                                                  )
                                                ],
                                              ),
                                            ),
                                            content: Container()),

                                        Step(
                                            title:  widget.jobListData
                                                .compayStatus == null ?
                                            Container(
                                              child: Text("-"),
                                            ) : Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  /*widget.jobListData
                                                      .compayStatus ==
                                                      null ?
                                                  Text(
                                                    "Your Profile Is Under Review",
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: buttonTextColor),
                                                  )
                                                      :*/
                                                  widget.jobListData
                                                      .compayStatus ==
                                                      "selected" ?
                                                  Text(
                                                    "Your Profile Shortlisted by HR",
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: buttonTextColor),
                                                  )
                                                      :
                                                  widget.jobListData
                                                      .compayStatus ==
                                                      "rejected"
                                                      ? Text(
                                                    "Your Profile Rejected by HR",
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color:
                                                        buttonTextColor),
                                                  ) : Text(""),
                                                  SizedBox(
                                                    height: size.height * 0.005,
                                                  ),
                                                  Text(
                                                    widget.jobListData.hrTime == null ?
                                                    "" :
                                                    widget.jobListData.hrTime.toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color:
                                                        primaryTextColor),
                                                  )
                                                ],
                                              ),
                                            ),
                                            content: Container()),

                                        Step(
                                          title:  widget.jobListData
                                              .compayStatus == "rejected" ?
                                          Container(
                                            child: Text("-"),
                                          ) :   widget.jobListData
                                              .comShortlistStatus ==
                                              null ?  Container(
                                            child: Text("-"),
                                          ) :  Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                              /*  widget.jobListData
                                                    .comShortlistStatus ==
                                                    null ?
                                                Text(
                                                  "Your Profile Is Under Review",
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'railway',
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color: buttonTextColor),
                                                )
                                                    :*/
                                                widget.jobListData
                                                    .comShortlistStatus ==
                                                    "accepted" ?
                                                Text(
                                                  "Your profile shortlisted by company and your interview schedule by company ",
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'railway',
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color: buttonTextColor),
                                                )
                                                    :
                                                widget.jobListData.comShortlistStatus==
                                                    "rejected"
                                                    ? Text(
                                                  "Your profile rejected by company.",
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'railway',
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color:
                                                      buttonTextColor),
                                                ) : Text(""),

                                                SizedBox(
                                                  height: size.height * 0.005,
                                                ),
                                                Text(
                                                  widget.jobListData.companyShortlistTime == null ?
                                                  "" :
                                                  widget.jobListData.companyShortlistTime.toString(),
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'railway',
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color:
                                                      primaryTextColor),
                                                )
                                              ],
                                            ),
                                          ),
                                          content: Container(),),

                                        Step(
                                            title:  widget.jobListData
                                                .comShortlistStatus == "rejected" ?
                                            Container(
                                              child: Text("-"),) :
                                            widget.jobListData
                                                .hiring_status ==
                                                null ?  Container(
                                              child: Text("-"),
                                            ) :
                                            Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                 /* widget.jobListData
                                                      .hiring_status ==
                                                      null ?
                                                  Text(
                                                    "Your Profile Is Under Review",
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: buttonTextColor),
                                                  )
                                                      :*/
                                                  widget.jobListData
                                                      .hiring_status ==
                                                      "hired" ?
                                                  Text(
                                                    "Your profile sucessfully hired by company.",
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: buttonTextColor),
                                                  )
                                                      :
                                                  widget.jobListData.hiring_status==
                                                      "rejected"
                                                      ? Text(
                                                    "Your profile rejected by company.",
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color:
                                                        buttonTextColor),
                                                  ) : Text(""),

                                                  SizedBox(
                                                    height: size.height * 0.005,
                                                  ),
                                                  Text(
                                                    widget.jobListData.hiring_time == null ?
                                                    "" :
                                                    widget.jobListData.hiring_time.toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color:
                                                        primaryTextColor),
                                                  )
                                                ],
                                              ),
                                            ),
                                            content: Container()),

                                      ],
                                      controlsBuilder: (context, controller) {
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
