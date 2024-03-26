import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Contants/Colors.dart';


class TextFieldWidget extends StatelessWidget {
  final String title;
  bool obs;
  final TextEditingController controller;
  Color borderColor;
  TextFieldWidget({
    required this.title,
    required this.controller,
    this.obs = false,
      this.borderColor=borderColors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: title=="Enter Mobile Number" || title=="Asiaonline password"? 7:7),
      child: TextFormField(
        maxLines:title== "About Business"|| title=="Service Issue Name" ? 5:1,
        textAlignVertical: TextAlignVertical.center,

          style: TextStyle(
            fontSize: 14,
            color: appText,
            fontFamily: 'railway',
          ),
          inputFormatters: [
            title== "Enter Mobile Number"?LengthLimitingTextInputFormatter(10):LengthLimitingTextInputFormatter(40),
        ],
        obscureText: obs,
        controller: controller,
        keyboardType: title.toLowerCase() == "email"
            ? TextInputType.emailAddress
            : title.toLowerCase() == "password"
            ? TextInputType.visiblePassword
            : title == "Enter Mobile Number" || title =="Enter OTP" || title=="Company/Business Pincode" || title=="Bank Number"?TextInputType.number: TextInputType.text,
        decoration: InputDecoration(
          filled: false,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color:  borderColor,
              width: 1.0,

            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color:  borderColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(
                color:  borderColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: title,
          counterText: '',
          hintStyle: TextStyle(
            fontSize: 14,
            color: appText,
            fontFamily: 'railway',
          ),
          contentPadding: EdgeInsets.only(left: 20,top: 20),
        ),
      ),
    );
  }
}