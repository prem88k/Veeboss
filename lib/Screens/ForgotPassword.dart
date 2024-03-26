import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Contants/Colors.dart';
import '../Presentation/rounded_button.dart';
import 'ForgotPasswordOtp.dart';
import 'LoginScreen.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isloading = false;
  bool tableLoading = false;
  String platform = "";

  @override
  void initState() {
    // TODO: implement initState
/*    _emailController.text = "pqr4@gmail.com";
    _passwordController.text = "123456";*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackground,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: appBackground,
        elevation: 0,
        iconTheme: IconThemeData(
            color: appText,
            size: size.height * 0.035 //change your color here
            ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          padding: EdgeInsets.only(
              top: size.height * 0.050,
              left: size.width * 0.03,
              right: size.width * 0.03),
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Forgot Password?",
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
                height: size.height * 0.1,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, left: 20.0, right: 20.0),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: _emailController,
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.normal,
                      color: appText),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                    isDense: true,
                    filled: true,
                    labelText: 'Email',
                    prefixIconConstraints:BoxConstraints(maxHeight: 20) ,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 0, right: 10, bottom: 3, left: 10),
                      child: Container(
                          child: Icon(Icons.email_outlined, color: appText,
                            size: size.height * 0.027,)
                      ),
                    ),
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
                height: size.height * 0.040,
              ),
              isloading
                  ? CircularProgressIndicator(
                      color: buttonTextColor,
                    )
                  : RoundedButton(
                text: "GET YOUR OTP",
                press: () {
                  CheckValidation();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void CheckValidation() {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(_emailController.text);
    if (_emailController.text.isEmpty) {
      Message(context, "Enter Email");
    } else if (!emailValid) {
      Message(context, "Enter valid Email");
    }  else {
      ForgotPassword();
    }
  }

  Future<void> ForgotPassword() async {
    setState(() {
      isloading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/forgotpassword',
    );
    final headers = {'Accept': 'application/json'};

    Map<String, dynamic> body = {
      'email': _emailController.text,
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
    print("PasswordChangedOTP::$responseBody");
    if (statusCode == 200) {
      if (statusCode == 200) {
        setState(() {
          isloading = false;
        });
    //    Message(context, "Sent Mail to your registered email kindly check");
        Message(context, "OTP send to your email.");
        Future.delayed(const Duration(milliseconds: 2000), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ForgotPasswordOtp(_emailController.text);
              },
            ),
          );
        });
      } else {
        setState(() {
          isloading = false;
        });
        Message(context, getdata["message"]);
      }
    } else {
      setState(() {
        isloading = false;
      });
      Message(context, getdata["error"]);
    }
  }
}
