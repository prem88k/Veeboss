import 'package:flutter/material.dart';
import 'package:veeboss/Contants/Colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;

  const RoundedButton({
    required this.text,
    required this.press,
    this.color = buttonTextColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.85,
      decoration: BoxDecoration(
        border: Border.all(
            color: appButton, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            press();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: appBackground
              /*gradient: LinearGradient(
                  colors: [
                    Color(0xff2E4B93),
                    Color(0xff1AA5FF),
                  ]
              ),*/
            ),            child: Center(
              child: Text(
                text,
                style: TextStyle(color: appText, fontWeight: FontWeight.normal,fontFamily: "railway"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
