import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final color;
  final textcolor;
  final buttontext;
  final buttontapped;
  Button({this.buttontext, this.color, this.textcolor, this.buttontapped});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
          padding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  buttontext,
                  style: TextStyle(color: textcolor, fontSize: 20),
                ),
              ),
            ),
          )),
    );
  }
}
