import 'package:flutter/material.dart';
import 'package:veeboss/Models/Agent/AgentUsers.dart';

import '../../Contants/Colors.dart';
import '../Employee/PdfViewr.dart';

class UserPage extends StatefulWidget {
  AgentUserList agentUserList;
  UserPage(this.agentUserList);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        shadowColor: primaryColor,
        centerTitle: true,
        title: Text(
          "Info Page",
          style: TextStyle(
              fontFamily: 'railway',
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.05,
              color: Colors.white),
        ),
      ),
       body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(left: size.height * 0.0,),
            child: Container(
                height:   MediaQuery.of(context).size.height * 0.65, //height of TabBarView
                child: Container(
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                },
                                child: widget.agentUserList.profileImage == null ? Container(
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
                                            image:  NetworkImage(widget.agentUserList.profileImage.toString()),
                                            fit: BoxFit.fill
                                        )
                                    )
                                )
                            ),
                            SizedBox(width: size.width * 0.080,),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: size.width * 0.5,
                                        child: widget.agentUserList.name == null ?
                                        Text(
                                          "-",
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.w600,
                                            fontSize: size.height * 0.020,
                                          ),
                                        ): Container(
                                          width:size.width * 0.55,
                                          child: Text(
                                            //userList[index],
                                            widget.agentUserList.name!,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontFamily: 'railway',
                                                fontSize: size.height *
                                                    0.025,
                                                fontWeight: FontWeight
                                                    .bold,
                                                color: primaryColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.006,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      widget.agentUserList.email == null ?
                                      Text(
                                        "-",
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: size.height * 0.020,
                                        ),
                                      ): Container(
                                        width:size.width * 0.55,
                                        child: Text(
                                          widget.agentUserList.email!,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontFamily: 'railway',
                                              fontSize: size.height *
                                                  0.021,
                                              fontWeight: FontWeight
                                                  .normal,
                                              color: primaryTextColor),
                                        ),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.020,),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                                    width: size.width * 0.6,
                                    child: Text(
                                     "Address :- ",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height *
                                              0.020,
                                          fontWeight: FontWeight
                                              .normal,
                                          color: primaryColor),
                                    ),
                                  ),
                                  widget.agentUserList.address == null ?
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                                    width: size.width * 0.6,
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: size.height * 0.020,
                                      ),
                                    ),
                                  ): Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0,bottom: 5.0),
                                    width: size.width * 0.6,
                                    child: Text(
                                      widget.agentUserList.address!,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height *
                                              0.020,
                                          fontWeight: FontWeight
                                              .normal,
                                          color: primaryTextColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.006,),
                            Divider(
                              thickness: 1.0,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: size.height * 0.006,),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                                    width: size.width * 0.6,
                                    child: Text(
                                      "Bio :- ",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height *
                                              0.020,
                                          fontWeight: FontWeight
                                              .normal,
                                          color: primaryColor),
                                    ),
                                  ),
                                  widget.agentUserList.bio == null ?
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                                    width: size.width * 0.6,
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: size.height * 0.020,
                                      ),
                                    ),
                                  ): Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0,bottom: 5.0),
                                    width: size.width * 0.6,
                                    child: Text(
                                      widget.agentUserList.bio!,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height *
                                              0.020,
                                          fontWeight: FontWeight
                                              .normal,
                                          color: primaryTextColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.006,),
                            Divider(
                              thickness: 1.0,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: size.height * 0.006,),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                                    width: size.width * 0.6,
                                    child: Text(
                                      "Experience :- ",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height *
                                              0.020,
                                          fontWeight: FontWeight
                                              .normal,
                                          color: primaryColor),
                                    ),
                                  ),
                                  widget.agentUserList.experience == null ?
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                                    width: size.width * 0.6,
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: size.height * 0.020,
                                      ),
                                    ),
                                  ): Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0,bottom: 5.0),
                                    width: size.width * 0.6,
                                    child: Text(
                                      widget.agentUserList.experience!,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height *
                                              0.020,
                                          fontWeight: FontWeight
                                              .normal,
                                          color: primaryTextColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.006,),
                            Divider(
                              thickness: 1.0,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: size.height * 0.006,),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                                    width: size.width * 0.6,
                                    child: Text(
                                      "Gender :- ",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height *
                                              0.020,
                                          fontWeight: FontWeight
                                              .normal,
                                          color: primaryColor),
                                    ),
                                  ),
                                  widget.agentUserList.gender == null ?
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                                    width: size.width * 0.6,
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: size.height * 0.020,
                                      ),
                                    ),
                                  ): Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0,bottom: 5.0),
                                    width: size.width * 0.6,
                                    child: Text(
                                      widget.agentUserList.gender!,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.height *
                                              0.020,
                                          fontWeight: FontWeight
                                              .normal,
                                          color: primaryTextColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.006,),
                            Divider(
                              thickness: 1.0,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: size.height * 0.006,),

                            widget.agentUserList.role == "user"
                                ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                      padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 20.0),
                                      child: Text('View Resume',
                                          style: TextStyle(
                                            fontFamily: 'railway',
                                            color: buttonTextColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.height * 0.021,)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return PdfView( widget.agentUserList.resume!);
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 20.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: size.height * 0.020,
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        )
    );
  }
}
