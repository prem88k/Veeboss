import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart' as fireAuth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Contants/Colors.dart';
import '../LoginScreen.dart';





class OtpScreenRegister extends StatefulWidget {
  String mobileNumber;
  String code,password,name,email,bio,age,experience,role,address,gender,reference;
  File? image;
  File? resume;
  OtpScreenRegister(this.mobileNumber, this.code, this.password, this.name, this.email, this.bio, this.age, this. experience,  this. role, this. address, this.gender, this. reference, this. image, this.resume);

  @override
  _OtpScreenRegisterState createState() => _OtpScreenRegisterState();
}

class _OtpScreenRegisterState extends State<OtpScreenRegister> {
  bool _obscureText = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isloading = false;
  String otp = '';

  final _firebaseAuth = fireAuth.FirebaseAuth.instance;
  late String deviceName = "";
  String? deviceId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(

        backgroundColor: appHeader,
        elevation: 30.0,

        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height*0.015),
            Container(
              alignment: Alignment.topLeft,
              child:Text(
                'OTP Authentication',
                style: TextStyle(
                  fontFamily: 'railway',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height*0.018,),
              ),
            ),
            SizedBox(height: size.height*0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(

                  width: size.height*0.355,
                  alignment: Alignment.topLeft,
                  child:Text(
                    'A 6-digit OTP has been sent on your mobile number registerd with your Phone ',
                    style: TextStyle(
                      fontFamily: 'railway',
                      color: Colors.black,
                      fontSize: size.height*0.015),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height*0.035),
              Container(
                height: size.height * 0.2,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OTPTextField(
                          length: 6,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 40,
                          fieldStyle: FieldStyle.box,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'railway',
                          ),
                          onChanged: (pin) {
                            print("Changed: " + pin);
                          },
                          onCompleted: (pin) {
                            setState(() {
                              otp = pin;
                            });
                            print("Completed: " + pin);
                          },
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              isloading
                  ? CircularProgressIndicator(
                backgroundColor: buttonTextColor,
              )
                  : GestureDetector(
                onTap: () {
                  if (otp == '') {
                    Message(context, "Enter Otp");
                  } else {
                    OtpSubmit();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height*0.055,
                      width: size.height*0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:appButton
                      ),
                      child: Center(
                        child: Text("Verify OTP",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'railway',
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: size.height*0.015,)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),

              /*  GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ForgotPasswordPage();
                      },
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: size.width*0.045),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password ?",
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: size.width * 0.04,
                            color: buttonTextColor),
                      ),
                    ],
                  ),
                ),
              ),*/
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: size.height * 0.025, right: size.height * 0.02),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
                    SizedBox(
                      height: size.height * 0.035,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  Future<void> OtpSubmit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print("Code:::${widget.code.toString()}");
    print("EnterOtp:::$otp");

    setState(() {
      isloading = true;
    });
    final fireAuth.AuthCredential credential =
        fireAuth.PhoneAuthProvider.credential(
            verificationId: widget.code.toString(), smsCode: otp);

    /// Try to sign in with provided credential
    await _firebaseAuth
        .signInWithCredential(credential)
        .then((fireAuth.UserCredential userCredential) {
      setState(() {
        isloading = false;
      });
        RegisterNow();
    }).catchError((error) {
      setState(() {
        isloading = false;
      });
      // Callback function
      Message(context, " We were unable to verify your phone number. Please try again!");

    });
  }

    Future<void> RegisterNow() async {
      setState(() {
        isloading = true;
      });

      String generateRandomString(int len) {
        var r = Random();
        const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
        return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = Uri.https('yourang.shop', '/veeboss/public/api/v1/register');
      //----------------------------------------------------------
      var request = new http.MultipartRequest("POST", url);
      request.fields['name'] = widget.name;
      request.fields['refer_code'] = generateRandomString(5);
      request.fields['password'] = widget.password;
      request.fields['email'] = widget.email;
      request.fields['contact_no'] = widget.mobileNumber;
      request.fields['bio'] = widget.bio;
      request.fields['age'] = widget.age;
      request.fields['experience'] = widget.experience;
      request.fields['role'] =  widget.role;
      request.fields['location'] =  widget.address;
      request.fields['position'] =  "";
      request.fields['gender'] = widget.gender.toLowerCase();
      request.fields['document_file'] = "";

      if (widget.reference != null){
        request.fields['reference_code'] = widget.reference;
      }

      if(widget.image != null)
      {
        request.files.add(
            await http.MultipartFile.fromPath(
              'profile_image',
              widget.image!.path,
            ));
      }

      if(widget.resume == null){
        Message(context, "Upload Resume");
      } else {
        request.files.add(
            http.MultipartFile(
                'resume_file',
                File(widget.resume!.path).readAsBytes().asStream(),
                File(widget.resume!.path).lengthSync(),
                filename: widget.resume!.path.split("/").last
            ));}

      request.send().then((response) {
        if (response.statusCode == 200) {
          print("Uploaded!");

          int statusCode = response.statusCode;
          print("response::$response");
          response.stream.transform(utf8.decoder).listen((value) {
            print("ResponseSellerVerification" + value);
            setState(() {
              isloading = false;
            });
            FocusScope.of(context).requestFocus(FocusNode());

            Message(context, "Registration Successfully");
            Future.delayed(const Duration(milliseconds: 1000), () {
              setState(() {
                // todo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen(widget.role);
                    },
                  ),
                );
              });
            });
          });
        } else {
          response.stream.transform(utf8.decoder).listen((value) {
            print("ResponseSellerVerification" + value);
            var getdata = json.decode(value);
            setState(() {
              isloading = false;
            });
            Message(context,getdata['message']);
          });
          /* setState(() {
          isloading = false;
        });*/
        }
      });
    }
  }

