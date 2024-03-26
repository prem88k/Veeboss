import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Presentation/common_widgets.dart';
import 'package:veeboss/Screens/HomeScreen/PersonalInfoScreen.dart';
import 'package:file_picker/file_picker.dart';
import '../Contants/Colors.dart';
import '../Presentation/rounded_button.dart';
import 'Employer/BottomNavigationBar.dart';
import 'LoginScreen.dart';

class SignUpScreenEmployer extends StatefulWidget {
  String role;

  SignUpScreenEmployer(this.role);

  @override
  State<SignUpScreenEmployer> createState() => _SignUpScreenEmployerState();
}

class _SignUpScreenEmployerState extends State<SignUpScreenEmployer> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool _isSelected = false;
  bool _obscureText = true;
  bool isChecked = false;
  File? _image;
  File? _image1;

  Future<void> selectPhoto() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
      );
      final pickedImageFile = File(pickedImage!.path);
      setState(() {
        _image = pickedImageFile;
      });
    } catch (error) {
      print("error: $error");
    }
  }

  File? _file;
  String fileName = '';
  Future<void> selectFile() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
      );
      final pickedImageFile = File(pickedImage!.path);
      setState(() {
        _image1 = pickedImageFile;
      });
    } catch (error) {
      print("error: $error");
    }
   /* try {
      final picker = FilePicker.platform;
      final pickedFile = await picker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      final pickedFileSource = File(pickedFile!.files.single.path!);
      fileName = pickedFileSource.path.split('/').last;
      setState(() {
        _file = pickedFileSource;
      });
    } catch (error) {
      print("error: $error");
    }*/
  }

  
  final List<String> items = [
    'user',
    'agent',
    'company',
  ];
  String? selectedValue;
  String? gender;
  bool isloading = false;

 static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0,
          elevation: 0,
          title: Text(
            "Create an account",
            style: TextStyle(
                fontFamily: 'railway',
                color: whiteTextColor,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: buttonTextColor,
          iconTheme: IconThemeData(
              color: Colors.white,
              size: size.height * 0.035 //change your color here
          ),
        ),
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                top: size.height * 0.012,
                left: size.height * 0.03,
                right: size.height * 0.03),
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
                          child: _image == null ? GestureDetector(
                            onTap: () {
                              getImage1();
                            },
                            child: Container(
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
                              ),
                            ),
                          ) :GestureDetector(
                            onTap: () {
                            //  selectPhoto();
                            },
                            child: Container(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                            isDense: true,
                            labelText: 'Company Name',
                            prefixIconConstraints:BoxConstraints(maxHeight: 20) ,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 10, bottom: 3, left: 10),
                              child: Container(
                                  child: Icon(Icons.person_outline, color: primaryTextColor,
                                    size: size.height * 0.027,)
                              ),
                            ),
                            filled: true,
                            labelStyle: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.normal,
                                color: primaryTextColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryTextColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: primaryTextColor,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: primaryTextColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),

                      //password
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          textAlignVertical: TextAlignVertical.center,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                            isDense: true,
                            labelText: 'Password',
                            prefixIconConstraints:BoxConstraints(maxHeight: 20) ,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 10, bottom: 3, left: 10),
                              child: Container(
                                  child: Icon(Icons.lock_outline_sharp, color: primaryTextColor,
                                    size: size.height * 0.027,)
                              ),
                            ),
                            filled: true,
                            labelStyle: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.normal,
                                color: primaryTextColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryTextColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: primaryTextColor,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: primaryTextColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                          ),
                        ),
                      ),

                      //email
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                            isDense: true,
                            labelText: 'Email',
                            prefixIconConstraints:BoxConstraints(maxHeight: 20) ,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 10, bottom: 3, left: 10),
                              child: Container(
                                  child: Icon(Icons.email_outlined, color: primaryTextColor,
                                    size: size.height * 0.027,)
                              ),
                            ),
                            filled: true,
                            labelStyle: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.normal,
                                color: primaryTextColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryTextColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: primaryTextColor,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: primaryTextColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),

                      //mobile number
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          textAlignVertical: TextAlignVertical.center,
                          controller: _mobileController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                            isDense: true,
                            labelText: 'Contact Number',
                            prefixIconConstraints:BoxConstraints(maxHeight: 20) ,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 10, bottom: 3, left: 10),
                              child: Container(
                                  child: Icon(Icons.phone, color: primaryTextColor,
                                    size: size.height * 0.027,)
                              ),
                            ),
                            filled: true,
                            labelStyle: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.normal,
                                color: primaryTextColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryTextColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: primaryTextColor,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: primaryTextColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _addressController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                            isDense: true,
                            labelText: 'Company Location',
                            prefixIconConstraints:BoxConstraints(maxHeight: 20) ,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 10, bottom: 3, left: 10),
                              child: Container(
                                  child: Icon(Icons.location_on_outlined, color: primaryTextColor,
                                    size: size.height * 0.027,)
                              ),
                            ),
                            filled: true,
                            labelStyle: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.normal,
                                color: primaryTextColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryTextColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: primaryTextColor,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: primaryTextColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),

                      //position
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _positionController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                            isDense: true,
                            labelText: 'Position',
                            prefixIconConstraints:BoxConstraints(maxHeight: 20) ,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 10, bottom: 3, left: 10),
                              child: Container(
                                  child: Icon(Icons.post_add_outlined, color: primaryTextColor,
                                    size: size.height * 0.027,)
                              ),
                            ),
                            filled: true,
                            labelStyle: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.normal,
                                color: primaryTextColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryTextColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: primaryTextColor,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: primaryTextColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),

                      //Bio
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _bioController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                            isDense: true,
                            labelText: 'Bio',
                            prefixIconConstraints:BoxConstraints(maxHeight: 20) ,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 10, bottom: 3, left: 10),
                              child: Container(
                                  child: ImageIcon(AssetImage('assets/images/bio.png'), color: primaryTextColor,
                                    size: size.height * 0.030,)
                              ),
                            ),
                            filled: true,
                            labelStyle: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.normal,
                                color: primaryTextColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryTextColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: primaryTextColor,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: primaryTextColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _websiteController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                            isDense: true,
                            labelText: 'Website',
                            prefixIconConstraints:BoxConstraints(maxHeight: 20) ,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 10, bottom: 3, left: 10),
                              child: Container(
                                  child: Icon(Icons.web_outlined, color: primaryTextColor,
                                    size: size.height * 0.027,)
                              ),
                            ),
                            filled: true,
                            labelStyle: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.normal,
                                color: primaryTextColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryTextColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: primaryTextColor,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: primaryTextColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),

                      // Reference Code
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          scrollPadding: EdgeInsets.only(bottom: 10.0),
                          textAlignVertical: TextAlignVertical.center,
                          controller: _referenceController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                            isDense: true,
                            labelText: 'Reference Code',
                            prefixIconConstraints:BoxConstraints(maxHeight: 20) ,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 10, bottom: 3, left: 10),
                              child: Container(
                                  child: Icon(Icons.person_add_alt_sharp, color: primaryTextColor,
                                    size: size.height * 0.027,)
                              ),
                            ),
                            filled: true,
                            labelStyle: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.normal,
                                color: primaryTextColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryTextColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: primaryTextColor,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: primaryTextColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  selectFile();
                                },
                                child: _file == null ? Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      left: size.height * 0.01,
                                      right: size.height * 0.03),
                                  width: size.width * 0.6,
                                  height: size.height * 0.055,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: borderColors)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cloud_upload_outlined, color: primaryTextColor,),
                                      SizedBox(width: size.width * 0.020,),
                                      Text(
                                        'Upload Document',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.023,
                                            fontWeight: FontWeight.normal,
                                            color: primaryTextColor),
                                      ),
                                    ],
                                  ),
                                ) : Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: size.height * 0.005,
                                      left: size.height * 0.012,
                                      right: size.height * 0.03),
                                  width: size.width * 0.30,
                                  height: size.height * 0.055,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: new FileImage(_image1!),
                                        fit: BoxFit.cover
                                    ),
                                  ), /*Text(
                                    fileName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.023,
                                        fontWeight: FontWeight.normal,
                                        color: buttonTextColor),
                                  ),*/
                                ),
                              ),
                            ],
                          )
                        ],
                      ),


