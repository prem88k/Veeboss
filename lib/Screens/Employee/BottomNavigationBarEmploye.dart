
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Screens/Employee/ApploedJObsPage.dart';
import 'package:veeboss/Screens/Employer/NotificationScreen.dart';
import 'package:veeboss/Screens/HomeScreen/EmployeeHomeScreen.dart';
import 'package:veeboss/Screens/agent/ProfilePage.dart';
import '../AppDrawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../SearchPage.dart';
import '../Vendor/VendorAllCompany.dart';
import '../agent/ProfilePage.dart';
import 'ChatScreen.dart';
import 'EmployeeSaveJobsScreen.dart';
import 'ProfileNavigationPAge.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_geocoder/location_geocoder.dart';

class BottomNavigationBarEmploye extends StatefulWidget {
  BottomNavigationBarEmploye();

  @override
  _BottomNavigationBarEmployeState createState() => _BottomNavigationBarEmployeState();
}

class _BottomNavigationBarEmployeState extends State<BottomNavigationBarEmploye> {
  int currentIndex = 0;

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();

  }

  String? stAddress;
  late LocatitonGeocoder geocoder = LocatitonGeocoder("AIzaSyCkW__vI2DazIWYjIMigyxwDtc_kyCBVIo");
  _getLocation() {
    getUserCurrentLocation().then((value) async {
      print(value.latitude.toString() + " " + value.longitude.toString());
      final coordinates = new Coordinates(value.latitude, value.longitude);
      var address = await geocoder.findAddressesFromCoordinates(coordinates);
      var first = address.first;
      setState(() {
        stAddress = first.subLocality.toString();
      });
      print(stAddress);
    });
  }

  @override
  initState() {
   _getLocation();
    // TODO: implement initState
    super.initState();
  }

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new EmployeeHomeScreen();
      case 1:
        return new EmployeeAppliedJobListPage();
      case 2:
        return new EmployeeSaveJobsScreen();
      case 3:
        return new VendorAllCompany();
      case 4:
        return new ProfilePage();
      default:
        return EmployeeHomeScreen();
    }
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: appBackground,
          key: _scaffoldKey,
          appBar: AppBar(
            bottomOpacity: 0,

            centerTitle: false,
            shape: Border(
                bottom: BorderSide(
                    color: appBackground,
                    width: 0.1
                )
            ),
            elevation: 0,
            title: Image(image: AssetImage("assets/images/appbar_logo.JPEG"),
              height: size.height * 0.2,
              width: size.width * 0.2,),

            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 "Veeboss",
                  style: TextStyle(
                    color: appButton,
                    fontSize: 18,
                    fontFamily:
                    'railway',
                    fontWeight: FontWeight.bold,
                  ),
                ),

               *//* Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    width: size.width * 0.3,
                    child: Center(
                      child: Row(
                        children: [
                          Container(
                              child: Icon(Icons.location_on_outlined,color: appButton, size: size.height * 0.035,)),
                          Flexible(
                            child: Text(
                             stAddress.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: appButton,
                                fontSize: size.width * 0.035,
                                fontFamily:
                                'railway',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*//*

              ],
            ),*/
            /*Text(currentIndex == 0 ? "All Jobs"  : currentIndex == 1 ? "Applied Job"  : currentIndex == 2 ? "Saved Job" : currentIndex == 3 ? "Chat Screen" : "Profile" , style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily:
              'railway',
              fontWeight: FontWeight.bold,
            ),),*/
            backgroundColor: appBackground,
            leading: IconButton(
              icon: const Icon(Icons.menu,
                color: appButton,),
              tooltip: 'Menu Icon',
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),actions: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(

                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfilePage();
                        },
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user_logo.png",),
                    radius: 15,
                  ),
                ),
                new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Container(
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return NotificationScreen();
                              },
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: appButton,
                              size: 30,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top: 5),
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                    border:
                                    Border.all(color: Colors.white, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Center(
                                    child: Text(
                                      '0',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Container(
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          launch("tel://18001233396");
                        },
                        child: Image.asset(
                          "assets/images/call.png",
                          height: 22,width: 22,
                        ),
                      ),
                    )),
              ],
            )

            /*IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchPage();
                    },
                  ),
                );
              },
              icon: Icon(Icons.search, color: appButton),
            ),*/
          ],
          ),
          drawer: AppDrawer(context),
          body: callPage(currentIndex),
          bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: appBackground,
                  textTheme: Theme.of(context).textTheme.copyWith(
                      caption: TextStyle(color: appText.withOpacity(0.15)))),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),),
                  boxShadow: [
                    BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                  ],
                ),
                  //  border: Border(top: BorderSide(color: appButton, width: 0.2))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor: appText,
                    selectedItemColor: appButton,
                    currentIndex: currentIndex,
                    unselectedLabelStyle:  TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.normal,
                      fontSize: size.width * 0.03,
                      color: appText) ,
                    selectedLabelStyle:  TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.03,
                      color: Colors.white),
                    onTap: (value) {
                      currentIndex = value;
                      setState(() {});
                    },
                    items: [

                      BottomNavigationBarItem(
                          icon: Icon(
                           Icons.home,
                            size: 21.0,
                          ),
                          // ignore: deprecated_member_use
                          label: "Home"),

                      BottomNavigationBarItem(
                          icon: Icon(
                              Icons.layers,
                            size: 22.0,
                          ),
                          label: "History"),

                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.save_alt_outlined,
                            size: 22.0,
                          ),
                          label: "Saved"),

                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.chat_outlined,
                            color: whiteTextColor,

                            size: 22.0,
                          ),
                          label: "Chat"),

                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.person,
                            size: 22.0,
                          ),
                          // ignore: deprecated_member_use
                          label: "Profile"),
                    ],
                  ),
                ),
              )),
        ),
      );
  }
  Future<bool> _onWillPop() async {
    Size size = MediaQuery.of(context).size;

    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: whiteTextColor,
        shape: Border.all(color: whiteTextColor),
        title: Row(children: [
          Image.asset(
            'assets/images/logo.jpeg',
            width: size.height * 0.085,
            height: size.height * 0.065,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: size.width * 0.035,
          ),
          Text('Veeboss',
              style: TextStyle(
                  fontFamily: 'railway',
                  fontSize: size.height * 0.02,
                  color: buttonTextColor,
                  fontWeight: FontWeight.bold))
        ]),
        content: Text("Are You Sure, You Want To Exit the App?",
            style: TextStyle(
                fontFamily: 'railway',
                fontSize: size.height * 0.022,
                color: buttonTextColor,
                fontWeight: FontWeight.normal)),
        actions: <Widget>[
          MaterialButton(
            child: Container(
              height: size.height * 0.050,
              width:size.width * 0.25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: whiteTextColor),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: buttonTextColor
              ),
              child: Text(
                "YES",
                style: TextStyle(
                    fontFamily: 'railway',
                    fontSize: size.height * 0.015,
                    color: whiteTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              //Put your code here which you want to execute on Yes button click.
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
          ),
          MaterialButton(
            child: Container(
              height: size.height * 0.050,
              width:size.width * 0.25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: whiteTextColor),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: buttonTextColor
              ),
              child: Text(
                "CANCEL",
                style: TextStyle(
                    fontFamily: 'railway',
                    fontSize: size.height * 0.015,
                    color: whiteTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              //Put your code here which you want to execute on Cancel button click.
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    )) ??
        false;
  }
}
