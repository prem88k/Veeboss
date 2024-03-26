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
import '../AllJobsDetails.dart';
import '../AppliedUsersPage.dart';
import '../Employer/JobHistory.dart';
import '../LoginScreen.dart';
import 'package:fl_chart/fl_chart.dart';

class AppAnalysesReport extends StatefulWidget {
  const AppAnalysesReport({Key? key}) : super(key: key);

  @override
  State<AppAnalysesReport> createState() => _AppAnalysesReportState();
}

class _AppAnalysesReportState extends State<AppAnalysesReport> {

  TextEditingController dateInput = TextEditingController();

  bool jobsLoading = false;

  bool isSelected = false;
  bool isClose = false;

  late GetAppCountData getAppCountData;
  List<CountList> countList = [];

  late GetAllMyJobPosts getAllMyJobPosts;
  List<jobList> jobListData = [];
  bool profileLoading = false;

  late GetBannerData getBannerData;
  List<BannerList> bannerList = [];

  bool isLoading = false;
  int index1 = 0;


  final bannerListPage = [
    'assets/images/trend1.jpg',
    'assets/images/trend2.jpg',
    'assets/images/trend3.png',
  ];
  final StreamController<PagerState> pagerStreamController =
  StreamController<PagerState>.broadcast();
  int selectedIndex = -1; // initial value, no container selected
  int _currentPage = 0;
  int _indexPage = 0;
  late Timer _timer, _timerOffer;

  late PageController controller1, controller2;

  String code = '';
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      code = (prefs.getString('userId')) ?? "";
      print(code);
    });
  }


  Map<String, double> dataMap = {
    "Total Jobs": 12.5,
    "Processing": 17.70,
    "Hired": 4.25,
    "Rejected": 3.51,
    "Pending": 2.83,
    "Contacted": 2.83,
  };

  // Colors for each segment
  // of the pie chart
  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];

  // List of gradients for the
  // background of the pie chart
  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];

  @override
  void initState() {
    _loadCounter();
    AppCount();
    getAppCountData = GetAppCountData();
    controller1 = PageController(initialPage: 0, viewportFraction: 1.1);
    controller2 = PageController(initialPage: 0, viewportFraction: 1.1);
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentPage < bannerList.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      controller1.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });

    _timerOffer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_indexPage < bannerListPage.length) {
        _indexPage++;
      } else {
        _indexPage = 0;
      }

      controller2.animateToPage(
        _indexPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    getBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: appBackground,
        body: isLoading
            ? Center(
            child: CircularProgressIndicator(
              backgroundColor: buttonTextColor,
            ))
            : SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                Container(
                    height: size.height * 0.2,
                    width: size.width,
                    child: PageView.builder(
                      itemCount: bannerList.length,
                      pageSnapping: false,
                      controller: controller1,
                      onPageChanged: (int value) {
                        controller1.addListener(() {
                          pagerStreamController
                              .add(PagerState(controller1.page!.toInt()));
                        });
                      },
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(),
                          child: Column(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(0.0),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 0),
                                  child: Container(
                                    width: size.height * 0.60,
                                    height: size.height * 0.18,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            bannerList[index].images!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ); // you forgot this
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width*0.015,
                      right: size.height * 0.025),
                  child: Row(
                    children: [
                      Text(
                        'Trendings & Offeres',
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.bold,
                            color: appText),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Container(
                    height: size.height * 0.070,
                    width: size.width,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bannerListPage.length,
                      pageSnapping: false,
                      controller: controller2,
                      onPageChanged: (int value) {
                        controller2.addListener(() {
                          pagerStreamController
                              .add(PagerState(controller2.page!.toInt()));
                        });
                      },
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(),
                          child: Column(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(0.0),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 0),
                                  child: Container(
                                    width: size.height * 0.60,
                                    height: size.height * 0.070,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            bannerListPage[index]),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ); // you forgot this
                      },
                    )),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width*0.015,
                      right: size.height * 0.025),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Welcome back Vendor!",
                      style: TextStyle(
                          fontFamily: 'railway',
                          fontSize: size.height * 0.022,
                          fontWeight: FontWeight.bold,
                          color: appText),
                    ),
                  ),
                ),

                SizedBox(
                  height: size.height * 0.025,
                ),

                SizedBox(
                  height: size.height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) {
                              return AllJobsDetails();
                            },
                          ),
                        );
                      },
                      child: Container(
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
                    Container(
                      height: size.height * 0.45,
                      width: size.width * 0.5,
                      child: PieChart(PieChartData(
                        centerSpaceRadius: 15,
                        borderData: FlBorderData(show: false),
                        sections: [
                          PieChartSectionData(value: getAppCountData.data![0].totalJobs!.toDouble(), color: Colors.purple, radius: 100,),
                          PieChartSectionData(value: getAppCountData.data![0].applied!.toDouble(), color: Colors.amber, radius: 100,),
                          PieChartSectionData(value: getAppCountData.data![0].sortlisted!.toDouble(), color: Colors.green,radius: 100, ),
                          PieChartSectionData(value: getAppCountData.data![0].hired!.toDouble(), color: Colors.yellow,radius: 100, ),
                          PieChartSectionData(value: getAppCountData.data![0].rejected!.toDouble(), color: Colors.blue,radius: 100,),
                        ],
                      )),
                    )
                  ],
                ),
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
                ),
                SizedBox(
                  height: size.height * 0.035,
                ),
              ],
            ),
          ),
        ));
  }
  Future<void> getBanner() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    final headers = {'x-session-token': prefs.getString('sessionToken')!};

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/banner',
    );
    final encoding = Encoding.getByName('utf-8');

    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("getBannerImages::$responseBody");
    if (statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      getBannerData = GetBannerData.fromJson(jsonDecode(responseBody));
      bannerList.addAll(getBannerData.data!);
    }
  }


  Future<void> AppCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(code);
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
      'user_id': code,
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

String convertToAgo(String dateTime) {
  DateTime input =
  intl.DateFormat('yyyy-MM-DDTHH:mm:ss.SSSSSSZ').parse(dateTime, true);
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
  } else {
    return 'just now';
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 250) {
      firstHalf = widget.text.substring(0, 250);
      secondHalf = widget.text.substring(250, widget.text.length);
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
          ? Container(
        width: size.width * 0.7,
        child: new Text(
          firstHalf,
          maxLines: 3,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: size.height * 0.017,
            fontFamily: 'railway',
            color: appText,
          ),
        ),
      )
          : Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              width: size.width * 0.7,
              child: Text(
                flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                style: TextStyle(
                    fontSize: size.height * 0.017, fontFamily: 'railway', color: appText),
              ),
            ),
            GestureDetector(
              child: Text(
                flag ? "Read More" : "Read Less",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: size.height * 0.015,
                    fontFamily: 'railway'),
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
    );
  }
}
