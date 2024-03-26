import 'package:flutter/material.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Screens/Welcome_login.dart';

import '../Presentation/rounded_button.dart';
import 'LoginScreen.dart';

class SelectRole extends StatefulWidget {
  const SelectRole({Key? key}) : super(key: key);

  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
      backgroundColor: appBackground,
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height*0.045),
                  color: Colors.white,
                  height: size.height * 0.3,
                  width: size.width,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/logo.jpeg",
                        height: size.height * 0.25,
                        width: size.width*0.45,
                      ),
                      SizedBox(height: size.height * 0.05),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Text(
                  "Where do you want to go?",
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: size.height*0.020,fontFamily: "railway",color: appText),
                ),
                SizedBox(height: size.height * 0.05),
                RoundedButton(
                  text: "Employee",
                  color: appButton,
                  textColor: appText,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen("user");
                        },
                      ),
                    );
                  },
                ),
                RoundedButton(
                  text: "Recruiter",
                  color: appButton,
                  textColor: appText,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen("agent");
                        },
                      ),
                    );
                  },
                ),
                RoundedButton(
                  text: "Employer",
                  color: whiteTextColor,
                  textColor: whiteTextColor,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen("company");
                        },
                      ),
                    );
                  },
                ),
                RoundedButton(
                  text: "Vendor",
                  color: whiteTextColor,
                  textColor: whiteTextColor,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen("vendor");
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}