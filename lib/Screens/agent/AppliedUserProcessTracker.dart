import 'dart:async';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import '../../Contants/Colors.dart';
import '../Employer/homepage.dart';


class AppliedUserProcessTracker extends StatefulWidget {

  String hiring_time;
  AppliedUserProcessTracker(this.hiring_time);

  @override
  State<AppliedUserProcessTracker> createState() => _AppliedUserProcessTrackerState();
}

class _AppliedUserProcessTrackerState extends State<AppliedUserProcessTracker> {

  Timer? countdownTimer;
  Duration myDuration = Duration(days: 90);

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(days: 1), (_) => setCountDown());
  }
  void setCountDown() {
    final reduceDayssBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceDayssBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  int current_step = 0;

  @override
  void initState() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    final days = strDigits(myDuration.inDays);
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
                width: 0.1
            )
        ),
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Payment Tracker",
          style: TextStyle(
              fontFamily: 'railway',
              fontWeight: FontWeight.normal,
              fontSize: size.width * 0.05,
              color: appText),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, left: 15.0, right: 15.0, bottom: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Your payment will credited in 90 days to your linked bank account. ",
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.020,
                            fontWeight: FontWeight.normal,
                            color: appText),
                      ),
                    ),
                  ),
                ],
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
                                    " Payment Tracker ",
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
                                        primary: buttonTextColor,
                                      ),
                                    ),
                                    child: Stepper(
                                      currentStep: current_step,
                                      type: StepperType.vertical,
                                      onStepTapped: (step) {
                                        setState(() {

                                        });
                                      },
                                      steps: <Step>[
                                        Step(
                                            title: Container(
                                              width: size.width * 0.8,
                                              child: Row(
                                                children: const [
                                                      Text(
                                                    "Your candidate is selected. ",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontFamily: 'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: buttonTextColor),
                                                  ),
                                                 /*Text(
                                                    " - , ",
                                                    style: TextStyle(
                                                        fontFamily: 'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: buttonTextColor),
                                                      )*/
                                                ],
                                              ),
                                            ),
                                            content: Container(
                                              child: Text(
                                                  "We will notify you, once payment will be credited in your bank.",
                                                  style: TextStyle(
                                                      fontFamily: 'railway',
                                                      fontSize: 11,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      color: buttonTextColor)),
                                            ),
                                            isActive: true /*widget.jobListData.status
                                                .toString() ==
                                                "applied"
                                                ? true
                                                : false*/),
                                        Step(
                                            title: Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                   Text(
                                                    "Expected payment date, ",
                                                    style: TextStyle(
                                                        fontFamily: 'railway',
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: buttonTextColor),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.005,
                                                  ),
                                                  Text(
                                                    " Days left : ${convertToAgo(
                                                        widget.hiring_time
                                                    )} Days",
                                                    style: TextStyle(
                                                        fontSize:
                                                        size.height * 0.015,
                                                        fontFamily:
                                                        'railway',
                                                        color: appText
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            content: Text(
                                                "Your application has been reviewed, please check your message and email for "
                                                    "discussing about job opportunity.",
                                                style: TextStyle(
                                                    fontFamily: 'railway',
                                                    fontSize: 11,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    color: buttonTextColor)),
                                            isActive: false /*widget.jobListData.status
                                                .toString() ==
                                                "applied"
                                                ? true
                                                : false*/),
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

String convertToAgo(String dateTime) {
  DateTime input =
  intl.DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime, true);
  Duration diff = DateTime.now().difference(input);

  print(diff.inDays);

  if (diff.inDays >= 1) {
    return (90 - diff.inDays).toString();
 //   return '${diff.inDays} day${diff.inDays == 1 ? '' : ''} ago';
  } /*else if (diff.inHours >= 1) {
    return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
  } */else {
    return (90 - diff.inDays).toString();
  }
}