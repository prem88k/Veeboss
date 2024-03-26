import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireAuth;
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veeboss/Presentation/common_widgets.dart';

import '../Contants/Colors.dart';
import 'Employee/OtpScreenRegister.dart';
import 'LoginScreen.dart';

class RegisterPage extends StatefulWidget {
  String role;

  RegisterPage(this.role);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  bool isChecked = false;
  bool _obscureText = true;

  File? _image;
  File? _file;
  String fileName = '';

  /* var uuid= new Uuid();
  String _sessionToken = new Uuid() as String;*/

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

  Future<void> selectFile() async {
    try {
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
    }
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
  late fireAuth.AuthCredential phoneAuthCredential;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String placeid;
  String googleApikey = "AIzaSyCkW__vI2DazIWYjIMigyxwDtc_kyCBVIo";
  GoogleMapController? mapController; //contrller for Google map
  LatLng? showLocation;
  String location = "Select Leaving from Location..";
  double? pickUpLat;
  double? pickUpLong;

  @override
  void initState() {
    _addressController.addListener(() {
      /*_onChanged();*/
    });
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
              color: appText, size: size.height * 0.035 //change your color here
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
                bottom: size.height * 0.040),
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
                              child: _image == null
                                  ? Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.15,
                                  width: size.height * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: buttonTextColor,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/profile.png"),
                                        fit: BoxFit.cover),
                                  ))
                                  : Container(
                                alignment: Alignment.center,
                                height: size.height * 0.15,
                                width: size.height * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: buttonTextColor,
                                  image: DecorationImage(
                                      image: new FileImage(_image!),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            )),
                      ),

                      //name
                      TextFieldWidget(
                        controller: _nameController,
                        title: "Name",
                      ),

                      TextFieldWidget(
                        controller: _mobileController,
                        title: "Mobile Number",
                      ),

                      TextFieldWidget(
                        controller: _emailController,
                        title: "Email",
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
                        controller: _ageController,
                        title: "Age",
                      ),

                      Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor: appButton,
                            disabledColor: appText),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: RadioListTile(
                                activeColor: appButton,
                                title: Text("Male",
                                    style: TextStyle(
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
                              child: RadioListTile(
                                activeColor: appButton,
                                title: Text("Female",
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.normal,
                                        color: appText)),
                                value: "Female",
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

                      TextFieldWidget(
                        controller: _referenceController,
                        title: "Reference Code",
                      ),

                      SizedBox(
                        height: size.height * 0.005,
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: size.width * 0.015,
                            right: size.width * 0.015),
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: borderColors,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.015),
                          child: InkWell(
                              onTap: () async {
                                var place = await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey: googleApikey,
                                    mode: Mode.overlay,
                                    types: [],
                                    strictbounds: false,
                                    components: [
                                      Component(Component.country, 'in')
                                    ],
                                    //google_map_webservice package
                                    onError: (err) {
                                      print(err);
                                    });
                                if (place != null) {
                                  final plist = GoogleMapsPlaces(
                                    apiKey: googleApikey,
                                    apiHeaders:
                                    await GoogleApiHeaders().getHeaders(),
                                    //from google_api_headers package
                                  );
                                  placeid = place.placeId ?? "0";
                                  final detail =
                                  await plist.getDetailsByPlaceId(placeid);
                                  final geometry = detail.result.geometry!;
                                  final lat = geometry.location.lat;
                                  final lang = geometry.location.lng;
                                  setState(() {
                                    _addressController.text =
                                        place.description.toString();
                                    pickUpLat = lat;
                                    pickUpLong = lang;
                                    print(place.description);

                                    var newlatlang = LatLng(lat, lang);
                                    //move map camera to selected place with animation
                                    mapController?.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                target: newlatlang, zoom: 17)));
                                  });
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: Text(
                                    _addressController.text.isEmpty
                                        ? "Select Location"
                                        : _addressController.text,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.width * 0.035,
                                        fontWeight: FontWeight.normal,
                                        color: primaryColor),
                                  ),
                                ),
                              )),
                        ),
                      ),

                      SizedBox(
                        height: size.height * 0.005,
                      ),

                      /*   TextFieldWidget(
                        controller: _bioController,
                        title: "Bio",
                      ),
*/

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
                            contentPadding: EdgeInsets.only(left: 20, top: 20),
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
                            hintText: "Fresher / Experience",
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
                            contentPadding: EdgeInsets.only(left: 20, top: 20),
                          ),
                        ),
                      ),

                      /* TextFieldWidget(
                        controller: _experienceController,
                        title: "Fresher / Experience",
                      ),*/

                      //email
                      //mobile number
                      //age
                      // Reference Code
                      //Location
                      //position
                      //Bio
                      //experience
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
                                child: _file == null
                                    ? Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      left: size.height * 0.01,
                                      right: size.height * 0.03),
                                  width: size.width * 0.6,
                                  height: size.height * 0.055,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      border: Border.all(
                                          color: borderColors)),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cloud_upload_outlined,
                                        color: appText,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.020,
                                      ),
                                      Text(
                                        'Upload Resume',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.023,
                                            fontWeight: FontWeight.normal,
                                            color: appText),
                                      ),
                                    ],
                                  ),
                                )
                                    : Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: size.height * 0.005,
                                      left: size.height * 0.012,
                                      right: size.height * 0.03),
                                  width: size.width * 0.30,
                                  height: size.height * 0.055,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    fileName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.023,
                                        fontWeight: FontWeight.normal,
                                        color: buttonTextColor),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                      // gender
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.015,
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
                    height: size.height * 0.030,
                  ),
                  isloading
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: buttonTextColor,
                      ),
                    ],
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
                                color: appButton),
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
                            SizedBox(
                              width: size.width * 0.015,
                            ),
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
    } else if (_emailController.text.isEmpty) {
      Message(context, "Enter Email");
    } else if (!contactValid) {
      Message(context, "Enter valid Contact Number");
    } else if (_mobileController.text.isEmpty) {
      Message(context, "Enter Contact Number");
    } else if (_ageController.text.isEmpty) {
      Message(context, "Enter Age");
    } else if (_bioController.text.isEmpty) {
      Message(context, "Enter Bio");
    } else if (_experienceController.text.isEmpty) {
      Message(context, "Enter Experience");
    } else if (_addressController.text.isEmpty) {
      Message(context, "Enter Location");
    } else if (_file == null) {
      Message(context, "Upload Resume");
    } else if (_image == null) {
      Message(context, "Upload Profile Image");
    } else if (!isChecked) {
      Message(context, "Accept Terms & Condition");
    } else {
      SubmitOtp();
    }
  }

  Future<void> SubmitOtp() async {
    setState(() {
      isloading = true;
    });

    /// NOTE: Either append your phone number country code or add in the code itself
    /// Since I'm in India we use "+91 " as prefix `phoneNumber`
    String phoneNumber = "+91 " + _mobileController.text.toString().trim();
    print(phoneNumber);

    /// The below functions are the callbacks, separated so as to make code more readable
    void verificationCompleted(fireAuth.AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      this.phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
    }

    void verificationFailed(fireAuth.FirebaseAuthException error) {
      print(error);
    }

    void codeSent(String verificationId, [int? code]) {
      print('codeSent');
      setState(() {
        isloading = false;
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OtpScreenRegister(
                  _mobileController.text,
                  verificationId,
                  _passwordController.text,
                  _nameController.text,
                  _emailController.text,
                  _bioController.text,
                  _ageController.text,
                  _experienceController.text,
                  widget.role,
                  _addressController.text,
                  gender!,
                  _referenceController.text,
                  _image,
                  _file
              );
            },
          ),
        );
      });
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
    }

    await _auth.verifyPhoneNumber(
      /// Make sure to prefix with your country code
      phoneNumber: phoneNumber,

      /// `seconds` didn't work. The underlying implementation code only reads in `milliseconds`
      timeout: Duration(milliseconds: 10000),

      /// If the SIM (with phoneNumber) is in the current device this function is called.
      /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
      verificationCompleted: verificationCompleted,

      /// Called when the verification is failed
      verificationFailed: verificationFailed,

      /// This is called after the OTP is sent. Gives a `verificationId` and `code`
      codeSent: codeSent,

      /// After automatic code retrival `tmeout` this function is called
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
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
                  Icon(
                    Icons.camera,
                    color: whiteTextColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Camera",
                    style: TextStyle(
                      fontFamily: 'railway',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
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
                  Icon(
                    Icons.picture_in_picture,
                    color: whiteTextColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Gallery ",
                    style: TextStyle(
                      fontFamily: 'railway',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
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
/*_onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "CHANGE THIS WITH YOUR GOOGLE API KEY";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(request);
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }*/
}
