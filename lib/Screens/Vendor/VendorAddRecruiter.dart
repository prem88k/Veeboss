import 'package:flutter/material.dart';
import 'package:veeboss/Screens/Vendor/BottomNavigationBarVendor.dart';
import 'package:http/http.dart' as http;
import '../../Contants/Colors.dart';
import '../../Presentation/common_widgets.dart';
import '../LoginScreen.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class VendorAddRecruiter extends StatefulWidget {
  const VendorAddRecruiter({Key? key}) : super(key: key);

  @override
  State<VendorAddRecruiter> createState() => _VendorAddRecruiterState();
}

class _VendorAddRecruiterState extends State<VendorAddRecruiter> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool isChecked = false;
  bool _obscureText = true;
  String? gender;
  File? _image;
  bool isloading = false;
  String code = '';

  @override
  void initState() {
    _loadCounter();
    // TODO: implement initState
    super.initState();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      code = (prefs.getString('userId')) ?? "";
      print(code);
    });
  }

  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0,
          elevation: 0,
          title: Text(
            "Add Recruiter",
            style: TextStyle(
                fontFamily: 'railway',
                color: appText,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: appBackground,
          iconTheme: IconThemeData(
              color: appText,
              size: size.height * 0.035 //change your color here
          ),
        ),
        backgroundColor: appBackground,
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                top: size.height * 0.012,
                left: size.height * 0.045,
                right: size.height * 0.045,
                bottom: size.height * 0.045),
            alignment: Alignment.centerLeft,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                            child: GestureDetector(
                              onTap: () {
                                getImage1();
                              },
                              child: _image == null ? Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.15,
                                  width: size.height * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: buttonTextColor,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/profile.png"
                                        ),
                                        fit: BoxFit.cover
                                    ),
                                  )
                              ) :Container(
                                alignment: Alignment.center,
                                height: size.height * 0.15,
                                width: size.height * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: buttonTextColor,
                                  image: DecorationImage(
                                      image: new FileImage(_image!),
                                      fit: BoxFit.cover
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),
                      //name
                      TextFieldWidget(
                        controller: _nameController,
                        title: "Name",
                      ),

                      //password
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

                      TextFieldWidget(
                        controller: _emailController,
                        title: "Email",
                      ),

                      TextFieldWidget(
                        controller: _mobileController,
                        title: "Mobile Number",
                      ),

                      TextFieldWidget(
                        controller: _ageController,
                        title: "Age",
                      ),

                      TextFieldWidget(
                        controller: _bioController,
                        title: "Bio",
                      ),

                      Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor:appButton,
                            disabledColor: appText
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child:   RadioListTile(
                                activeColor: appButton,
                                title: Text("Male", style: TextStyle(
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.normal,
                                    color: appText)),
                                value: "male",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child:  RadioListTile(
                                activeColor: appButton,
                                title: Text("Female", style: TextStyle(
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.normal,
                                    color: appText)),
                                value: "female",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: size.height * 0.015,
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
                            margin: EdgeInsets.all(size.width * 0.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: appButton
                              /*gradient: LinearGradient(
                                  colors: [
                                    Color(0xff2E4B93),
                                    Color(0xff1AA5FF),
                                  ]
                              ),*/
                            ),
                            width: size.width * 0.8,
                            height: size.height * 0.06,
                            child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      fontSize: size.width * 0.04,
                                      color: whiteTextColor),
                                ))),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.015,
                  ),
                ]),
          ),
        ));
  }


  void checkValidation() {
    bool contactValid =
    RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(_mobileController.text);

    if (_nameController.text.isEmpty) {
      Message(context, "Enter Name");
    } else if (_passwordController.text.isEmpty) {
      Message(context, "Enter Password");
    }else if (_emailController.text.isEmpty) {
      Message(context, "Enter Email");
    } else if (!contactValid) {
      Message(context, "Enter valid Contact Number");
    } else if (_mobileController.text.isEmpty) {
      Message(context, "Enter Contact Number");
    }  else if (_bioController.text.isEmpty) {
      Message(context, "Enter Bio");
    } else {
      Register(code);
    }
  }



  Future<void> Register(String code) async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('yourang.shop', '/veeboss/public/api/v1/register');
    //----------------------------------------------------------
    var request = new http.MultipartRequest("POST", url);
    print("refer::: $code");
    request.fields['name'] = _nameController.text;
    request.fields['password'] = _passwordController.text;
    request.fields['email'] = _emailController.text;
    request.fields['contact_no'] = _mobileController.text;
    request.fields['bio'] = _bioController.text;
    request.fields['age'] = _ageController.text;
    request.fields['experience'] = "";
    request.fields['role'] =  "agent";
    request.fields['location'] = "";
    request.fields['position'] =  "";
    request.fields['gender'] = gender!;
    request.fields['resume_file'] = "";
    request.fields['reference_code'] = "abc";
    request.fields['document_file'] = "";
    request.fields['resume_file'] = "";
    request.fields['refer_from'] = code.toString();


    if(_image != null)
    {
      request.files.add(
          await http.MultipartFile.fromPath(
            'profile_image',
            _image!.path,
          ));
    }

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
                    return BottomNavigationBarVendor();
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
        /*setState(() {
          isloading = false;
        });
        Message(context,"Something went Wrong");*/
      }
    });
  }

  getImage1() async {
    bool? isCamera = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              color: primaryColor,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Row(
                children: [
                  Icon(Icons.camera,color: whiteTextColor,),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Camera",style: TextStyle(
                    fontFamily: 'Opensans',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            MaterialButton(
              color: primaryColor,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Row(
                children: [
                  Icon(Icons.picture_in_picture,color: whiteTextColor,),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Gallery ",style: TextStyle(
                     fontFamily: 'Opensans',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
          source: isCamera! ? ImageSource.camera : ImageSource.gallery);
      final pickedImageFile = File(pickedImage!.path);
      setState(() {
        _image = pickedImageFile;
      });
    } catch (error) {
      print("error: $error");
    }
  }
}