import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:veeboss/Screens/LoginScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Contants/Colors.dart';
import '../Presentation/PagerState.dart';
import '../Presentation/rounded_button.dart';
import 'WelcomeScreen.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  bool isloading = false;
  int currentPos = 0;
  bool elevationLoading = false;
  final StreamController<PagerState> pagerStreamController =
  StreamController<PagerState>.broadcast();
  late PageController controller1;
  var controller = PageController(keepPage: false, initialPage: 0);
  bool pressAttention = false;
  bool pressAttentionButton = false;

  @override
  void initState() {
    controller1 = PageController(keepPage: false, initialPage: 0);
    super.initState();
  }

  final titleList = [
    'Job listings',
    'Resume builder',
    'Application tracking'
  ];

  final imageList = [
    "assets/images/job7.png",
    "assets/images/job.png",
    "assets/images/job2.png"
  ];


  final descriptionList = [
    'Your app should have a comprehensive list of job openings that users can browse through. This list should be updated regularly and include information such as job title, location, salary, and job description.',
    'Many job seekers struggle with creating a strong resume. Your app could offer a resume builder tool that helps users create a professional-looking resume that highlights their skills and experience.',
    'Once users apply for a job through your app, they should be able to track the status of their application. This could include information such as whether their application has been received, whether its being reviewed, and whether they have been selected for an interview.',

  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: appBackground,
        body:  pager(size)
    );
  }
  Widget pager(Size size) {
    return PageView.builder(
      itemCount: 3,
      controller: controller,
      onPageChanged: (int value) {
        controller.addListener(() {
          pagerStreamController.add(PagerState(controller.page!.toInt()));
        });
      },
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return pagerBody(context, index, size); // you forgot this
      },
    );
  }
  Widget pagerBody(BuildContext context, int index1, Size size) {
    print("indecx::$index1");
    return SingleChildScrollView(
      child: Container(
        /* decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/chat.png"),
            fit: BoxFit.cover,
          ),
        ),*/
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
              SizedBox(
              height: size.height * 0.1,),
                  Container(
                    padding: EdgeInsets.only(right: size.width * 0.07),
                    alignment: Alignment.topRight,
                    child: SmoothPageIndicator(
                      controller: controller1,
                      count: 3,
                      effect: ExpandingDotsEffect(
                          expansionFactor: 4,
                          spacing: 8.0,
                          radius: 4.0,
                          dotWidth: 7.0,
                          dotHeight: 7.0,
                          activeDotColor: appButton),
                    ),
                  ),
                  SizedBox(
                    height: size.height *0.75,
                    child: PageView(
                      controller: controller1,
                      children: List.generate(
                          3, (index) => index == 2
                          ? Container(
                        margin: EdgeInsets.only(top: size.height * 0.02),
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.010,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.060,
                                      right: size.width * 0.060),
                                  child: Text(
                                    titleList[index],
                                    softWrap: true,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.035,
                                        fontWeight: FontWeight.bold,
                                        color: appHeader),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: size.width * 0.060,
                                  right: size.width * 0.060),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.7,
                                    child: Text(
                                      descriptionList[index],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height * 0.018,
                                          fontWeight: FontWeight.normal,
                                          color: appText),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.030,
                            ),
                            Container(
                              height: size.height * 0.45,
                              child: Image(
                                height: size.height * 0.40,
                                width: size.width * 0.6,
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    imageList[index]),
                              ),
                            ),
                          ],
                        ),
                      )
                          : Column(
                        children: [
                          SizedBox(height: size.height * 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.060,
                                    right: size.width * 0.060),
                                child: Text(
                                  titleList[index],
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      fontSize: size.height * 0.035,
                                      fontWeight: FontWeight.bold,
                                      color: appHeader),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: size.width * 0.060,
                                right: size.width * 0.060),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.7,
                                  child: Text(
                                    descriptionList[index],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.018,
                                        fontWeight: FontWeight.normal,
                                        color: appText),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.030,),
                          Container(
                            child: Image(
                              height: size.height * 0.45,
                              width: size.width * 0.6,
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  imageList[index]),
                            ),
                          ),
                        ],
                      )
                      ),
                    ),
                  ),
                  /*boardingList[index1].description ==
                      "Corporate Social Responsibility"
                      ? Container()
                      : */
                  !isloading
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SelectRole();
                                  },
                                ),
                              );
                              setState(() => pressAttentionButton = !pressAttentionButton);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.all(size.width * 0.01),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: appButton),
                                      color: pressAttentionButton ? appButton : appBackground,
                                      boxShadow: [
                                        BoxShadow(
                                            color: appButton,
                                            spreadRadius: 1),
                                      ],
                                    ),
                                    width: size.width * 0.35,
                                    height: size.height * 0.06,
                                    child: Center(
                                        child: Text(
                                          "Skip",
                                          style: TextStyle(
                                              fontFamily: 'railway',
                                              fontSize: size.width * 0.04,
                                              color: pressAttentionButton ? appBackground : appText),
                                        ))),
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              print(PagerState(controller1.page!.toInt())
                                  .currentPage);
                              // print("Length::${boardingList.length}");
                              print("Length::$index1");

                              if (PagerState(controller1.page!.toInt())
                                  .currentPage +
                                  1 ==
                                  3) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return LoginScreen("user");
                                    },
                                  ),
                                );
                              } else {
                                controller1.nextPage(
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.ease);
                              }
                                setState(() => pressAttention = !pressAttention);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.all(size.width * 0.01),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: appButton),
                                      borderRadius: BorderRadius.circular(10),
                                      color: pressAttention ? appButton : appBackground,
                                      boxShadow: [
                                        BoxShadow(
                                            color: appButton,
                                            spreadRadius: 1),
                                      ],
                                    ),
                                    width: size.width * 0.35,
                                    height: size.height * 0.06,
                                    child: Center(
                                        child: Text(
                                          "Continue",
                                          style: TextStyle(
                                              fontFamily: 'railway',
                                              fontSize: size.width * 0.04,
                                              color: pressAttention ? appBackground : appText),
                                        ))),
                              ],
                            ),
                          ),

                        ],
                      )
                      : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: primaryColor,
                      )),
                  /*GestureDetector(
                    onTap: () {
                      print(PagerState(controller1.page!.toInt())
                          .currentPage);
                      // print("Length::${boardingList.length}");
                      print("Length::$index1");

                      if (PagerState(controller1.page!.toInt())
                          .currentPage +
                          1 ==
                          3) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SelectRole();
                            },
                          ),
                        );
                      } else {
                        controller1.nextPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.ease);
                      }
                    },
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
                                      fontFamily: 'railway',
                                      fontSize: size.width * 0.04,
                                      color: whiteTextColor),
                                ))),
                      ],
                    ),
                  ),*/
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.030,
            ),
          ],
        ),
      ),
    );
  }
}
