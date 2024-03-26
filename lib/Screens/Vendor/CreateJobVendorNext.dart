import 'package:flutter/material.dart';
import 'package:veeboss/Screens/Vendor/CreateJobVendorNextPage.dart';
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



class CreateJobVendorNext extends StatefulWidget {

  File image;
  String title, category, vacancy, locality, gender;
  CreateJobVendorNext(this.image,this.title, this.category, this.vacancy, this.locality, this.gender,);

  @override
  State<CreateJobVendorNext> createState() => _CreateJobVendorNextState();
}

class _CreateJobVendorNextState extends State<CreateJobVendorNext> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final TextEditingController _otherWorkingDays = TextEditingController();
  final TextEditingController _otherQualification = TextEditingController();
  final TextEditingController _otherWorkingHours = TextEditingController();
  final TextEditingController _otherSelectLanguage = TextEditingController();
  final TextEditingController _otherJobBenefits = TextEditingController();

  var dropdownMinExpValue;
  String selectedMinExp = "";
  final minExpList = [
    '0 month',
    '6 month',
    '1 year',
    '2 year',
    '3 year',
    '4 year',
    '5 year',
    '6 year+',
  ];

  var dropdownMaxExpValue;
  String selectedMaxExp = "";
  final maxExpList = [
    '6 month',
    '1 year',
    '2 year',
    '3 year',
    '4 year',
    '5 year',
    '6 year+',
  ];



  List<String> _jobBenefits = [
    'Cab',
    'Meal',
    'Insurance',
    'Medical Benefits',
    'PF',
    'Other'
  ];

  List<String> _selectedjobBenefits = [];

  void _onjobBenefits(String category) {
    print(category);
    setState(() {
      if (_selectedjobBenefits.contains(category)) {
        _selectedjobBenefits.remove(category);
      } else {
        _selectedjobBenefits.add(category);
      }
    });
  }

  List<String> _language = [
    'English',
    'Hindi',
    'Marathi',
    'Bengali',
    'Punjabi',
    'Gujarati',
    'Malayalam',
    'Tamil',
    'Kannada',
    'Telugu',
    'Other'
  ];

  List<String> _selectedLanguage = [];

  void _onJobLanguage(String category) {
    print(category);
    setState(() {
      if (_selectedLanguage.contains(category)) {
        _selectedLanguage.remove(category);
      } else {
        _selectedLanguage.add(category);
      }
    });
  }

  List<String> _qualification = [
    '10th Pass', '12th Pass', '10 + 12 Pass',  'Diploma',
    'Graduate', 'Post Graduate' , 'Any Other Graduate'
  ];

  List<String> _selectedQualification = [];

  void _onJobQualification(String category) {
    setState(() {
      if (_selectedQualification.contains(category)) {
        _selectedQualification.remove(category);
      } else {
        _selectedQualification.add(category);
      }
    });
  }


  List<String>? _choices;
  int _choiceIndex = 0;

  List<String>? _wHours;
  int _wHoursIndex = 0;

  List<String>? _candidatesSelect;
  int __candidatesSelectIndex = 0;



  String? _selectedStartTime;
  String? _selectedEndTime;

  @override
  void initState() {
    _choices = ["5 days working","6 days working", "Other"];
    _candidatesSelect  = ["Understands basic English","Understands good English", "Understand & Speaks Good English"];
    _wHours = ["Full Time","Part Time","Work Form Home", "Other"];
    super.initState();
  }



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
          padding:  EdgeInsets.only(left: size.width * 0.020, top: size.height * 0.020),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //job type
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 0.0),
                      child: Text(
                        "Job Type :-",
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
                        itemCount: _wHours!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ChoiceChip(
                              label: Text(_wHours![index]),
                              selected: _wHoursIndex == index,
                              selectedColor: appHeader,
                              onSelected: (bool selected) {
                                setState(() {
                                  _wHoursIndex = selected ? index : 0;
                                  print(_wHours![index]);
                                });
                              },
                              backgroundColor: appBackground,
                              side: BorderSide(color: primaryTextColor),
                              labelStyle: TextStyle(color: _wHoursIndex == index ? appBackground : appText),
                            ),
                          );
                        },
                      ),
                    ),
                    _wHoursIndex == 3 ?
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 0.0, right: 30.0, bottom: 15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _otherWorkingHours,
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

              // min qualification
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                      child: Text(
                        "Required Education / Education Level :-",
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontWeight: FontWeight.normal,
                            fontSize: size.height * 0.020,
                            color: appHeader),
                      ),
                    ),

                    Wrap(
                      spacing: 10.0,
                      children: _qualification
                          .map((category) => Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              _onJobQualification(category);
                            },
                            child: Chip(
                              padding: EdgeInsets.all(8.0),
                              label: Text(
                                category,
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontWeight: FontWeight.normal,
                                    fontSize: size.width * 0.035,
                                    color: _selectedQualification.contains(category)
                                        ? appBackground
                                        : appText ),
                              ),
                              avatar: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  _selectedQualification.contains(category)
                                      ? Icons.check_circle
                                      : Icons.add_circle,
                                  size: size.height * 0.020,
                                  color: _selectedQualification.contains(category)
                                      ? appBackground
                                      : appButton ,
                                ),
                              ),
                              side: BorderSide(color: _selectedQualification.contains(category)
                                  ? appButton
                                  : appText, ),
                              backgroundColor:
                              _selectedQualification.contains(category)
                                  ? appButton
                                  : appBackground,


                            ),
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                    _selectedQualification.contains('Any Other Graduate') ?
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 0.0, right: 30.0, bottom: 15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _otherQualification,
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.normal,
                            color: appText),
                        decoration: InputDecoration(
                          labelText: 'Required Education / Education Level',
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

                   /* Container(
                     // width: size.width * 0.8,
                      height: size.height* 0.1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                       *//* primary: false,
                        shrinkWrap: true,*//*
                        itemCount: _qualification!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ChoiceChip(
                              label: Text(_qualification![index]),
                              selected: __qualificationIndex == index,
                              selectedColor: appHeader,
                              onSelected: (bool selected) {
                                setState(() {
                                  __qualificationIndex = selected ? index : 0;
                                  print(_qualification![index]);
                                });
                              },
                              backgroundColor: appBackground,
                              side: BorderSide(color: primaryTextColor),
                              labelStyle: TextStyle(color: __qualificationIndex == index ? appBackground : appText),
                            ),
                          );
                        },
                      ),
                    ),
                    __qualificationIndex == 6 ?
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 0.0, right: 30.0, bottom: 15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _otherQualification,
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.normal,
                            color: appText),
                        decoration: InputDecoration(
                          labelText: 'Required Education / Education Level',
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
                    ) : Container(),*/
                  ],
                ),
              ),

              // required experoience
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        "Required Experience :-",
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
                        Container(
                          padding: EdgeInsets.only(
                            left: size.width * 0.02,
                            right: size.width * 0.02,
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
                          width: size.width * 0.35,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              style: TextStyle(
                                color: appText,
                              ),
                              dropdownColor: appBackground,
                              isExpanded: true,
                              value: dropdownMinExpValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownMinExpValue = newValue;
                                  print("GateId::$newValue");
                                  selectedMinExp = newValue!;
                                });
                              },
                              hint: Row(
                                children: [
                                  Text(
                                    "Min Exp.",
                                    style: TextStyle(
                                        color: appText,
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              icon: Icon(
                                // Add this
                                Icons.arrow_drop_down, // Add this
                                color: appText, // Add this
                              ),
                              items: minExpList.map(( value) {
                                return DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        value,
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
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            "to",
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontWeight: FontWeight.normal,
                                fontSize: size.height * 0.015,
                                color: appText),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: size.width * 0.02,
                            right: size.width * 0.02,
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
                          width: size.width * 0.35,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              style: TextStyle(
                                color: appText,
                              ),
                              dropdownColor: appBackground,
                              isExpanded: true,
                              value: dropdownMaxExpValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownMaxExpValue = newValue;
                                  print("GateId::$newValue");
                                  selectedMaxExp = newValue!;
                                });
                              },
                              hint: Row(
                                children: [
                                  Text(
                                    "Max Exp.",
                                    style: TextStyle(
                                        color: appText,
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              icon: Icon(
                                // Add this
                                Icons.arrow_drop_down, // Add this
                                color: appText, // Add this
                              ),
                              items: maxExpList.map(( value) {
                                return DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        value,
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
                    )
                  ],
                ),
              ),

              //job benefits
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        "Job Benefits:-",
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontWeight: FontWeight.normal,
                            fontSize: size.height * 0.020,
                            color: appHeader),
                      ),
                    ),
                    Wrap(
                      spacing: 10.0,
                      children: _jobBenefits
                          .map((category) => Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              _onjobBenefits(category);
                            },
                            child: Chip(
                              padding: EdgeInsets.all(8.0),
                              label: Text(
                                category,
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontWeight: FontWeight.normal,
                                    fontSize: size.width * 0.035,
                                    color:  _selectedjobBenefits.contains(category)
                                        ? appBackground
                                        : appText ),
                              ),
                              avatar: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  _selectedjobBenefits.contains(category)
                                      ? Icons.check_circle
                                      : Icons.add_circle,
                                  size: size.height * 0.020,
                                  color: _selectedjobBenefits.contains(category)
                                      ? appBackground
                                      : appButton ,
                                ),
                              ),
                              side: BorderSide(color: _selectedjobBenefits.contains(category)
                                  ? appButton
                                  : appText, ),
                              backgroundColor:
                              _selectedjobBenefits.contains(category)
                                  ? appButton
                                  : appBackground,

                            ),
                          ),
                        ),
                      ))
                          .toList(),
                    ),

                    _selectedjobBenefits.contains('Other') ?
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 0.0, right: 30.0, bottom: 15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _otherJobBenefits,
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.normal,
                            color: appText),
                        decoration: InputDecoration(
                          labelText: 'Other Job Benefits',
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

              // Required language
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        "Required Language:-",
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontWeight: FontWeight.normal,
                            fontSize: size.height * 0.020,
                            color: appHeader),
                      ),
                    ),
                    Wrap(
                      spacing: 10.0,
                      children: _language
                          .map((category) => Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              _onJobLanguage(category);
                            },
                            child: Chip(
                              padding: EdgeInsets.all(8.0),
                              label: Text(
                                category,
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    fontWeight: FontWeight.normal,
                                    fontSize: size.width * 0.035,
                                    color: _selectedLanguage.contains(category)
                                        ? appBackground
                                        : appText ),
                              ),
                              avatar: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  _selectedLanguage.contains(category)
                                      ? Icons.check_circle
                                      : Icons.add_circle,
                                  size: size.height * 0.020,
                                  color: _selectedLanguage.contains(category)
                                      ? appBackground
                                      : appButton ,
                                ),
                              ),
                              side: BorderSide(color: _selectedLanguage.contains(category)
                                  ? appButton
                                  : appText, ),
                              backgroundColor:
                              _selectedLanguage.contains(category)
                                  ? appButton
                                  : appBackground,
                            ),
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                    _selectedLanguage.contains('Other') ?
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 0.0, right: 30.0, bottom: 15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _otherSelectLanguage,
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.normal,
                            color: appText),
                        decoration: InputDecoration(
                          labelText: 'Other Qualification',
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

              // want a candidate with good english

              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                      child: Text(
                        "Want candidates with good english?",
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
                        itemCount: _candidatesSelect!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: ChoiceChip(
                              label: Text(_candidatesSelect![index]),
                              selected: __candidatesSelectIndex == index,
                              selectedColor: appHeader,
                              onSelected: (bool selected) {
                                setState(() {
                                  __candidatesSelectIndex = selected ? index : 0;
                                  print(_candidatesSelect![index]);
                                });
                              },
                              backgroundColor: appBackground,
                              side: BorderSide(color: primaryTextColor),
                              labelStyle: TextStyle(color: __candidatesSelectIndex == index ? appBackground : appText),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              //working days
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                      child: Text(
                        "Working days:-",
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
                        itemCount: _choices!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ChoiceChip(
                              label: Text(_choices![index]),
                              selected: _choiceIndex == index,
                              selectedColor: appHeader,
                              onSelected: (bool selected) {
                                setState(() {
                                  _choiceIndex = selected ? index : 0;
                                  print(_choices![index]);
                                });
                              },
                              backgroundColor: appBackground,
                              side: BorderSide(color: primaryTextColor),
                              labelStyle: TextStyle(color: _choiceIndex == index ? appBackground : appText),
                            ),
                          );
                        },
                      ),
                    ),
                    _choiceIndex == 2 ?
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 0.0, right: 30.0, bottom: 15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _otherWorkingDays,
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

              //job timings
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0, bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
                      child: Text(
                        "Job Timings:-",
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
                          padding: EdgeInsets.only(top: 5),
                          child: GestureDetector(
                            onTap: () async {
                              displayTimePicker(context);
                            },
                            child: Container(
                              height: size.height * 0.060,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: primaryTextColor)
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text( _selectedStartTime != null ?
                                    _selectedStartTime!
                                        :"09:00 AM",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.width * 0.040,
                                          fontWeight: FontWeight.normal,
                                          color: appText),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(Icons.watch_later_outlined, color: appText, size: size.height * 0.025,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
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
                          padding: EdgeInsets.only(top: 5),
                          child: GestureDetector(
                            onTap: () async {
                              displayEndTimePicker(context);
                            },
                            child: Container(
                              height: size.height * 0.060,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: primaryTextColor)
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text( _selectedEndTime != null ?
                                    _selectedEndTime!
                                        :"10:00 PM",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.width * 0.040,
                                          fontWeight: FontWeight.normal,
                                          color: appText),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(Icons.watch_later_outlined, color: appText, size: size.height * 0.025,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                          border: Border.all(color: appButton)
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
          ),
        ),
      ),
    );
  }

  void checkValidation() {
    if (selectedMaxExp.isEmpty) {
      Message(context, "Select Job Maximum Experience");
    } else if (selectedMinExp.isEmpty) {
      Message(context, "Select Job Minimum Experience");
    } else if (_selectedLanguage.isEmpty) {
      Message(context, "Select Job Language");
    }else if (_selectedEndTime == null) {
      Message(context, "Select Job End Time");
    } else if (_selectedStartTime == null) {
      Message(context, "Select Job Start Time");
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) {
                return CreateJobVendorNextPage(widget.title,widget.category, widget.vacancy, widget.locality, widget.image, widget.gender,
                    _choiceIndex != 2 ? _choices![_choiceIndex].toString() : _otherWorkingDays.text , _selectedEndTime.toString(),  _selectedStartTime.toString(),
                    _otherJobBenefits.text.isNotEmpty ? _otherJobBenefits.text :_selectedjobBenefits.toString(), selectedMaxExp, selectedMinExp,
                    _otherQualification.text.isNotEmpty ?  _otherQualification.text : _selectedQualification.toString(),
                    _wHoursIndex != 3 ? _wHours![_wHoursIndex].toString() : _otherWorkingHours.text,
                    _otherSelectLanguage.text.isNotEmpty ? _otherSelectLanguage.text :_selectedLanguage.toString()
                );
              }
          )
      );
    }
  }

  Future displayTimePicker(BuildContext context) async {
    final TimeOfDay? result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedStartTime = result.format(context);
      });
    }
  }
  Future displayEndTimePicker(BuildContext context) async {

    final TimeOfDay? result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedEndTime = result.format(context);
      });
    }
  }
}
