import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Presentation/common_widgets.dart';
import 'package:veeboss/Screens/HomeScreen/PersonalInfoScreen.dart';
import '../Contants/Colors.dart';
import '../Presentation/rounded_button.dart';
import 'LoginScreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';

class SignupAgentPage extends StatefulWidget {
  String role;

  SignupAgentPage(this.role);

  @override
  State<SignupAgentPage> createState() => _SignupAgentPageState();
}

class _SignupAgentPageState extends State<SignupAgentPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  bool isChecked = false;
  bool _obscureText = true;

  File? _image;
  File? _file;


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
  String fileName = '';
  File? _image1;

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

  File? _documentFile;
  Future<void> selectDocumentFile() async {
    try {
      final picker = FilePicker.platform;
      final pickedFile = await picker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      final pickedFileSource = File(pickedFile!.files.single.path!);
      fileName = pickedFileSource.path.split('/').last;
      setState(() {
        _documentFile = pickedFileSource;
      });
    } catch (error) {
      print("error: $error");
    }
  }


  final List<String> items = [
    'user',
    'agent',
    'company',
  ];
  String? selectedValue;
  String? gender;
  bool isloading = false;


  late String placeid;
  String googleApikey = "AIzaSyCkW__vI2DazIWYjIMigyxwDtc_kyCBVIo";
  GoogleMapController? mapController; //contrller for Google map
  LatLng? showLocation;
  String location = "Select Leaving from Location..";
  double? pickUpLat;
  double? pickUpLong;

  @override
  void initState() {
    print(widget.role);
    _addressController.addListener(() {
      /*_onChanged();*/
    });
    // TODO: implement initState
    super.initState();
  }

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
                        title: "Phone",
                      ),
                      TextFieldWidget(
                        controller: _ageController,
                        title: "Age",
                      ),
                      TextFieldWidget(
                        controller: _referenceController,
                        title: "Reference Code",
                      ),

                      SizedBox(
                        height: size.height * 0.005,
                      ),

                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color:  borderColors,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height*0.015),
                          child: InkWell(
                              onTap: () async {
                                var place = await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey: googleApikey,
                                    mode: Mode.overlay,
                                    types: [],
                                    strictbounds: false,
                                    components: [Component(Component.country, 'in')],
                                    //google_map_webservice package
                                    onError: (err){
                                      print(err);
                                    }
                                );
                                if(place != null){
                                  final plist = GoogleMapsPlaces(
                                    apiKey:googleApikey,
                                    apiHeaders: await GoogleApiHeaders().getHeaders(),
                                    //from google_api_headers package
                                  );
                                  placeid = place.placeId ?? "0";
                                  final detail = await plist.getDetailsByPlaceId(placeid);
                                  final geometry = detail.result.geometry!;
                                  final lat = geometry.location.lat;
                                  final lang = geometry.location.lng;
                                  setState(() {
                                    _addressController.text = place.description.toString();
                                    pickUpLat=lat;
                                    pickUpLong=lang;
                                    print(place.description);

                                    var newlatlang = LatLng(lat, lang);
                                    //move map camera to selected place with animation
                                    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                                  });
                                }
                              },
                              child:Padding(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: Text(_addressController.text.isEmpty ?
                                  "Select Location":
                                  _addressController.text,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.width * 0.035,
                                        fontWeight: FontWeight.normal,
                                        color: primaryColor),),
                                ),
                              )
                          ),
                        ),
                      ),

                      SizedBox(
                        height: size.height * 0.005,
                      ),

                  /*    TextFieldWidget(
                        controller: _bioController,
                        title: "Bio",
                      ),*/

                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: TextFormField(
                          controller: _bioController,
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 14,
                            color: appText,
                            fontFamily: 'railway',
                          ),
                          decoration: InputDecoration(
                            hintText: "Bio",
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
                            contentPadding: EdgeInsets.only(left: 20,top: 20),
                          ),
                        ),
                      ),

                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: TextFormField(
                          controller: _experienceController,
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 14,
                            color: appText,
                            fontFamily: 'railway',
                          ),
                          decoration: InputDecoration(
                            hintText: "Experience",
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
                            contentPadding: EdgeInsets.only(left: 20,top: 20),
                          ),
                        ),
                      ),

                      /*TextFieldWidget(
                        controller: _experienceController,
                        title: "Fresher / Experience",
                      ),*/

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  selectFile();
                                },
                                child: _image1 == null ? Container(
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
                                      Icon(Icons.cloud_upload_outlined, color: appText,),
                                      SizedBox(width: size.width * 0.020,),
                                      Text(
                                        'Upload Document',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.023,
                                            fontWeight: FontWeight.normal,
                                            color: appText),
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
                                  height: size.height * 0.15,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: new FileImage(_image1!),
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                    /*Text(
                                    fileName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.023,
                                        fontWeight: FontWeight.normal,
                                        color: appText),
                                  ),*/
                                ),
                              ),
                            ],
                          )
                        ],
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
                      // gender

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
                                  color: appText),
                            ),
                            SizedBox(width: size.width * 0.015,),
                            Text(
                              "LOG IN",
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.bold,
                                  color: appButton),
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
    }  else if (_ageController.text.isEmpty) {
      Message(context, "Enter Age");
    } else if (_bioController.text.isEmpty) {
      Message(context, "Enter Bio");
    }  else if (_addressController.text.isEmpty) {
      Message(context, "Enter Location");
    }else if (_image1 == null) {
      Message(context, "Upload Resume");
    } else {
      Register();
    }
  }

  Future<void> Register() async {
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
    request.fields['name'] = _nameController.text;
    request.fields['refer_code'] = generateRandomString(5);
    request.fields['password'] = _passwordController.text;
    request.fields['email'] = _emailController.text;
    request.fields['contact_no'] = _mobileController.text;
    request.fields['bio'] = _bioController.text;
    request.fields['age'] = _ageController.text;
    request.fields['experience'] = _experienceController.text;
    request.fields['role'] =  widget.role;
    request.fields['location'] =  _addressController.text;
    request.fields['position'] =  "";
    request.fields['gender'] = gender!.toLowerCase();
    request.fields['resume_file'] = "";

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

    if(_image1 == null){
      Message(context, "Upload Document");
    } else {
      request.files.add(
          await http.MultipartFile.fromPath(
              'document_file',
             _image1!.path,
             /* File(_documentFile!.path).readAsBytes().asStream(),
              File(_documentFile!.path).lengthSync(),
              filename: _documentFile!.path.split("/").last*/
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
