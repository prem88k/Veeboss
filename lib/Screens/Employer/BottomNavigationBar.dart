
import 'package:flutter/material.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Screens/agent/ProfilePage.dart';
import '../AppDrawer.dart';
import '../Employee/ProfileNavigationPAge.dart';
import 'CreateJobEmployer.dart';
import 'EmployerAppAnalystPage.dart';
import 'EmployerUserList.dart';
import 'JobHistory.dart';
import 'NotificationScreen.dart';
import 'homepage.dart';
import 'myJobs.dart';
import 'myJobsWithApplicant.dart';


class bottomNavigationBarEmployer extends StatefulWidget {
  @override
  _bottomNavigationBarT2State createState() => _bottomNavigationBarT2State();
}

class _bottomNavigationBarT2State extends State<bottomNavigationBarEmployer> {
  int currentIndex = 0;

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new EmployerAppAnalystPage();
      case 1:
        return new MyHomePage();
      case 2:
        return new EmployerUserList();
      case 3:
        return new ProfilePage();
      default:
        return MyHomePage();
    }
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: appBackground,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          bottomOpacity: 0,
          elevation: 1,
          shape: Border(bottom: BorderSide(color: borderColors, width: 0.5)),
          title: /*Image(image: AssetImage("assets/images/appbar_logo.JPEG"),
            height: size.height * 0.060,
            width: size.width * 0.2,), */
          Text(
            "Veeboss",
            style: TextStyle(
              color: appButton,
              fontSize: 18,
              fontFamily:
              'railway',
              fontWeight: FontWeight.bold,
            ),
          ), /*Text(currentIndex == 0 ? "Company User"  : "Profile" , style: TextStyle(
              color: appButton,
            fontSize: 18,
            fontFamily:
            'railway',
            fontWeight: FontWeight.bold,
          ),),*/
          backgroundColor: appBackground,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: appText,),
            tooltip: 'Menu Icon',
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CreateJobEmployer();
                    },
                  ),
                );
              },
              icon: Icon(Icons.add, color: appButton,),
            ),
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
              icon: Icon(Icons.person_outline, color: appButton,),
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
              icon: Icon(Icons.notifications_outlined, color: appButton,),
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
                        size: 20.0,
                      ),
                      // ignore: deprecated_member_use
                      label: "Home"),

                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_bag,
                        size: 20.0,
                      ),
                      // ignore: deprecated_member_use
                      label:"My Jobs"),

                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.list_alt_outlined,
                        size: 20.0,
                      ),
                      label:"User List"),

                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        size: 20.0,
                      ),
                      // ignore: deprecated_member_use
                      label:  "Profile"),
                ],
              ),
            )),
      );
  }
}
