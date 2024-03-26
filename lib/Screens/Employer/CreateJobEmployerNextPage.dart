import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../../Contants/Colors.dart';
import '../../Models/Employee/GetCategoryData.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Presentation/rounded_button.dart';
import 'package:veeboss/Screens/LoginScreen.dart';
import 'BottomNavigationBar.dart';

class CreateJobEmployerNextPage extends StatefulWidget {
  File image;
  String  title, category, vacancy, locality, gender, selectQualification, starTtime, endTime, jobBenefits, wDays, minExp, maxExp, choices, language;
  CreateJobEmployerNextPage(this.title, this.category, this.vacancy, this.locality,this.image, this.gender,
      this.choices, this.endTime, this.starTtime, this.jobBenefits, this.maxExp, this.minExp, this.selectQualification, this.wDays, this.language,);

  @override
  State<CreateJobEmployerNextPage> createState() => _CreateJobEmployerNextPageState();
}

class _CreateJobEmployerNextPageState extends State<CreateJobEmployerNextPage> {
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _salaryEndController = TextEditingController();
  final TextEditingController _jobSkillController = TextEditingController();
  final TextEditingController _otherRequirementController = TextEditingController();
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _fullInterviewAddressController = TextEditingController();
  final TextEditingController _otherShiftTimings = TextEditingController();

  bool _isSelected = false;
  String isSelected = "";
  String genderSelected = "";
  String isWorking = "";
  bool isWorkingS = false;

  bool isWorkings = false;
  bool isloading = false;
  File? _image;
  String? gender;

  var dropdownJobTitleValue;
  String selectedJobTitle = "";
  final jobListPage = [
    'Software Developer',
    'SEO Manager',
    'Web Developer',
    'Admin Executives',
    'Digital Marketing Assistant'
  ];

  var dropdownJobCatValue;
  String selectedJobCat = "";
  final jobCatPage = [
    'Android Developer',
    'SEO Execution',
    'Quality Analyst',
    'Recruitment Associate',
    'Associate Operation'
  ];

  var dropdownJobCity;
  String selectedJobCity = "";
  final jobCityPage = ['Ahmedabad', 'Mumbai', 'Benglore', 'Delhi', 'Pune'];

  var dropdownJobLocality;
  String selectedJobLocality = "";
  final jobLocalityPage = [
    '100 Feet Road',
    '1st phase of jp nagar',
    '3rd Block Banashankari',
    '5th Block Koramangla',
    '7th Stage Radha Krishna Layout'
  ];


  List<String> _jobSkills = [
    'Cold Calling',
    'Computer Knowledge',
    'Payroll Management',
    'Telent Acquisition/Sourcing',
  ];

  List<String> _selectedjobSkills = [];

  void _onjobSkills(String category) {
    setState(() {
      if (_selectedjobSkills.contains(category)) {
        _selectedjobSkills.remove(category);
      } else {
        _selectedjobSkills.add(category);
      }
      print(_selectedjobSkills);
    });
  }

  List<String>? _shiftTimings;
  int _shiftTimingsIndex = 0;

  List<String>? _communication_ctg;
  int _communication_ctgIndex = 0;

