import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Screens/Welcome_login.dart';
import '../../Presentation/common_widgets.dart';
import '../Contants/Colors.dart';
import '../Presentation/rounded_button.dart';
import 'LoginScreen.dart';
import 'WelcomeScreen.dart';


class ForgotPasswordOtp extends StatefulWidget {
  String email;
  ForgotPasswordOtp(this.email);

  @override
  State<ForgotPasswordOtp> createState() => _ForgotPasswordOtpState();
}

class _ForgotPasswordOtpState extends State<ForgotPasswordOtp> {
  TextStyle style =
      TextStyle(fontFamily: 'railway', fontSize: 20.0, color: Colors.white);
  final TextEditingController _otptroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscured = true;
  final textFieldFocusNode = FocusNode();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: appBackground,
        elevation: 0,
        iconTheme: IconThemeData(
            color: appText,
            size: size.height * 0.035 //change your color here
        ),
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
                    "Forgot Password OTP",
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
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.center,
                controller: _otptroller,
                style: TextStyle(
                    fontFamily: 'railway',
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.normal,
                    color: appText),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  isDense: true,
                  filled: true,
                  labelText: 'OTP',
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
                controller: _passwordController,
                style: TextStyle(
                    fontFamily: 'railway',
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.normal,
                    color: appText),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  isDense: true,
                  filled: true,
                  labelText: 'Password',
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
            SizedBox(
              height: size.height * 0.05,
            ),
            isLoading
                ? CircularProgressIndicator(
              color: primaryTextColor,
            )
                : RoundedButton(
              text: "FORGOT PASSWORD",
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
    if (_otptroller.text.isEmpty) {
      Message(context, "Enter OTP");
    } else if (_passwordController.text.isEmpty) {
      Message(context, "Enter Password");
    } else if (_passwordController.text.length < 5) {
      Message(context, "Password will max 5 letter");
    } else {
      ForgotPassword();
    }
  }

  Future<void> ForgotPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/forgotpasswordotp',

    );
    final headers = {'Accept': 'application/json'};
    Map<String, dynamic> body = {
      'email': widget.email,
      'otp': _otptroller.text,
      'password': _passwordController.text,
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

    print("PasswordChanged::$responseBody");
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

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }
}