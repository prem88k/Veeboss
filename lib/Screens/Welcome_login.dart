import 'package:flutter/material.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Presentation/rounded_button.dart';
import 'package:veeboss/Screens/LoginScreen.dart';
import 'package:veeboss/Screens/SignUpScreen.dart';
import 'SignUpScreenEmployer.dart';

class WelcomeLogin extends StatefulWidget {
  String role;

  WelcomeLogin(this.role);

  @override
  State<WelcomeLogin> createState() => _WelcomeLoginState();
}

class _WelcomeLoginState extends State<WelcomeLogin> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
      backgroundColor: whiteTextColor,
      appBar: AppBar(
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: whiteTextColor,
        iconTheme: IconThemeData(
            color: Colors.black,
            size: size.height * 0.035 //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height*0.045),
                  color: whiteTextColor,
                  height: size.height * 0.35,
                  width: size.width,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/logo.jpeg",
                        height: size.height * 0.25,
                      ),
                      SizedBox(height: size.height * 0.05),

                      Text(
                        "WELCOME TO 3 Clicks Jobs",
                        style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor,fontFamily: "railway",fontSize: size.height*0.020),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Text(
                  "You are continuing with ${widget.role.toUpperCase()} ",
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: size.height*0.020,fontFamily: "railway"),
                ),
                SizedBox(height: size.height * 0.05),
                RoundedButton(
                  text: "LOGIN",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen(widget.role);
                        },
                      ),
                    );
                  },
                ),
                widget.role == "company" ? RoundedButton(
                  text: "SIGN UP",
                  color: whiteTextColor,
                  textColor: Colors.black,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreenEmployer(widget.role);
                        },
                      ),
                    );
                  },
                )
               : widget.role == "user" ? RoundedButton(
                  text: "SIGN UP",
                  color: whiteTextColor,
                  textColor: Colors.black,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterPage(widget.role);
                        },
                      ),
                    );
                  },
                ): Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}