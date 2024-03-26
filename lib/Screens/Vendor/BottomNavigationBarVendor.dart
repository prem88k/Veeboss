import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veeboss/Screens/Vendor/VendorAllJobs.dart';
import '../../Contants/Colors.dart';
import '../AppDrawer.dart';
import '../Employee/ProfileNavigationPAge.dart';
import '../Employer/NotificationScreen.dart';
import '../SearchPage.dart';
import '../agent/ProfilePage.dart';
import 'AppAnalysesReport.dart';
import 'CreateJobVendor.dart';
import 'VendorAddRecruiter.dart';
import 'VendorAllCompany.dart';
import 'VendorAllRecruiter.dart';
import 'VendorAllUserList.dart';

class BottomNavigationBarVendor extends StatefulWidget {
  const BottomNavigationBarVendor({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarVendor> createState() => _BottomNavigationBarVendorState();
}

class _BottomNavigationBarVendorState extends State<BottomNavigationBarVendor> {

  int currentIndex = 0;

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new AppAnalysesReport();
      case 1:
        return new VendorAllJobs();
      case 2:
        return new VendorAllRecruiter();
      case 3:
        return new VendorAllCompany();
      case 4:
        return new VendorAllUserList();
      case 5:
        return new ProfilePage();
      default:
        return AppAnalysesReport();
    }
  }


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

          shape: Border(
              bottom: BorderSide(
                  color: appBackground,
                  width: 0.1
              )
          ),
          elevation: 0,
          title: /*Image(image: AssetImage("assets/images/appbar_logo.JPEG"),
            height: size.height * 0.060,
            width: size.width * 0.3,),*/
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
          backgroundColor: appBackground,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: appButton,),
            tooltip: 'Menu Icon',
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CreateJobVendor();
                  },
                ),
              );
            },
            icon: Icon(Icons.add, color: appButton,),
          ),
          /*IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return VendorAddRecruiter();
                  },
                ),
              );
            },
            icon: Icon(Icons.add, color: appButton,),
          ),*/
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProfileNavigationPage();
                  },
                ),
              );
            },
            icon: Icon(Icons.person_outline, color: appButton),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NotificationScreen();
                  },
                ),
              );
            },
            icon: Icon(Icons.notifications_outlined, color: appButton),
          ),
          IconButton(
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
          ),
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
                  border: Border(top: BorderSide(color: appButton, width: 0.2))),
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
                        Icons.shopping_bag_outlined,
                        size: 21.0,
                      ),
                      // ignore: deprecated_member_use
                      label: "Jobs"),

                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.list_alt_outlined,
                        size: 22.0,
                      ),
                      label: "Recruiter"),

                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.comment_outlined,
                        size: 22.0,
                      ),
                      label: "Company"),

                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.list,
                          size: 22.0,
                        ),
                        label: "User"),

                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        size: 22.0,
                      ),
                      // ignore: deprecated_member_use
                      label: "Profile"),
                ],
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

