import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Screens/ChangePassword.dart';
import 'package:veeboss/Screens/Employee/BottomNavigationBarEmploye.dart';
import 'package:veeboss/Screens/Employer/BottomNavigationBar.dart';
import 'package:veeboss/Screens/Employer/EmployerSubscriptionPlan.dart';
import 'package:veeboss/Screens/ForgotPassword.dart';
import 'package:veeboss/Screens/HomeScreen/EmployeeHomeScreen.dart';
import 'package:veeboss/Screens/SignUpScreen.dart';
import 'package:veeboss/Screens/agent/BottomNavigationBar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../Presentation/common_widgets.dart';
import '../Presentation/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'SignUpScreenAgent.dart';
import 'Vendor/BottomNavigationBarVendor.dart';


enum LoginType { facebook, google, apple }

class LoginScreen extends StatefulWidget {
  String role;

  LoginScreen(this.role);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<LoginScreen> {
  bool isloading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int id = 1;
  bool rememberMe = false;
  late String deviceName = "";
  String? deviceId;
  late String name;
  late String email;
  late String imageUrl;
  late String uId;
  bool _obscureText = true;

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _fetching = true;
  bool isChecked = false;


  @override
  void initState() {
    super.initState();
   /* _checkLogin();*/
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackground,
      key: _scaffoldKey,
     /* appBar: AppBar(
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: buttonTextColor,
        iconTheme: IconThemeData(
            color: Colors.white,
            size: size.height * 0.035 //change your color here
            ),
      ),*/
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              top: size.height * 0.1,
              left: size.width * 0.055,
              right: size.width * 0.055),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.jpeg",
                    fit: BoxFit.fill,
                    height: size.height * 0.15,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontFamily: 'railway',
                          fontSize: size.width * 0.055,
                          color: appHeader),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Find local jobs with better salary!\nKindly login now for best jobs",
                      style: TextStyle(
                          fontFamily: 'railway',
                          fontSize: size.width * 0.035,
                          color: appText),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      controller: _phoneController,
                      title: "Mobile Number / Email",
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 14,
                          color: appText,
                          fontFamily: 'railway',
                        ),
                        decoration: InputDecoration(
                          suffixIcon: new GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: new Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: appText,
                            ),
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.normal,
                              color: appText),

                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: borderColors,
                              width: 1.0,

                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: borderColors,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: borderColors, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: EdgeInsets.only(left: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgetPasswordPage();
                              },
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.width * 0.03,
                                  color: appHeader),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.035,
                    ),



                    CheckboxListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: GestureDetector(
                        onTap: () {
                          _launchtermsCondition();
                        },
                        child: Text(
                          "Agreed to terms and condition",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'railway',
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      value: isChecked,
                      activeColor: whiteTextColor,
                      checkColor: buttonTextColor,
                      onChanged: (newValue) {
                        setState(() {
                          isChecked = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),

                    SizedBox(
                      height: size.height * 0.025,
                    ),

                    isloading
                        ? CircularProgressIndicator(
                      backgroundColor: buttonTextColor,
                    )
                        : GestureDetector(
                      onTap: () {
                        checkValidation();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.all(size.width * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                               color: appButton
                               /* gradient: LinearGradient(
                                    colors: [
                                      Color(0xff2E4B93),
                                      Color(0xff1AA5FF),
                                    ]
                                ),*/
                              ),
                              width: size.width * 0.6,
                              height: size.height * 0.06,
                              child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.width * 0.04,
                                        color: whiteTextColor),
                                  ))),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.030,
                    ),
                   /* widget.role == "agent" ?
                    Container()
                     :*/
                    GestureDetector(
                      onTap: () {
                        widget.role == "user" ?
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterPage(widget.role);
                            },
                          ),
                        ):
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignupAgentPage(widget.role);
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: size.width * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account?",
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.width * 0.035,
                                  color: appText),
                            ),
                            Text(
                              " SignUp",
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.width * 0.035,
                                  fontWeight: FontWeight.bold,
                                  color: appHeader),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
                            fontFamily: 'railway',
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
      ),
    );
  }

  Future<void> _launchtermsCondition() async {
    String nativeUrl = "https://yourang.shop/veeboss/public/terms_codition";
    if (await canLaunchUrl(Uri.parse(nativeUrl))) {
      await launchUrl(Uri.parse(nativeUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Terms Codition"),
        ),
      );
    }
  }

    Future<void> Login() async {
      setState(() {
        isloading = true;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var uri = Uri.https(
        'yourang.shop',
        '/veeboss/public/api/v1/login',
      );
      final headers = {'Accept': 'application/json'};
      String? token = await FirebaseMessaging.instance.getToken();

      Map<String, dynamic> body = {
        'contact_no': _phoneController.text,
        'password': _passwordController.text,
        'fcm':token,
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
      print("responseLogin::$responseBody");
      if (statusCode == 200) {
        if (!getdata["is_error"]) {
          setState(() {
            isloading = false;
          });
       //   Message(context, "Login Successfully");

          prefs.setString("sessionToken",
              "${getdata["data"]["session_token"].toString()}");
          prefs.setString("refer_code", getdata["data"]["refer_code"].toString());
          prefs.setString("userId", getdata["data"]["id"].toString());
          prefs.setString("name", getdata["data"]["name"].toString());
          prefs.setString("role", getdata["data"]["role"].toString());
          prefs.setString("age", getdata["data"]["age"].toString());
          prefs.setString("age", getdata["data"]["age"].toString());
          prefs.setString("gender", getdata["data"]["gender"].toString());
          prefs.setString("email", getdata["data"]["email"].toString());
          prefs.setString("contact_no", getdata["data"]["contact_no"].toString());
          prefs.setBool("isLogging", true);
          print(getdata["data"]["refer_code"].toString());

          if (getdata["data"]["role"] == 'user') {
            Message(context, "Login Successfully");
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BottomNavigationBarEmploye();
                  },
                ),
              );
            });
          }
          else if (getdata["data"]["role"] == 'agent') {
            Message(context, "Please enter correct credentials.");
          }
          else if (getdata["data"]["role"] == 'company') {
            Message(context, "Please enter correct credentials.");
          }
          else if (getdata["data"]["role"] == 'vendor') {
            Message(context, "Please enter correct credentials.");
          }
        } else if (getdata["error"] != null) {
          setState(() {
            isloading = false;
          });
        }
      } else {
        setState(() {
          isloading = false;
        });
        Message(context, getdata["message"]);
      }
    }

 /* Future<String?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
    await GoogleSignIn(scopes: <String>["email"]).signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
    await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    if (user != null) {
      // Checking if email and name is null
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      name = user.displayName!;
      email = user.email!;
      imageUrl = user.photoURL!;
      uId = user.uid;
      postRegisterGoogleData(uId, name, email);
      // Only taking the first part of the name, i.e., First Name
      if (name.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));
      }

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser!.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }

  Future<void> postRegisterGoogleData(
      String? accessToken, String name, String email) async {
    setState(() {
      isloading = true;
    });
    String? token = await FirebaseMessaging.instance.getToken();
    print("Tpkoen::$token");
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        deviceName = 'android';
        deviceId = androidInfo.id;
        print("DeviceId::$deviceId");
      });
    } else {
      var iosdeviceinfo = await deviceInfo.iosInfo;
      setState(() {
        deviceName = 'ios';
        deviceId = iosdeviceinfo.identifierForVendor!;
      });
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/user/sociallogin',
    );
    final headers = {'Accept': 'application/json'};
    Map<String, dynamic> body = {
      'name': name,
      'social_id': accessToken,
      'device_id': deviceId,
      'platform': deviceName,
      'email': email,
      'contact_no': "",
      'fcm_token': token
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
    print("responseStepSocial::$responseBody");
    if (statusCode == 200) {
      if (!getdata["is_error"]) {
        setState(() {
          isloading = false;
        });
        if (!getdata["data"]["isphone"]) {
          Message(context, "Please Register first !");
        } else {
          Message(context, "Login Successfully");
          prefs.setString("UserId", "${getdata["data"]["id"].toString()}");
          prefs.setString("name", getdata["data"]["name"].toString());
          prefs.setString("email", getdata["data"]["email"].toString());
          prefs.setString("phone", getdata["data"]["contact_no"].toString());
          prefs.setString(
              "sessionToken", getdata["data"]["session_token"].toString());
          prefs.setBool("isLogging", true);
          Future.delayed(const Duration(milliseconds: 2000), () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => EmployeeHomeScreen()));
          });
        }

        *//*bookTable();*//*

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
      Message(context, getdata["message"]);
    }
  }

  Future<void> _checkLogin() async {
    await Future.delayed(Duration(seconds: 1));
    _fetching = false;
    setState(() {});
  }

  void _login(LoginType type) async {
    setState(() {
      _fetching = true;
    });
    OAuthCredential? credential;
    if (type == LoginType.facebook) {
      credential = await _loginWithFacebook();
    }

    if (credential! != null) {
      await _auth.signInWithCredential(credential);
    }

    setState(() {
      _fetching = false;
    });
  }

  Future<OAuthCredential?> _loginWithFacebook() async {
    print("FBLOgin");
    final fb = FacebookLogin();
    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
      // The user is suceessfully logged in
      // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        final AuthCredential authCredential =
        FacebookAuthProvider.credential(accessToken!.token);
        final result =
        await FirebaseAuth.instance.signInWithCredential(authCredential);
        // Get profile data from facebook for use in the app
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');
        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');
        // fetch user email
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');
        postRegisterGoogleData(profile.userId, profile.name!, email!);
        break;
      case FacebookLoginStatus.cancel:
      // In case the user cancels the login process
        break;
      case FacebookLoginStatus.error:
      // Login procedure failed
        print('Error while log in: ${res.error}');
        break;
    }
  }
*/
  void checkValidation() {
    bool passRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*]).{8,}$')
        .hasMatch(_passwordController.text);
    if (_phoneController.text.isEmpty) {
      Message(context, "Enter Mobile number");
    } else if (_phoneController.text.length != 10) {
      Message(context, "Enter valid Mobile Number");
    } else if (_passwordController.text.isEmpty) {
      Message(context, "Enter Password");
    }else if (!isChecked) {
      Message(context, "Accept Terms & Condition");
    } else {
      Login();
    }
  }

}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> Message(
    BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 800),
    ),
  );
}
