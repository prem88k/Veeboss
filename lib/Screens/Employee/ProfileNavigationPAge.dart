import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Models/Agent/ProfileData.dart';
import 'package:veeboss/Screens/ChangePassword.dart';
import 'package:veeboss/Screens/LoginScreen.dart';
import 'package:veeboss/Screens/WelcomeScreen.dart';

import '../../Presentation/rounded_button.dart';
import '../Employee/PdfViewr.dart';
import '../agent/editProfile.dart';


class ProfileNavigationPage extends StatefulWidget {
  @override
  _ProfileScreenT2State createState() => _ProfileScreenT2State();
}

class _ProfileScreenT2State extends State<ProfileNavigationPage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _referCodeController = TextEditingController();

  late String _radioValue;
  late String choice;
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _numberController = TextEditingController();


  bool isLoading = false;
  SharedPreferences? prefs;
  late GetProfileInformation getProfileInformation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
      backgroundColor: appBackground,
      key: _scaffoldKey,
      appBar: AppBar(
        bottomOpacity: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: appText
        ),
        shape: Border(
            bottom: BorderSide(
                color: borderColors,
                width: 0.5
            )
        ),
        elevation: 1,
        title: Text(
          "Profile Page",
          style: TextStyle(
            color: appText,
            fontSize: 18,
            fontFamily: 'railway',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: appBackground,),

      // backgroundColor: Colors.white,
      body: isLoading &&prefs==null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: getProfileInformation.data![0].profileImage == 0 ? Container(
                      alignment: Alignment.topCenter,
                      height: size.height * 0.080,
                      width: size.height * 0.080,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: AssetImage ("assets/images/profile_photo.jpg"),
                              fit: BoxFit.fill
                          )
                      )
                  ): Container(
                    alignment: Alignment.center,
                    height: size.height * 0.15,
                    width: size.height * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: buttonTextColor,
                      image: DecorationImage(
                          image: NetworkImage(
                            getProfileInformation.data![0].profileImage.toString(),
                          ),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.015,
              ),

              Padding(
                padding: EdgeInsets.only(left: 18.0, right:18.0,),
                child: Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: appButton,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(15.0),),
                    color: appBackground,
                    child: Container(
                      width: size.width * 1.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            getProfileInformation.data![0].name == null ? Container(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appHeader,
                                      fontSize: size.height * 0.018,
                                      fontWeight: FontWeight.bold)
                              ),
                            ) :
                            Container(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  getProfileInformation.data![0].name!,
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appHeader,
                                      fontSize: size.height * 0.018,
                                      fontWeight: FontWeight.bold)
                              ),
                            ),
                            getProfileInformation.data![0].email == null ?Container(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appText,
                                      fontSize: size.height * 0.018,
                                      fontWeight: FontWeight.bold)
                              ),
                            ) :
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text( getProfileInformation.data![0].email!,
                                  style: TextStyle(
                                    fontFamily: 'railway',
                                    color: appText,
                                    fontSize: size.height * 0.018,)
                              ),
                            ),
                            getProfileInformation.data![0].location == null?Container():Padding(
                              padding:  EdgeInsets.only(bottom: 0.0),
                              child:Text(
                                  getProfileInformation.data![0].location!,
                                  style: TextStyle(
                                    fontFamily: 'railway',
                                    color: appText,
                                    fontSize: size.height * 0.019,)
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0, right:18.0, bottom: 18.0 ),
                child: Container(
                  width: size.width * 1.0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: appButton,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(15.0),),
                    color:appBackground,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Text('About Me',
                              style: TextStyle(
                                fontFamily: 'railway',
                                color: appHeader,
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.021,)),
                        ),
                        getProfileInformation.data![0].experience == null ?
                        Container(
                          padding: EdgeInsets.only(bottom: 8.0, left: 10.0),
                          child: Text(
                              "-",
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  color: appText,
                                  fontSize: size.height * 0.023,
                                  fontWeight: FontWeight.normal)
                          ),
                        )
                            : Container(
                          padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 15.0),
                          child:  DescriptionTextWidget(text: getProfileInformation.data![0].experience!,),
                        ),

                        getProfileInformation.data![0].role == "user"
                            ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Divider(
                                thickness: 0.8,
                                color: primaryTextColor,

                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 20.0),
                                  child: Text('View Resume',
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        color: appHeader,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.height * 0.021,)),
                                ),

                                getProfileInformation.data![0].resume == null ?
                                Container(
                                  child: Text("No Resume File Uploaded" ,
                                      style: TextStyle(
                                        fontFamily: 'railway',
                                        color: buttonTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.height * 0.021,)),
                                )
                                    :  GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return PdfView(getProfileInformation.data![0].resume!);
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 20.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: size.height * 0.020,
                                        color: appHeader,
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0, right:18.0, bottom: 20.0),
                child: Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: appButton,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(15.0),),
                    color: appBackground,
                    child: Container(
                      width: size.width * 1.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Past Experiences",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    color: appHeader,
                                    fontSize: size.height * 0.021,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: size.height * 0.020,
                            ),

                            getProfileInformation.data![0].bio! == null ? Container(
                              padding: EdgeInsets.only(bottom: 8.0, left: 10.0),
                              child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appText,
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.normal)
                              ),
                            ) :
                            DescriptionTextWidget(text:  getProfileInformation.data![0].bio!,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0, right:18.0,),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangePassword(getProfileInformation.data![0].email);
                        },
                      ),
                    );
                  },
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: appButton,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(15.0),),
                      color: appBackground,
                      child: Container(
                        width: size.width * 1.0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                padding: EdgeInsets.all(size.width*0.015),
                                child: Text('Change Password',
                                    style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appHeader,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.018,)),
                              ),
                              GestureDetector(
                                onTap: () {

                                },
                                child: Container(
                                    padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 20.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: size.height * 0.020,
                                      color: appHeader,
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              RoundedButton(
                text: "Edit Profile",
                press: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => editProfile(getProfileInformation)


                  ));},
              ),

              SizedBox(
                height: size.height * 0.015,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> getProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/profile/${prefs.getString("userId")}',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };
    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("Profile::$responseBody");
    if (statusCode == 200) {
      getProfileInformation = GetProfileInformation.fromJson(jsonDecode(responseBody));
      setState(() {
        isLoading = false;
        _userNameController.text=getProfileInformation.data![0].name!;
        _emailController.text=getProfileInformation.data![0].email!;
        _ageController.text=getProfileInformation.data![0].age.toString();
        _genderController.text=getProfileInformation.data![0].gender!;
        _numberController.text=getProfileInformation.data![0].contactNo.toString();
        _referCodeController.text=getProfileInformation.data![0].referenceCode.toString();
      });
    }
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String? txt, image;
  GestureTapCallback? tap;
  double ?padding;

  category({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        txt!,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'railway',
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 15.0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Divider(
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}

class categoryNew extends StatelessWidget {
  @override
  String ?txt, value;
  double ?padding;

  categoryNew({this.txt, this.value, this.padding});

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 15.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: padding!),
                      /*child: Image.asset(
                        image,
                        height: 45.0,
                      ),*/
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        txt!,
                        style: TextStyle(
                            fontFamily: 'railway',                            fontSize: 13.0,
                            color: primaryTextColor,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: size.width * 0.35,
                        child: Text(
                          value!,
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: 'railway',                            fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 80) {
      firstHalf = widget.text.substring(0, 80);
      secondHalf = widget.text.substring(80, widget.text.length);
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
          ? new Text(firstHalf,
        style: TextStyle(
          fontSize: size.height * 0.015,
          color: primaryTextColor,
          fontFamily: 'railway',),
      )
          : new Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0),
            child: Row(

              children: [
                Container(
                    alignment: Alignment.topLeft,
                    width: size.width * 0.6,
                    child:  Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                      style: TextStyle(
                          fontSize: size.height * 0.015,
                          fontFamily: 'railway',
                          color: primaryTextColor
                      ),)),
                InkWell(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          flag ? "Read More" : "Read Less",
                          style:  TextStyle(color: buttonPrimaryColor,
                            fontSize: size.height * 0.015,
                            fontFamily: 'railway',),
                        ),
                      ),
                    ],
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
        ],
      ),
    );
  }
}
