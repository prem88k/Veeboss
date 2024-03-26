import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Contants/Colors.dart';

class InvitePage extends StatefulWidget {
  String title;

  InvitePage(this.title);

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {

  String code = '';
  late  TextEditingController _codeController = TextEditingController();

  @override
  void initState() {

    _loadCounter();
    // TODO: implement initState
    super.initState();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      code = (prefs.getString('refer_code')) ?? "";
      _codeController.text = code.toString();
      print(code);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: appText,
            size: size.height * 0.035 //change your color here
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appBackground,
        title: Text(
          widget.title,
          style: TextStyle(
              fontFamily: 'railway',
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.025,
              color: appText),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              decoration: BoxDecoration(
                color: appBackground
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.050, bottom: size.height * 0.030),
                   child: Image(
                     image: AssetImage("assets/images/invitation.png"),
                     height: size.height * 0.1,
                   ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: size.height * 0.030),
                    width: size.width * 0.8,
                    alignment: Alignment.center,
                    child: Text(
                      'Invite friends and get surprising rewards.',
                      style: TextStyle(
                          fontFamily: 'railway',
                          color: appText,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: size.height * 0.030),
                    width: size.width * 0.8,
                    alignment: Alignment.center,
                    child: Text(
                      'Share Your Code',
                      style: TextStyle(
                          fontFamily: 'railway',
                          color: appHeader,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                    child: TextFormField(
                      controller: _codeController,
                      style: TextStyle(
                        fontSize: 14,
                        color: appText,
                        fontFamily: 'railway',
                      ),
                      decoration: InputDecoration(
                        suffixIcon: new GestureDetector(
                          onTap: () {
                          },
                          child: new Icon(CupertinoIcons.rectangle_fill,
                            color: appText,
                          ),
                        ),
                        hintText: 'Code',
                        hintStyle: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.normal,
                            color: appText),

                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: borderColors,
                            width: 1.0,

                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: appText,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: appText, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.050,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.050,
            ),

            GestureDetector(
              onTap: () {
                _onShare(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(size.width * 0.01),
                      decoration: BoxDecoration(
                        color: appButton,
                        borderRadius: BorderRadius.circular(12),
                        /*gradient: LinearGradient(
                            colors: [
                              Color(0xff2E4B93),
                              Color(0xff1AA5FF),
                            ]
                        ),*/
                      ),
                      width: size.width * 0.6,
                      height: size.height * 0.06,
                      child: Center(
                          child: Text(
                            "Invite now",
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.width * 0.04,
                                color: appBackground),
                          ))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }



  void _onShare(BuildContext context) async {
    final data = await rootBundle.load('assets/images/qrcode.png');
    final buffer = data.buffer;
    final box = context.findRenderObject() as RenderBox?;
    await Share.shareXFiles(
        [
          XFile.fromData(
            buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
            name: 'qrcode.png',
            mimeType: '.png',
          ),
        ],
       text: "You've been invited to earn with Veeboss Technology! Go to https://play.google.com/store/apps/details?id=com.app.veeboss.veeboss to set up your account." ,
       /* [XFile("assets/images/qrcode.png")],text: "I Am inviting you for download veeboss App and get amazing jobs.",*/
        subject: "www.veeboss.com",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
