import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:veeboss/Models/Agent/GetCity.dart';
import 'package:veeboss/Screens/Employer/CreateJobEmployerNext.dart';
import 'package:veeboss/Screens/agent/AgentHomePage.dart';
import 'package:veeboss/Screens/agent/CreateJobAgentNextPage.dart';
import '../../Contants/Colors.dart';
import '../../Models/Agent/GetArea.dart';
import '../../Models/Employee/GetCategoryData.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Presentation/rounded_button.dart';
import 'package:veeboss/Screens/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'BottomNavigationBar.dart';


class CreateJobEmployer extends StatefulWidget {
  const CreateJobEmployer({Key? key}) : super(key: key);

  @override
  State<CreateJobEmployer> createState() => _CreateJobEmployerState();
}

class _CreateJobEmployerState extends State<CreateJobEmployer> {
  File? _image;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noOfVacancyController = TextEditingController();
  final TextEditingController _chooseCityController = TextEditingController();
  final TextEditingController selectedArea = TextEditingController();

  late GetCategoryData getCategoryData;
  List<CategoryList> categoryList = [];
  String selectedCategory = "";
  var dropdownCategoryValue;
  bool isloading = false;


  List<String>? _gender;
  int _genderIndex = 0;


  late GetCityData getCityData;
  List<CityList> cityList = [];
  String selectedCity = "";
  var dropdownCityValue;

  /* late GetAreaData getAreaData;
  List<AreaList> areaList = [];
  String selectedArea = "";
  var dropdownareaValue;*/


  late String placeid;
  String googleApikey = "AIzaSyCkW__vI2DazIWYjIMigyxwDtc_kyCBVIo";
  GoogleMapController? mapController; //contrller for Google map
  LatLng? showLocation;
  String location = "Select Leaving from Location..";
  double? pickUpLat;
  double? pickUpLong;

