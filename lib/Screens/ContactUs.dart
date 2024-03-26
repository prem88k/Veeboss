import 'package:flutter/material.dart';
import '../Contants/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  String title;

  ContactUs(this.title);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ContactUs> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: appText, size: size.height * 0.035 //change your color here
            ),
        centerTitle: true,
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
      body: Container(
          margin: EdgeInsets.all(size.height * 0.03),
          child: Column(
            children: [
              Image.asset(
                "assets/images/logo.jpeg",
                fit: BoxFit.fill,
                height: size.height * 0.15,
              ),
              SizedBox(
                height: size.height * 0.035,
              ),
              Center(
                child: Text(
                  "VEEBOSS TECHNOLOGY PVT LTD",
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.035,
                      color: appHeader),
                ),
              ),
              SizedBox(
                height: size.height * 0.045,
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.050),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Email :- ",
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.04,
                                color: appText),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.6,
                              child: Text(
                                "info@veebosstechnology.com",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontWeight: FontWeight.normal,
                                    fontSize: size.width * 0.04,
                                    color: appText),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.005,
                            ),
                            Container(
                              width: size.width * 0.6,
                              child: Text(
                                "veebosstechnology.ofc@gmail.com",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontWeight: FontWeight.normal,
                                    fontSize: size.width * 0.04,
                                    color: appText),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Website :- ",
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.04,
                                color: appText),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.6,
                              child: Text(
                                "www.veebosstechnology.com",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontWeight: FontWeight.normal,
                                    fontSize: size.width * 0.04,
                                    color: appText),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Ph. No. :- ",
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.04,
                                color: appText),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.6,
                              child: Text(
                                "+91 99861 23413",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontWeight: FontWeight.normal,
                                    fontSize: size.width * 0.04,
                                    color: appText),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Customer Care No. :- ",
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.04,
                                color: appText),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.4,
                              child: Text(
                                "18001233396",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontWeight: FontWeight.normal,
                                    fontSize: size.width * 0.04,
                                    color: appText),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.035,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              /*RaisedButton(
                onPressed: _launchURL,
                child: Text('Show Flutter homepage'),
              ),*/
            ],
          )),
    );
  }

  _launchURL() async {
    const url = 'www.veebosstechnology.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
