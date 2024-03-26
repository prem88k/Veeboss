import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Contants/Colors.dart';
import '../../Models/Agent/ProfileData.dart';
import '../../Models/Employee/MyJobs.dart';
import '../ChangePassword.dart';
import '../Employee/ApploedJObsPage.dart';
import 'package:http/http.dart';
import '../WelcomeScreen.dart';

class EmployerProfile extends StatefulWidget {
  int? userId;
  EmployerProfile(this.userId);

  @override
  State<EmployerProfile> createState() => _EmployerProfileState();
}

class _EmployerProfileState extends State<EmployerProfile> {

  late GetProfileInformation getProfileInformation;
  bool isLoading = false;
  SharedPreferences? prefs;

  @override
  void initState() {
    getProfileData();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        backgroundColor: appBackground,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: appText
        ),
        title: Text("Company Profile",
            style: TextStyle(fontFamily: 'railway',
                color: appText,
                fontSize: size.height * 0.025,
                fontWeight: FontWeight.bold)),
      ),
      body: isLoading &&prefs==null
    ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: getProfileInformation.data![0].profileImage == null ? Container(
                      alignment: Alignment.topCenter,
                      height: size.height * 0.15,
                      width: size.height * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: appText),
                          image: DecorationImage(
                              image: AssetImage ("assets/images/profile.png"),
                              fit: BoxFit.fill
                          )
                      )
                  ): Container(
                    alignment: Alignment.center,
                    height: size.height * 0.15,
                    width: size.height * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: appText),
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
                padding: EdgeInsets.only(left: 18.0, right:18.0,bottom: 18.0),
                child: Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: appButton,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(15.0),),
                    color: appBackground
                    ,
                    child: Container(
                      width: size.width * 1.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  getProfileInformation.data![0].name.toString(),
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appHeader,
                                      fontSize: size.height * 0.023,
                                      fontWeight: FontWeight.bold)
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  getProfileInformation.data![0].email.toString(),
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appText,
                                      fontSize: size.height * 0.020,
                                      fontWeight: FontWeight.normal)
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(bottom: 0.0),
                              child: Text(getProfileInformation.data![0].address.toString(),
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
                    color: appBackground
                    ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          padding: EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Text('About',
                              style: TextStyle(
                                fontFamily: 'railway',
                                color: appHeader,
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.021,)),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0, bottom: 5.0),
                          child:  DescriptionTextWidget(text: getProfileInformation.data![0].bio == null ?
                           "-" :
                          getProfileInformation.data![0].bio!),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Divider(
                            thickness: 0.2,
                            color: borderColors,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                          child: Container(
                           decoration: BoxDecoration(
                             shape: BoxShape.rectangle,
                             borderRadius: BorderRadius.circular(5.0),
                             border: Border.all(color: appButton)
                           ),
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              child: Text(
                                  getProfileInformation.data![0].email== null ?
                                  "-":
                                  getProfileInformation.data![0].email!,
                                  style: TextStyle(
                                    fontFamily: 'railway',
                                    color: appText,
                                    fontWeight: FontWeight.normal,
                                    fontSize: size.height * 0.021,)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
                    color: appBackground
                    ,
                    child: Container(
                      width: size.width * 1.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 5.0, bottom: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text("Bio",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    color: appHeader,
                                    fontSize: size.height * 0.021,
                                    fontWeight: FontWeight.bold)),

                            SizedBox(
                              height: size.height * 0.020,
                            ),

                            DescriptionTextWidget(text:
                            getProfileInformation.data![0].bio == null ?
                            "-":
                            getProfileInformation.data![0].bio!),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
             /* Padding(
                padding: EdgeInsets.only(left: 18.0, right:18.0,bottom: 20.0),
                child: Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: borderColors,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(15.0),),
                    color: primaryColor
                    ,
                    child: Container(
                      width: size.width * 1.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 5.0, bottom: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text("Position",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    color: whiteTextColor,
                                    fontSize: size.height * 0.021,
                                    fontWeight: FontWeight.bold)),

                            SizedBox(
                              height: size.height * 0.015,
                            ),

                            Text(getProfileInformation.data![0].createdAt.toString(),
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    color: primaryTextColor,
                                    fontSize: size.height * 0.018,
                                    fontWeight: FontWeight.normal)),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/


        /*      Padding(
                padding: EdgeInsets.only(left: 18.0, right:18.0,),
                child: Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),),
                    color: Colors.white,
                    child: Container(
                      width: size.width * 1.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 20.0),
                              child: Text('Change Password',
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
                                      return ChangePassword(getProfileInformation.data![0].email);
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
                      ),
                    ),
                  ),
                ),
              ),*/
              SizedBox(
                height: size.height * 0.015,
              ),
            ],
          ),
        ),
      )
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
      '/veeboss/public/api/v1/profile/${widget.userId}',
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
      setState(() {
        isLoading = false;
        getProfileInformation = GetProfileInformation.fromJson(jsonDecode(responseBody));

      /* _userNameController.text=getProfileInformation.data!.name!;
         _emailController.text=getProfileInformation.data!.email!;
         _ageController.text=getProfileInformation.data!.age.toString();
         _genderController.text=getProfileInformation.data!.gender!;
         _numberController.text=getProfileInformation.data!.contactNo!;
         _referCodeController.text=getProfileInformation.data!.referenceCode!; */

      });
    }
  }
}