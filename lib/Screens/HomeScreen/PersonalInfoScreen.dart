import 'dart:io';

import 'package:flutter/material.dart';

import '../../Contants/Colors.dart';
import '../../Presentation/common_widgets.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _imagepath = '';
  final ImagePicker imgpicker = ImagePicker();
  String _imagecover = '';

  Future getImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imagepath = pickedFile.path;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking image.");
    }
  }

  Future getCover() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imagecover = pickedFile.path;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking image.");
    }
  }


  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0,
          elevation: 0,
          title: Text(
            "Personal Information",
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
        resizeToAvoidBottomInset: false,
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
                        child: Stack(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                getCover();
                              },
                              child: Container(
                                height: size.height * 0.25,
                                width: size.width * 0.8,
                                margin: const EdgeInsets.only(top: 50.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Image.file(File(_imagecover,),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Positioned(
                              top: .0,
                              left: .0,
                              right: .0,
                              child: Center(
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.black,
                                  backgroundImage: FileImage(File(_imagepath)),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        getImage();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(05),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: buttonTextColor),
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                100)
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      TextFieldWidget(
                        controller: _nameController,
                        title: "Position",
                      ),
                      TextFieldWidget(
                        controller: _passwordController,
                        title: "Your Current Location",
                      ),
                      TextFieldWidget(
                        controller: _emailController,
                        title: "About You",
                      ),
                      TextFieldWidget(
                        controller: _mobileController,
                        title: "Past Experience",
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0, top: 10.0),
                        alignment: Alignment.topLeft,
                        child: Text('Upload Resume',
                          style: TextStyle(

                          ),),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                ]),
          ),
        )
    );
  }
}
