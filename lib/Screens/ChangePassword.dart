import 'package:flutter/material.dart';
import 'package:veeboss/Screens/WelcomeScreen.dart';
import 'dart:convert';
import '../../Contants/Colors.dart';
import '../../Presentation/common_widgets.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../Presentation/rounded_button.dart';
import 'LoginScreen.dart';

class ChangePassword extends StatefulWidget {
  String? email;
  ChangePassword(this.email);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  bool _obscured = true;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        backgroundColor:appBackground,
        elevation: 0,
        iconTheme: IconThemeData(
            color: appText,
            size: size.height * 0.035 //change your color here
        ),
        /*centerTitle: true,
        title: Text(
          "Change Password",
          style: TextStyle(
              color: whiteTextColor,
              fontFamily: 'railway',
              fontSize: size.height * 0.025,),
        ),*/
      ),
      backgroundColor: appBackground,
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.only(
            top: size.height * 0.03,
            left: size.height * 0.03,
            right: size.height * 0.05),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Create New Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: appText,
                        fontSize: size.height * 0.030,
                        fontFamily: "railway"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: _oldPasswordController,
                style: TextStyle(
                  fontFamily: 'railway',
                  fontSize: size.width * 0.035,
                  fontWeight: FontWeight.normal,
                  color: appText),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  isDense: true,
                  filled: true,
                  labelText: 'Old Password',
                  labelStyle: TextStyle(
                      fontFamily: 'railway',
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.normal,
                      color: appText),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryTextColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: primaryTextColor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: primaryTextColor, width: 1.0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: _newPasswordController,
                style: TextStyle(
                    fontFamily: 'railway',
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.normal,
                    color: appText),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  isDense: true,
                  filled: true,
                  labelText: 'New Password',
                  labelStyle: TextStyle(
                      fontFamily: 'railway',
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.normal,
                      color: appText),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryTextColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: primaryTextColor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: primaryTextColor, width: 1.0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            /*TextFieldWidget(
              title:  "Confirm Password",
              controller: _confirmPasswordController,
            ),*/
            SizedBox(
              height: size.height * 0.05,
            ),
            isLoading
                ? CircularProgressIndicator(
              color: primaryTextColor,
            )
                : RoundedButton(
              text: "CHANGE PASSWORD",
              press: () {
                CheckValidation();
              },
            )
          ],
        ),
      ),
    );
  }
  void CheckValidation() {
    bool passRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*]).{8,}$')
        .hasMatch(_newPasswordController.text);

    if (_oldPasswordController.text.isEmpty) {
      Message(context, "Enter old Password");
    } else if (_newPasswordController.text.isEmpty) {
      Message(context, "Enter New Password");
    }  else {
      ResetPassword();
    }
  }

  Future<void> ResetPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print((int.parse(bidValueController.text)*100)/int.parse(contestPrice));
    setState(() {
      isLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/changepassword',
    );
    final headers = {'x-session-token': '${prefs.getString('sessionToken')}'};

    Map<String, dynamic> body = {
      'email': widget.email,
      'old_password': _oldPasswordController.text,
      'new_password': _newPasswordController.text,
    };

    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    var getdata = json.decode(response.body);

    int statusCode = response.statusCode;
    String responseBody = response.body;

    print("ResetPassword::$responseBody");
    if (statusCode == 200) {
      if (getdata["success"]) {
        Message(context, "Password changed succesfully!");
        setState(() {
          isLoading = false;
        });
        Future.delayed(const Duration(milliseconds: 2500), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SelectRole();
              },
            ),
          );
        });
      } else {
        Message(context, getdata["message"]);
        setState(() {
          isLoading = false;
        });
      }
    } else {
      Message(context, getdata["message"]);
      setState(() {
        isLoading = false;
      });
    }
  }

}