/*
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "Agreed to terms and condition",
                      style: TextStyle(
                          fontFamily: 'railway',
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.normal),
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
                  ),*/

                  SizedBox(
                    height: size.height * 0.020,
                  ),

                      isloading
                          ? CircularProgressIndicator(
                        backgroundColor: buttonTextColor,
                      )
                          : RoundedButton(
                        text: "SIGN IN",
                        press: () {
                          checkValidation();
                        },
                      ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen(widget.role);
                          },
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Already have an Account?",
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.normal,
                                  color: primaryTextColor),
                            ),
                            SizedBox(width: size.width * 0.015,),
                            Text(
                              "LOG IN",
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.025,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                ]),
          ]),
        )));
  }

  void checkValidation() {
    bool contactValid =
    RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(_mobileController.text);

    if (_nameController.text.isEmpty) {
      Message(context, "Enter Company Name");
    }else if (_addressController.text.isEmpty) {
      Message(context, "Enter Company Address");
    }  else if (_passwordController.text.isEmpty) {
      Message(context, "Enter Password");
    }else if (_emailController.text.isEmpty) {
      Message(context, "Enter Company Email");
    } else if (!contactValid) {
      Message(context, "Enter valid Contact Number");
    } else if (_mobileController.text.isEmpty) {
      Message(context, "Enter Contact Number");
    } else if (_bioController.text.isEmpty) {
      Message(context, "Enter Bio");
    } else if (_positionController.text.isEmpty) {
      Message(context, "Enter Position");
    } else if (_websiteController.text.isEmpty) {
      Message(context, "Enter Website");
    } else {
      Register();
    }
  }


  Future<void> Register() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('yourang.shop', '/veeboss/public/api/v1/register');
    //----------------------------------------------------------
    var request = new http.MultipartRequest("POST", url);
    request.fields['name'] = _nameController.text;
    request.fields['password'] = _passwordController.text;
    request.fields['email'] = _emailController.text;
    request.fields['contact_no'] = _mobileController.text;
    request.fields['bio'] = _bioController.text;
    request.fields['age'] = '-';
    request.fields['experience'] = "-";
    request.fields['role'] =  widget.role;
    request.fields['location'] =  _addressController.text;
    request.fields['position'] =  _positionController.text;
    request.fields['gender'] = "-";
    request.fields['website'] = _websiteController.text;

    if (_referenceController != null){
      request.fields['reference_code'] = _referenceController.text;
    }

    if(_image != null)
    {
      request.files.add(
          await http.MultipartFile.fromPath(
            'profile_image',
            _image!.path,
          ));
    }

    if(_file == null){
      Message(context, "Upload Document");
    }
    else
    {
      request.files.add(
          http.MultipartFile(
              'resume_file',
              File(_file!.path).readAsBytes().asStream(),
              File(_file!.path).lengthSync(),
              filename: _file!.path.split("/").last
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
        setState(() {
          isloading = false;
        });
        Message(context,"Something went Wrong");
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
