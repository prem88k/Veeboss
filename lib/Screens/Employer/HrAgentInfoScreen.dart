import 'package:flutter/material.dart';
import 'package:veeboss/Models/Employer/GetAssignAllCompany.dart';

import '../../Contants/Colors.dart';

class HrAgentInfo extends StatefulWidget {
  CompanyUserList companyUserList;

  HrAgentInfo(this.companyUserList);

  @override
  State<HrAgentInfo> createState() => _HrAgentInfoState();
}

class _HrAgentInfoState extends State<HrAgentInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: appText
        ),
        title: Text(
          "Info Page",
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
              padding: EdgeInsets.all(size.height * 0.020),
              child: Container(
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
                                  padding: EdgeInsets.only(left: size.height * 0.020, right: size.height * 0.020),
                                  child: TabBar(
                                    labelColor: appHeader,
                                    unselectedLabelColor: Colors.black,
                                    indicatorColor: appHeader,
                                    tabs: [
                                      Container(
                                          alignment: Alignment.center,
                                          child: Tab(text: ' HR ')),
                                      Container(
                                          child: Tab(text: ' Agent ')),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:  size.height * 0.015,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: size.height * 0.020,),
                                    child: Container(
                                        height:   MediaQuery.of(context).size.height * 0.32, //height of TabBarView
                                        child: TabBarView(children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: appBackground,
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
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 20.0),
                                                    child: Text('HR Info',
                                                        style: TextStyle(
                                                          fontFamily: 'railway',
                                                          color: appButton,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: size.height * 0.021,)),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                          },
                                                          child: widget.companyUserList.hr![0].profileImage == null ? Container(

                                                              height: size.height * 0.080,
                                                              width: size.height * 0.080,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  image: DecorationImage(
                                                                      image: AssetImage ("assets/images/profile_photo.jpg"),
                                                                      fit: BoxFit.fill
                                                                  )
                                                              )
                                                          ):  Container(
                                                              height: size.height * 0.080,
                                                              width: size.height * 0.080,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  image: DecorationImage(
                                                                      image:  NetworkImage(widget.companyUserList.hr![0].profileImage.toString()),
                                                                      fit: BoxFit.fill
                                                                  )
                                                              )
                                                          )
                                                      ),
                                                      SizedBox(width: size.width * 0.030,),
                                                      Container(
                                                        width: size.width * 0.55,
                                                      //  height: size.height * 0.15,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Container(
                                                                  width: size.width * 0.5,
                                                                  child: widget.companyUserList.hr![0].name == null ?
                                                                  Text(
                                                                    "-",
                                                                    style: TextStyle(
                                                                      color: appText,
                                                                      fontWeight:
                                                                      FontWeight.w600,
                                                                      fontSize: size.height * 0.025,
                                                                    ),
                                                                  ): Container(
                                                                    width:size.width * 0.55,
                                                                    child: Text(
                                                                      //userList[index],
                                                                      widget.companyUserList.hr![0].name!,
                                                                      maxLines: 2,
                                                                      style: TextStyle(
                                                                          fontFamily: 'railway',
                                                                          fontSize: size.height *
                                                                              0.025,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: appHeader),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: size.height * 0.006,),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                widget.companyUserList.hr![0].email == null ?
                                                                Text(
                                                                  "-",
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    fontSize: size.height * 0.020,
                                                                    color: appText
                                                                  ),
                                                                ): Container(
                                                                  width:size.width * 0.55,
                                                                  child: Text(
                                                                    widget.companyUserList.hr![0].email!,
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontFamily: 'railway',
                                                                        fontSize: size.height *
                                                                            0.020,
                                                                        fontWeight: FontWeight
                                                                            .normal,
                                                                        color: appText),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: size.height * 0.006,),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                widget.companyUserList.hr![0].address == null ?
                                                                Text(
                                                                  "-",
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    fontSize: size.height * 0.020,
                                                                    color: appText
                                                                  ),
                                                                ): Container(
                                                                  width:size.width * 0.55,
                                                                  child: Text(
                                                                    widget.companyUserList.hr![0].address!,
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontFamily: 'railway',
                                                                        fontSize: size.height *
                                                                            0.020,
                                                                        fontWeight: FontWeight
                                                                            .normal,
                                                                        color: appText),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: size.height * 0.006,),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                widget.companyUserList.hr![0].companyInfo == null ?
                                                                Text(
                                                                  "-",
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    fontSize: size.height * 0.020,
                                                                    color: appText
                                                                  ),
                                                                ): Container(
                                                                  width:size.width * 0.55,
                                                                  child: Text(
                                                                    widget.companyUserList.hr![0].companyInfo!,
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontFamily: 'railway',
                                                                        fontSize: size.height *
                                                                            0.020,
                                                                        fontWeight: FontWeight
                                                                            .normal,
                                                                        color: appText),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: size.height * 0.006,),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                widget.companyUserList.hr![0].contactNo == null ?
                                                                Text(
                                                                  "-",
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    fontSize: size.height * 0.020,
                                                                    color: appText
                                                                  ),
                                                                ): Text(
                                                                  widget.companyUserList.hr![0].contactNo!,
                                                                  style: TextStyle(
                                                                      fontFamily: 'railway',
                                                                      fontSize: size.height *
                                                                          0.020,
                                                                      fontWeight: FontWeight
                                                                          .normal,
                                                                      color: appText),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      /* GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return ProfileJobDetails(jobListData[index]);
                                                  },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                    alignment: Alignment.topRight,
                                                    padding: EdgeInsets.only(right: size.width * 0.012),
                                                    child: Icon(
                                                  Icons.visibility_outlined,
                                                  color: primaryTextColor,
                                                    )),
                                              ),*/
                                                    ],
                                                  ),



                                                ],
                                              ),
                                            ),
                                          ),
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
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 20.0),
                                                    child: Text('Agent Info',
                                                        style: TextStyle(
                                                          fontFamily: 'railway',
                                                          color: appButton,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: size.height * 0.021,)),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                          },
                                                          child: widget.companyUserList.agent![0].profileImage == null ? Container(

                                                              height: size.height * 0.080,
                                                              width: size.height * 0.080,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  image: DecorationImage(
                                                                      image: AssetImage ("assets/images/profile_photo.jpg"),
                                                                      fit: BoxFit.fill
                                                                  )
                                                              )
                                                          ):  Container(
                                                              height: size.height * 0.080,
                                                              width: size.height * 0.080,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  image: DecorationImage(
                                                                      image:  NetworkImage(widget.companyUserList.agent![0].profileImage.toString()),
                                                                      fit: BoxFit.fill
                                                                  )
                                                              )
                                                          )
                                                      ),
                                                      SizedBox(width: size.width * 0.030,),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: size.width * 0.030,),
                                                          Container(
                                                            width: size.width * 0.55,
                                                           // height: size.height * 0.15,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .start,
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Container(
                                                                      width: size.width * 0.5,
                                                                      child: widget.companyUserList.agent![0].name == null ?
                                                                      Text(
                                                                        "-",
                                                                        style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight.w600,
                                                                          fontSize: size.height * 0.025,
                                                                          color: appHeader
                                                                        ),
                                                                      ): Text(
                                                                        //userList[index],
                                                                        widget.companyUserList.agent![0].name!,
                                                                        maxLines:3,
                                                                        style: TextStyle(
                                                                            fontFamily: 'railway',
                                                                            fontSize: size.height *
                                                                                0.025,
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color: appHeader),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: size.height * 0.006,),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    widget.companyUserList.agent![0].email == null ?
                                                                    Text(
                                                                      "-",
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w600,
                                                                        fontSize: size.height * 0.020,
                                                                        color: appText
                                                                      ),
                                                                    ) :Container(
                                                                      width:size.width * 0.55,
                                                                      child: Text(
                                                                        widget.companyUserList.agent![0].email!,
                                                                        maxLines:2,
                                                                        style: TextStyle(
                                                                            fontFamily: 'railway',
                                                                            fontSize: size.height *
                                                                                0.020,
                                                                            fontWeight: FontWeight
                                                                                .normal,
                                                                            color: appText),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: size.height * 0.006,),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    widget.companyUserList.agent![0].address == null ?
                                                                    Text(
                                                                      "-",
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w600,
                                                                        fontSize: size.height * 0.020,
                                                                        color: appText
                                                                      ),
                                                                    ) : Container(
                                                                      width:size.width * 0.55,
                                                                      child: Text(
                                                                        widget.companyUserList.agent![0].address!,
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                            fontFamily: 'railway',
                                                                            fontSize: size.height *
                                                                                0.020,
                                                                            fontWeight: FontWeight
                                                                                .normal,
                                                                            color: appText),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: size.height * 0.006,),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    widget.companyUserList.agent![0].companyInfo == null ?
                                                                    Container(
                                                                      child: Text(
                                                                        "-",
                                                                       maxLines:2,
                                                                        style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight.w600,
                                                                          color:appText,
                                                                          fontSize: size.height * 0.020,
                                                                        ),
                                                                      ),
                                                                    ) : Container(
                                                                      width:size.width * 0.55,
                                                                      child: Text(
                                                                        widget.companyUserList.agent![0].companyInfo!,
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                            fontFamily: 'railway',
                                                                            fontSize: size.height *
                                                                                0.020,
                                                                            fontWeight: FontWeight
                                                                                .normal,
                                                                            color: appText),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: size.height * 0.006,),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    widget.companyUserList.agent![0].contactNo == null ?
                                                                    Text(
                                                                      "-",
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w600,
                                                                        fontSize: size.height * 0.020,
                                                                        color: appText
                                                                      ),
                                                                    ): Text(
                                                                      widget.companyUserList.agent![0].contactNo!,
                                                                      style: TextStyle(
                                                                          fontFamily: 'railway',
                                                                          fontSize: size.height *
                                                                              0.020,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color: appText),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      /* GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ProfileJobDetails(jobListData[index]);
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                    alignment: Alignment.topRight,
                                                    padding: EdgeInsets.only(right: size.width * 0.012),
                                                    child: Icon(
                                                      Icons.visibility_outlined,
                                                      color: primaryTextColor,
                                                    )),
                                              ),*/
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ])),
                                  ),
                                )
                              ])),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