  @override
  void initState() {
    selectedArea.addListener(() {
      /*_onChanged();*/
    });
    getCategoryD();
    getCity();
    _gender = ["Any","Male","Female",];
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackground,
      key: _scaffoldKey,
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: borderColors, width: 0.5)),
        elevation: 1,
        iconTheme: IconThemeData(
            color: appText,
            size: size.height * 0.035 //change your color here
        ),
        centerTitle: true,
        backgroundColor: appBackground,
        title: Text(
          "Create Job",
          style: TextStyle(
              fontFamily: 'railway',
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.025,
              color: appText),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                margin: EdgeInsets.only(left: size.width * 0.1, top: size.height * 0.050),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Attachment (optional) \n(Maximum Size is 10 MB)",
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            color: appText,
                            fontFamily: 'railway',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        getImage1();
                      },
                      child: _image == null
                          ? Container(
                          width: size.height * 0.09,
                          height: size.height * 0.09,
                          child: Icon(
                            Icons.image_outlined,
                            color: appText,
                            size: size.height * 0.1,
                          ))
                          : Container(
                        width: size.height * 0.13,
                        height: size.height * 0.13,
                        decoration: BoxDecoration(
                          color: buttonTextColor,
                          image: DecorationImage(
                              image: new FileImage(_image!),
                              fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.035,
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.050),
                child: Text(
                  "Minimum single original Photo but it's not necessary:Job Card, Social Media Post etc.",
                  style: TextStyle(
                    fontSize: size.height * 0.015,
                    color: appText,
                    fontFamily: 'railway',
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.035,
              ),

              //job title
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _titleController,
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.normal,
                      color: appText),
                  decoration: InputDecoration(
                    labelText: 'Job Title',
                    labelStyle: TextStyle(
                        fontFamily: 'railway',
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.normal,
                        color: appText),
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

              //job category
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0,right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: size.width * 0.025,
                        right: size.width * 0.05,
                      ),
                      margin: EdgeInsets.only(left: size.width * 0.002),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: primaryTextColor,
                          width: 1.0,
                        ),
                      ),
                      height: size.height * 0.075,
                      width: size.width * 0.92,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          iconSize: 30,
                          style: TextStyle(
                            color: appText,
                          ),
                          dropdownColor: appBackground,
                          isExpanded: true,
                          value: dropdownCategoryValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownCategoryValue = newValue;
                              print("GateId::$newValue");
                              selectedCategory = newValue!;
                            });
                          },
                          hint: Row(
                            children: [
                              Text(
                                "Select Category",
                                style: TextStyle(
                                    color: appText,
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.018,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          icon: Icon(
                            // Add this
                            Icons.arrow_drop_down, // Add this
                            color: appText, // Add this
                          ),
                          items: categoryList.map((CategoryList value) {
                            return DropdownMenuItem<String>(
                              value: value.id.toString(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    value.name!,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        color: appText,
                                        fontSize: size.height * 0.018,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //number of vacancy
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _noOfVacancyController,
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.normal,
                      color: appText),
                  decoration: InputDecoration(
                    labelText: 'Number of Openings',
                    labelStyle: TextStyle(
                        fontFamily: 'railway',
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.normal,
                        color: appText),
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

              //choose city
              /*Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0,right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: size.width * 0.025,
                        right: size.width * 0.05,
                      ),
                      margin: EdgeInsets.only(left: size.width * 0.002),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: primaryTextColor,
                          width: 1.0,
                        ),
                      ),
                      height: size.height * 0.075,
                      width: size.width * 0.92,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          iconSize: 30,
                          style: TextStyle(
                            color: appText,
                          ),
                          dropdownColor: appBackground,
                          isExpanded: true,
                          value: dropdownCityValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownCityValue = newValue;
                              print("City::$newValue");
                              selectedCity = newValue!;
                            });
                            *//*  getArea(selectedCity);*//*
                          },
                          hint: Row(
                            children: [
                              Text(
                                "Select City",
                                style: TextStyle(
                                    color: appText,
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.018,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          icon: Icon(
                            // Add this
                            Icons.arrow_drop_down, // Add this
                            color: appText, // Add this
                          ),
                          items: cityList.map((CityList value) {
                            return DropdownMenuItem<String>(
                              value: value.id.toString(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    value.brandName!,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        color: appText,
                                        fontSize: size.height * 0.018,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/

              //job localityt
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0,right: 15.0),
                child: Container(
                  padding: EdgeInsets.only(
                    left: size.width * 0.025,
                    right: size.width * 0.05,
                  ),
                  margin: EdgeInsets.only(left: size.width * 0.002),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: primaryTextColor,
                      width: 1.0,
                    ),
                  ),
                  height: size.height * 0.075,
                  width: size.width * 0.92,
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height*0.020),
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
                              selectedArea.text = place.description.toString();
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
                            height: size.height * 0.075,
                            width: size.width * 0.92,
                            child: Text(selectedArea.text.isEmpty ?
                            "Select Location":
                            selectedArea.text,
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
              ),
              /*  Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0,right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: size.width * 0.025,
                        right: size.width * 0.05,
                      ),
                      margin: EdgeInsets.only(left: size.width * 0.002),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: primaryTextColor,
                          width: 1.0,
                        ),
                      ),
                      height: size.height * 0.075,
                      width: size.width * 0.92,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          iconSize: 30,
                          style: TextStyle(
                            color: appText,
                          ),
                          dropdownColor: appBackground,
                          isExpanded: true,
                          value: dropdownareaValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownareaValue = newValue;
                              print("Area::$newValue");
                              selectedArea = newValue!;
                            });
                          },
                          hint: Row(
                            children: [
                              Text(
                                "Select Area",
                                style: TextStyle(
                                    color: appText,
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.018,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          icon: Icon(
                            // Add this
                            Icons.arrow_drop_down, // Add this
                            color: appText, // Add this
                          ),
                          items: areaList.map((AreaList value) {
                            return DropdownMenuItem<String>(
                              value: value.area.toString(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    value.area!,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        color: appText,
                                        fontSize: size.height * 0.018,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/

              //gender
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender :-",
                      style: TextStyle(
                          fontFamily: 'railway',
                          fontWeight: FontWeight.normal,
                          fontSize: size.height * 0.020,
                          color: appHeader),
                    ),
                    Container(
                      height: size.height* 0.1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _gender!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child:ChoiceChip(
                                label: Text(_gender![index]),
                                selected: _genderIndex == index,
                                selectedColor: appHeader,
                                onSelected: (bool selected) {
                                  setState(() {
                                    _genderIndex = selected ? index : 0;
                                    print(_gender![index]);
                                  });
                                },
                                backgroundColor: appBackground,
                                side: BorderSide(color: primaryTextColor),
                                labelStyle: TextStyle(color: _genderIndex == index ? appBackground : appText),
                              )
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  checkValidation();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0, bottom: 35.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: size.height * 0.060,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: appHeader,
                          border: Border.all(color: appHeader)
                      ),
                      child: Center(child: Text("Next",
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontWeight: FontWeight.normal,
                            fontSize: size.height * 0.020,
                            color: whiteTextColor),
                      )),
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  void checkValidation() {
    if (_titleController.text.isEmpty) {
      Message(context, "Enter Job Title");
    } else if (_noOfVacancyController.text.isEmpty) {
      Message(context, "Enter Number of Openings");
    } else if (selectedCategory.isEmpty) {
      Message(context, "Select Job Category");
    }/* else if (selectedCity.isEmpty) {
      Message(context, "Select Job City");
    } */ else if (selectedArea.text.isEmpty) {
      Message(context, "Select Job Area");
    }  else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CreateJobEmployerNext(_image!=null ? _image! : File(""), _titleController.text,
                selectedCategory ,_noOfVacancyController.text, selectedArea.text,
                _gender![_genderIndex].toString());
          },
        ),
      );
    }
  }

  Future<void> getCategoryD() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {'x-session-token': prefs.getString('sessionToken')!};

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/category',
    );
    final encoding = Encoding.getByName('utf-8');

    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("getCategoryImages::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;

      setState(() {
        isloading = false;
        getCategoryData = GetCategoryData.fromJson(jsonDecode(responseBody));
        categoryList.addAll(getCategoryData.data!);
      });
    }
  }

  Future<void> getCity() async {
    cityList.clear();
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {'x-session-token': prefs.getString('sessionToken')!};

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/getcities',
    );
    final encoding = Encoding.getByName('utf-8');

    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("getCity::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;

      setState(() {
        isloading = false;
        getCityData = GetCityData.fromJson(jsonDecode(responseBody));
        cityList.addAll(getCityData.data!);
      });
    }
  }

  /*Future<void> getArea(String id) async {
    areaList.clear();
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {'x-session-token': prefs.getString('sessionToken')!};

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/getarea/${id}',
    );
    final encoding = Encoding.getByName('utf-8');

    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("getCity::$responseBody");
    if (statusCode == 200) {
      if (!mounted) return;

      setState(() {
        isloading = false;
        getAreaData = GetAreaData.fromJson(jsonDecode(responseBody));
        areaList.addAll(getAreaData.data!);
      });
    }
  }*/

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
                      fontFamily: 'Opensans',
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
                      fontFamily: 'Opensans',
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
      Message(context, "Select Image");
    }
  }

 /* Future<void> AddJobApi() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('yourang.shop', '/veeboss/public/api/v1/job/create');
    //----------------------------------------------------------
    var request = new http.MultipartRequest("POST", url);

    request.headers['x-session-token'] = '${prefs.getString('sessionToken')}';
    print('${prefs.getString('sessionToken')}');

    request.fields['role'] = "company";
    request.fields['post'] = _titleController.text;
    request.fields['description'] = _desriptionController.text;
    request.fields['vacancy'] = _noVacancyController.text;
    request.fields['city'] = "ABC";
    request.fields['company_info'] = _companyInfoController.text;
    request.fields['category'] = selectedCategory;
    request.fields['state'] = "ABC";
    request.fields['gender'] = "";
    request.fields['job_type'] = "";
    request.fields['qualification'] = "";
    request.fields['minExp'] ="";
    request.fields['maxExp'] = "";
    request.fields['working_days'] = "";
    request.fields['jobSTime'] = "";
    request.fields['jobETime'] = "";
    request.fields['salary'] = "";
    request.fields['salaryEnd'] = "";
    request.fields['shift_timing'] = "";
    request.fields['language'] = "";
    request.fields['company_address'] = "";
    request.fields['shift'] = "";
    request.fields['communication_category'] = "";
    request.fields['skills'] = "ABC";
    request.fields['jobbenefits'] = "";

    if(_image != null)
    {
      request.files.add(
        await http.MultipartFile.fromPath(
          'job_image',
          _image!.path,
        ),
      );
    }

    request.send().then((response) {
      if (response.statusCode == 200) {
        print("Uploaded!");
        int statusCode = response.statusCode;
        response.stream.transform(utf8.decoder).listen((value) {
          print("ResponseSellerVerification" + value);
          setState(() {
            isloading = false;
          });

          Message(context, "Post Added Successfully");
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return bottomNavigationBarEmployer();
                },
              ),
            );
          });
        });
      } else {
        setState(() {
          isloading = false;
        });
        Message(context, "response::$response");
        print("response::$response");
      }
    });
  }*/

}
