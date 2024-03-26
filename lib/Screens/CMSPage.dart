import 'package:flutter/material.dart';
import 'package:veeboss/Contants/Colors.dart';

import '../Contants/Api.dart';

class CMSPage extends StatefulWidget{
  String title;
  CMSPage(this.title);


  @override
  State<CMSPage> createState() => _CMSPageState();
}

class _CMSPageState extends State<CMSPage> {
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
          child: Container(
              margin: EdgeInsets.all(size.height*0.03),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/logo.jpeg",
                      fit: BoxFit.fill,
                      height: size.height * 0.15,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.035,
                  ),
                  Text("Veeboss INFO TECHNOLOGIES",
                    style: TextStyle(
                        fontFamily: 'railway',
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.04,
                        color: appHeader
                    ),),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  Text("VEEBOSS TECHNOLOGY  has grown to become one of the leading permanent recruitment services operating in Bangalore and servicing clients all over India. We are engaged in providing the most reliable recruitment services to our valuable clients. Here, our expertise lies in offering complete support to client companies for meeting the recruitment and staffing needs in industries like IT, ITES / BPO, Telecom, Sales & Marketing and Accounts & Finance. In today's highly competitive world it is more important to get the human resources with right skill sets for organizations to compete and grow. We ensure the recommended / selected candidate has the desired skills to match up best with the givenrequirement. we are in the market of 8 years had given many  opportunities to thousands of candidates in building their career, and our service is still offering the best career opportunities to various candidates and also need to support the Clients as per their requirements",
                    style: TextStyle(
                        fontFamily: 'railway',
                        fontWeight: FontWeight.normal,
                        fontSize: size.width * 0.04,
                        color: appText
                    ),),
                  SizedBox(
                    height: size.height * 0.010,
                  ),
                  Text("It could be a Great opportunity, to work together & grow together.",
                    style: TextStyle(
                        fontFamily: 'railway',
                        fontWeight: FontWeight.normal,
                        fontSize: size.width * 0.04,
                        color: appText
                    ),),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text("Thanks & Regards  \nVEEBOSS TECHNOLOGY PVT LTD",
                      style: TextStyle(
                        fontFamily: 'railway',
                        fontSize: size.width * 0.04,
                        color: appHeader,
                        fontWeight: FontWeight.normal,
                      ),),
                  ),
                  SizedBox(
                    height: size.height * 0.010,
                  ),
                ],
              )),
        ),/*SafeArea(
          //name=$name&city=$city&phone="string_phone"&otpdate="string_otpdate"&deviceid=
          child: WebviewScaffold(
            url: "https://yourang.shop/veeboss/public/login",
            useWideViewPort: true,
          ),
        )*/
    );
  }
}
