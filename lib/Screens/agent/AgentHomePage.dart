import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Models/Agent/AgentUsers.dart';
import 'package:veeboss/Screens/agent/AgentCompanyScreen.dart';
import 'package:veeboss/Screens/agent/AgentUserScreen.dart';
import '../../Models/Agent/AgentCompany.dart';


class AgentHomePageNew extends StatefulWidget {
  @override
  _AgentHomePageNewState createState() => _AgentHomePageNewState();
}

class _AgentHomePageNewState extends State<AgentHomePageNew>
    with TickerProviderStateMixin {

  late AgentUsers agentUsers;
  List<AgentUserList> agentUserList = [];

  late AgentCompany agentCompany;
  List<AgentCompanyList> agentCompanyList = [];

  late SharedPreferences prefs;
  bool idLoading = false;


  @override
  void initState() {
    getAgentReferelUsers();
    getAgentReferelCompany();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
        body:   SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Text('Tabs Inside Body', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                        DefaultTabController(
                            length: 2, // length of tabs
                            initialIndex: 0,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: size.height * 0.010, right: size.height * 0.010),
                                    child: TabBar(
                                      labelColor: buttonTextColor,
                                      unselectedLabelColor: Colors.black,
                                      indicatorColor: buttonTextColor,
                                      tabs: [
                                        Container(
                                            alignment: Alignment.center,
                                            child: Tab(text: ' User ')),
                                        Container(
                                            child: Tab(text: ' Company ')),

                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height:  size.height * 0.015,
                                  ),
                                  SingleChildScrollView(
                                   scrollDirection: Axis.vertical,
                                    child: Container(
                                        height:   MediaQuery.of(context).size.height, //height of TabBarView
                                        child:  TabBarView(children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: size.width * 0.05,
                                              left: size.width * 0.01,
                                              right: size.width * 0.01,),
                                            child:agentUserList.length == 0 ?
                                            Center(
                                                child: Container(
                                                //    margin: EdgeInsets.only(top: size.height * 0.4),
                                                    child: Text(
                                                      " User Not Found",
                                                      style: TextStyle(
                                                          fontFamily: 'railway',
                                                          color: Colors.black,
                                                          fontSize: 15.0,
                                                          fontWeight: FontWeight.w500),
                                                    )))
                                                : ListView.builder(
                                                itemCount: agentUserList.length,
                                                shrinkWrap: true,
                                              //  physics: NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.all(size.width * 0.02),
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Container(
                                                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                                                        Container(
                                                          margin: EdgeInsets.all(10.0),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius.circular(20.0),
                                                                topLeft: Radius.circular(20.0),
                                                                bottomRight: Radius.circular(20.0),
                                                                bottomLeft: Radius.circular(20.0)),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: buttonTextColor,
                                                                style: BorderStyle.solid),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(8.0),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                        width: size.width*0.25,
                                                                        child: Text("Name :",
                                                                          style: TextStyle(
                                                                              fontFamily: 'railway'),)),
                                                                    SizedBox(
                                                                      width: 10.0,
                                                                    ),
                                                                    Container(
                                                                      width: size.width*0.55,
                                                                      child: Text(
                                                                        agentUserList[index].name!,
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 16,
                                                                            fontFamily: 'railway'
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 15.0,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                      width: size.width*0.25,
                                                                      child: Text(
                                                                        "Email :",
                                                                        style: TextStyle(
                                                                            fontFamily: 'railway'),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10.0,
                                                                    ),
                                                                    Container(
                                                                      width: size.width*0.55,
                                                                      child: Text(
                                                                        agentUserList[index].email!,
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'railway',
                                                                          fontSize: 16,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 15.0,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                      width: size.width*0.25,
                                                                      child: Text(
                                                                        "Contact no :",
                                                                        style: TextStyle(
                                                                            fontFamily: 'railway'),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10.0,
                                                                    ),
                                                                    Container(
                                                                      width: size.width*0.55,
                                                                      child: Text(
                                                                        agentUserList[index].contactNo!,
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 16,
                                                                            fontFamily: 'railway'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 15.0,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                      width: size.width*0.25,

                                                                      child: Text(
                                                                        "Status :",
                                                                        style: TextStyle(
                                                                            fontFamily: 'railway'),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10.0,
                                                                    ),
                                                                    Container(
                                                                      width: size.width*0.55,

                                                                      child: Text(
                                                                        "Active",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 16,
                                                                            fontFamily: 'railway',
                                                                            color: Colors.green),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 15.0,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap: (){
                                                                         Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) {
                                                                              return UserPage(agentUserList[index]);
                                                                            },
                                                                          ),
                                                                        );
                                                                      },
                                                                      child: Container(
                                                                        width: size.width*0.2,
                                                                        height: size.height*0.04,
                                                                        margin: EdgeInsets.only(right: size.width*0.015),
                                                                        decoration: BoxDecoration(
                                                                          color: buttonTextColor,
                                                                          borderRadius: BorderRadius.circular(10.0),
                                                                          border: Border.all(
                                                                            width: 1.0,
                                                                          ),
                                                                        ),
                                                                        child: Center(
                                                                          child: Text("View More",style: TextStyle(
                                                                              fontFamily: 'railway',
                                                                              color: whiteTextColor,
                                                                              fontSize:
                                                                              size.height * 0.015,
                                                                              fontWeight:
                                                                              FontWeight.normal),),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: size.height * 0.010,),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ]));
                                                }),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: size.width * 0.05,
                                              left: size.width * 0.01,
                                              right: size.width * 0.01,),
                                            child: agentCompanyList.length == 0 ?
                                            Center(
                                                child: Container(
                                                  //  margin: EdgeInsets.only(top: size.height * 0.4),
                                                    child: Text(
                                                      " User Not Found",
                                                      style: TextStyle(
                                                          fontFamily: 'railway',
                                                          color: Colors.black,
                                                          fontSize: 15.0,
                                                          fontWeight: FontWeight.w500),
                                                    )))
                                                :ListView.builder(
                                                itemCount: agentCompanyList.length,
                                               // shrinkWrap: true,
                                              //  physics: NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.all(size.width * 0.02),
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Container(
                                                      child:
                                                      Column(mainAxisSize: MainAxisSize.min, children: [
                                                        Container(
                                                          margin: EdgeInsets.all(10.0),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius.circular(20.0),
                                                                topLeft: Radius.circular(20.0),
                                                                bottomRight: Radius.circular(20.0),
                                                                bottomLeft: Radius.circular(20.0)),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: buttonTextColor,
                                                                style: BorderStyle.solid),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(8.0),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                        width: size.width*0.25,
                                                                        child: Text("Name :",
                                                                          style: TextStyle(
                                                                              fontFamily: 'railway'),)),
                                                                    SizedBox(
                                                                      width: 10.0,
                                                                    ),
                                                                    Container(
                                                                      width: size.width*0.55,
                                                                      child: Text(
                                                                        agentCompanyList[index].name!,
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 16,
                                                                            fontFamily: 'railway'
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 15.0,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                      width: size.width*0.25,
                                                                      child: Text(
                                                                        "Email :",
                                                                        style: TextStyle(
                                                                            fontFamily: 'railway'),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10.0,
                                                                    ),
                                                                    Container(
                                                                      width: size.width*0.55,
                                                                      child: Text(
                                                                        agentCompanyList[index].email!,
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'railway',
                                                                          fontSize: 16,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 15.0,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                      width: size.width*0.25,
                                                                      child: Text(
                                                                        "Contact no :",
                                                                        style: TextStyle(
                                                                            fontFamily: 'railway'),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10.0,
                                                                    ),
                                                                    Container(
                                                                      width: size.width*0.55,
                                                                      child: Text(
                                                                        agentCompanyList[index].contactNo!,
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 16,
                                                                            fontFamily: 'railway'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 15.0,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                      width: size.width*0.25,

                                                                      child: Text(
                                                                        "Status :",
                                                                        style: TextStyle(
                                                                            fontFamily: 'railway'),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10.0,
                                                                    ),
                                                                    Container(
                                                                      width: size.width*0.55,

                                                                      child: Text(
                                                                        "Active",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 16,
                                                                            fontFamily: 'railway',
                                                                            color: Colors.green),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 15.0,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap: (){
                                                                        Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) {
                                                                              return CompanyPage(agentCompanyList[index]);
                                                                            },
                                                                          ),
                                                                        );
                                                                      },
                                                                      child: Container(
                                                                        width: size.width*0.2,
                                                                        height: size.height*0.04,
                                                                        margin: EdgeInsets.only(right: size.width*0.015),
                                                                        decoration: BoxDecoration(
                                                                          color: buttonTextColor,
                                                                          borderRadius: BorderRadius.circular(10.0),
                                                                          border: Border.all(
                                                                            width: 1.0,
                                                                          ),
                                                                        ),
                                                                        child: Center(
                                                                          child: Text("View More",style: TextStyle(
                                                                              fontFamily: 'railway',
                                                                              color: whiteTextColor,
                                                                              fontSize:
                                                                              size.height * 0.015,
                                                                              fontWeight:
                                                                              FontWeight.normal),),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: size.height * 0.010,),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ]));
                                                }),
                                          ),
                                        ])),
                                  )
                                ])),
                      ]),
                ),



                // List of user
               /* Container(
                  margin: EdgeInsets.only(
                    top: size.width * 0.05,
                    left: size.width * 0.01,
                    right: size.width * 0.01,),
                  child: ListView.builder(
                      itemCount: agentUserList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(size.width * 0.02),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                              Container(
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      topLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0)),
                                  border: Border.all(
                                      width: 1,
                                      color: buttonTextColor,
                                      style: BorderStyle.solid),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: size.width*0.25,
                                              child: Text("Name :",
                                                style: TextStyle(
                                                    fontFamily: 'railway'),)),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Container(
                                            width: size.width*0.55,
                                            child: Text(
                                              agentUserList[index].name!,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  fontFamily: 'railway'
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: size.width*0.25,
                                            child: Text(
                                              "Email :",
                                              style: TextStyle(
                                                  fontFamily: 'railway'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Container(
                                            width: size.width*0.55,
                                            child: Text(
                                              agentUserList[index].email!,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'railway',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: size.width*0.25,
                                            child: Text(
                                              "Contact no :",
                                              style: TextStyle(
                                                  fontFamily: 'railway'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Container(
                                            width: size.width*0.55,
                                            child: Text(
                                              agentUserList[index].contactNo!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  fontFamily: 'railway'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: size.width*0.25,

                                            child: Text(
                                              "Status :",
                                              style: TextStyle(
                                                  fontFamily: 'railway'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Container(
                                            width: size.width*0.55,

                                            child: Text(
                                              "Active",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  fontFamily: 'railway',
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: size.width*0.25,
                                            child: Text(
                                              "Last Paid :",
                                              style: TextStyle(
                                                  fontFamily: 'railway'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Container(
                                            width: size.width*0.55,

                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'railway',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ]));
                      }),
                ),*/
              ],
            ),
          ),
        )
    );
  }


  Future<void> getAgentReferelUsers() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      idLoading = true;
    });

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/agent/myusers',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };

    Response response = await get(uri, headers: headers);

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("SubCategoryList::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;

      setState(() {
        idLoading = false;
        agentUsers = AgentUsers.fromJson(jsonDecode(responseBody));
        agentUserList.addAll(agentUsers.data!);
      });
    }
  }

  Future<void> getAgentReferelCompany() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      idLoading = true;
    });

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/agent/mycompanies',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };

    Response response = await get(uri, headers: headers);

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("SubCategoryList::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;
      setState(() {
        idLoading = false;
        agentCompany = AgentCompany.fromJson(jsonDecode(responseBody));
        agentCompanyList.addAll(agentCompany.data!);
      });

    }
  }
}