import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:veeboss/Models/Employer/GetSubscriptionPlan.dart';
import 'package:veeboss/Screens/Employer/BottomNavigationBar.dart';

import '../../Contants/Colors.dart';
import '../../Presentation/rounded_button.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployerSubscriptionPlan extends StatefulWidget {
  const EmployerSubscriptionPlan({Key? key}) : super(key: key);

  @override
  State<EmployerSubscriptionPlan> createState() =>
      _EmployerSubscriptionPlanState();
}

class _EmployerSubscriptionPlanState extends State<EmployerSubscriptionPlan> {
  bool isloading = false;
  bool jobsLoading = false;
  late GetSubscriptionPlan getSubscriptionPlan;
  List<SubscriptionPlanList> subscriptionPlanList = [];

  @override
  void initState() {
    getsubscriptionPlanList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: size.height,
            child: ListView.builder(
              itemCount: subscriptionPlanList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(size.width * 0.02),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: Image(
                          height: size.height * 0.40,
                          width: size.width,
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/employer_sub.png"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "Upgrade to Premium",
                          style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.032,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "Unlimited swipes, likes and so more!",
                          style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.bold,
                            color: primaryTextColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: size.height * 0.18,
                              width: size.width * 0.27,
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(color: Colors.black12)),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: Colors.black26),
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      "SAVE 66%",
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.020,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.010,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      subscriptionPlanList[0].months!.toString(),
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.035,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      "month",
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.025,
                                        fontWeight: FontWeight.bold,
                                        color: primaryTextColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      subscriptionPlanList[0].price!.toString(),
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.025,
                                        fontWeight: FontWeight.normal,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: size.height * 0.18,
                              width: size.width * 0.27,
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(color: Colors.black12)),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: Colors.black26),
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      "SAVE 33%",
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.020,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.010,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      "3",
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.035,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      "month",
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.025,
                                        fontWeight: FontWeight.bold,
                                        color: primaryTextColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      "\$9.00/mt",
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.025,
                                        fontWeight: FontWeight.normal,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: size.height * 0.18,
                              width: size.width * 0.27,
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(color: Colors.black12)),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: Colors.black26),
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      "SAVE 10%",
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.020,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.010,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.035,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      "month",
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.025,
                                        fontWeight: FontWeight.bold,
                                        color: primaryTextColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      "\$12.00/mt",
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.025,
                                        fontWeight: FontWeight.normal,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      !isloading
                          ? RoundedButton(
                              text: "Next",
                              press: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return bottomNavigationBarEmployer();
                                    },
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              backgroundColor: primaryColor,
                            )),
                      /* GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return bottomNavigationBarEmployer();
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.all(size.width * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: buttonTextColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: primaryTextColor,
                                      spreadRadius: 0),
                                ],
                              ),
                              width: size.width * 0.65,
                              height: size.height * 0.06,
                              child: Center(
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        fontFamily: 'sans',
                                        fontSize: size.width * 0.04,
                                        color: whiteTextColor),
                                  ))),
                        ],
                      ),
                    ),
                  ),*/
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            top: 15.0, left: 5.0, right: 5.0, bottom: 10.0),
                        child: Text(
                          "When will I be billed?",
                          style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.normal,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 3.0, left: 10.0, right: 10.0, bottom: 10.0),
                        child: Center(
                          child: Text(
                            "Your Itunes Account will be billed at the end of your trial"
                            "period(if applicable) or on confirmation of your subscription.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.020,
                              fontWeight: FontWeight.normal,
                              color: primaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            top: 15.0, left: 5.0, right: 5.0, bottom: 10.0),
                        child: Text(
                          "Does My subscription Auto Renew?",
                          style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.normal,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 3.0, left: 10.0, right: 10.0, bottom: 10.0),
                        child: Center(
                          child: Text(
                            "Yes, you can disable this at any time with just one tap in the app store.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.020,
                              fontWeight: FontWeight.normal,
                              color: primaryTextColor,
                            ),
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
    );
  }

  Future<void> getsubscriptionPlanList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      jobsLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/plans/get',
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
    print("getAllPlans::$responseBody");
    if (statusCode == 200) {
      setState(() {
        jobsLoading = false;
      });
      getSubscriptionPlan =
          GetSubscriptionPlan.fromJson(jsonDecode(responseBody));
      subscriptionPlanList.addAll(getSubscriptionPlan.data!);
    }
  }
}