  @override
  void initState() {
    print(widget.choices);
    _shiftTimings = ["Day Shift","Rotational", "Others"];
    _communication_ctg = ["Excellent","Good", "Average"];
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        backgroundColor: appBackground,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: size.width * 0.020, top: size.height * 0.020, right: size.width * 0.020),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.0, left: 15.0, right: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // salary
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                      child: Text(
                        "In-Hand Salary :-",
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontWeight: FontWeight.normal,
                            fontSize: size.height * 0.020,
                            color: appHeader),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0,),
                          child: Container(
                            height: size.height * 0.050,
                            width: size.width * 0.3,
                            child: TextFormField(
                              controller: _salaryController,
                              scrollPadding: EdgeInsets.only(bottom: 0.0),
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.normal,
                                  color: appText),
                              decoration: InputDecoration(
                                labelText: '₹ 10,000',
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            "to",
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontWeight: FontWeight.normal,
                                fontSize: size.height * 0.015,
                                color: appText),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Container(
                            height: size.height * 0.050,
                            width: size.width * 0.3,
                            child: TextFormField(
                              controller: _salaryEndController,
                              scrollPadding: EdgeInsets.only(bottom: 0.0),
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.normal,
                                  color: appText),
                              decoration: InputDecoration(
                                labelText: '₹ 20,000',
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 0.0),
                          child: Text(
                            "per month",
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontWeight: FontWeight.normal,
                                fontSize: size.height * 0.015,
                                color: appText),
                          ),
                        ),
                      ],
                    ),

                    // shift timings
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 0.0, right: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                            child: Text(
                              "Shift Timings:-",
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontWeight: FontWeight.normal,
                                  fontSize: size.height * 0.020,
                                  color: appHeader),
                            ),
                          ),
                          Container(
                            height: size.height* 0.1,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _shiftTimings!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ChoiceChip(
                                    label: Text(_shiftTimings![index]),
                                    selected: _shiftTimingsIndex == index,
                                    selectedColor: appHeader,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _shiftTimingsIndex = selected ? index : 0;
                                        print(_shiftTimings![index]);
                                      });
                                    },
                                    backgroundColor: appBackground,
                                    side: BorderSide(color: primaryTextColor),
                                    labelStyle: TextStyle(color: _shiftTimingsIndex == index ? appBackground : appText),
                                  ),
                                );
                              },
                            ),
                          ),
                          _shiftTimingsIndex == 2 ?
                          Padding(
                            padding: EdgeInsets.only(top: 15.0, left: 0.0, right: 30.0, bottom: 15.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _otherShiftTimings,
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.normal,
                                  color: appText),
                              decoration: InputDecoration(
                                labelText: 'Other Working Days',
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
                          ) : Container(),
                        ],
                      ),
                    ),

                    // communication category
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 0.0, right: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                            child: Text(
                              "Communication Category:-",
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontWeight: FontWeight.normal,
                                  fontSize: size.height * 0.020,
                                  color: appHeader),
                            ),
                          ),
                          Container(
                            height: size.height* 0.1,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _communication_ctg!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ChoiceChip(
                                    label: Text(_communication_ctg![index]),
                                    selected: _communication_ctgIndex == index,
                                    selectedColor: appHeader,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _communication_ctgIndex = selected ? index : 0;
                                        print(_communication_ctg![index]);
                                      });
                                    },
                                    backgroundColor: appBackground,
                                    side: BorderSide(color: primaryTextColor),
                                    labelStyle: TextStyle(color: _communication_ctgIndex == index ? appBackground : appText),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),



              /*    Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      "Job Skills:-",
                      style: TextStyle(
                          fontFamily: 'railway',
                          fontWeight: FontWeight.normal,
                          fontSize: size.height * 0.020,
                          color: primaryTextColor),
                    ),
                  ),
                  Wrap(
                    spacing: 10.0,
                    children: _jobSkills
                        .map((category) => Container(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            _onjobSkills(category);
                          },
                          child: Chip(
                            padding: EdgeInsets.all(8.0),
                            label: Text(
                              category,
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontWeight: FontWeight.normal,
                                  fontSize: size.width * 0.030,
                                  color: whiteTextColor),
                            ),
                            avatar: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                _selectedjobSkills.contains(category)
                                    ? Icons.check_circle
                                    : Icons.add_circle,
                                size: size.height * 0.020,
                              ),
                            ),
                            backgroundColor:
                            _selectedjobSkills.contains(category)
                                ? primaryTextColor
                                : buttonTextColor,

                          ),
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                ],
              ),*/

              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                child: TextFormField(
                  controller: _jobSkillController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.normal,
                      color: appText),
                  decoration: InputDecoration(
                    labelText: 'Job Skills',
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

              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0, bottom: 0.0),
                child: TextFormField(
                  controller: _otherRequirementController,
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.normal,
                      color: appText),
                  decoration: InputDecoration(
                    labelText: 'Other Requirements',
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

              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                child: TextFormField(
                  controller: _clientNameController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.normal,
                      color: appText),
                  decoration: InputDecoration(
                    labelText: 'Client Name',
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

              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0, bottom: 35.0),
                child: TextFormField(
                  controller: _fullInterviewAddressController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.normal,
                      color: appText),
                  decoration: InputDecoration(
                    labelText: 'Full Interview Address',
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

              !isloading
                  ? RoundedButton(
                text: "Post",
                press: () {
                  checkValidation();
                },
              )
                  : Center(
                  child: CircularProgressIndicator(
                    backgroundColor: primaryColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void checkValidation() {
    if (_salaryController.text.isEmpty) {
      Message(context, "Enter Start Salary");
    } else if (_salaryEndController.text.isEmpty) {
      Message(context, "Enter End Salary");
    }  else if (_clientNameController.text.isEmpty) {
      Message(context, "Enter Client Name");
    } else if (_fullInterviewAddressController.text.isEmpty) {
      Message(context, "Enter Full Interview Address");
    } else {
      AddProductsApI();
    }
  }


  Future<void> AddProductsApI() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('yourang.shop', '/veeboss/public/api/v1/job/create');
    //----------------------------------------------------------
    var request = new http.MultipartRequest("POST", url);

    request.fields['role'] = "company";
    request.fields['post'] = widget.title;
    request.fields['category'] = widget.category;
    request.fields['vacancy'] = widget.vacancy;
    request.fields['city'] = "ABC";
    request.fields['state'] = "ABC";
    request.fields['location'] = widget.locality;
    request.fields['gender'] = widget.gender;
    request.fields['job_type'] = "";
    request.fields['qualification'] = widget.selectQualification;
    request.fields['minExp'] = widget.minExp;
    request.fields['maxExp'] = widget.maxExp;
    request.fields['working_days'] = widget.wDays;
    request.fields['jobSTime'] = widget.starTtime;
    request.fields['jobETime'] = widget.endTime;
    request.fields['salary'] = _salaryController.text;
    request.fields['salaryEnd'] = _salaryEndController.text;
    request.fields['shift_timing'] = widget.choices;
    request.fields['language'] = widget.language;
    request.fields['company_info'] = _clientNameController.text;
    request.fields['company_address'] = _fullInterviewAddressController.text;
    request.fields['shift'] = _shiftTimingsIndex != 2 ? _shiftTimings![_shiftTimingsIndex].toString() : _otherShiftTimings.text;
    request.fields['communication_category'] = _communication_ctg![_communication_ctgIndex].toString();

    if (_jobSkillController != null){
      request.fields['skills'] = _jobSkillController.text;
    }

    if (_otherRequirementController != null){
      request.fields['description'] = _otherRequirementController.text;
    }

    if (widget.jobBenefits != null){
      request.fields['jobbenefits'] = widget.jobBenefits;
    }

    if(widget.image.path != "")
    {
      request.files.add(
        await http.MultipartFile.fromPath(
          'job_image',
          widget.image.path,
        ),
      );
    }

    request.headers['x-session-token'] = '${prefs.getString('sessionToken')}';


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
        Message(context, " Something went Wrong");
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
    }
  }
}
