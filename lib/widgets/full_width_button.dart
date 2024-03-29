import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container fullWidthButton({
  required BuildContext context,
  required String title,
  required Color buttonColor,
  required Color shadowColor,
  required VoidCallback onTap,
}) {
  double width = MediaQuery.of(context).size.width;
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: buttonColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: shadowColor,
          offset: Offset(0, 3),
          blurRadius: 0,
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      // onPressed: () {
      //
      // },
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Center(
          child: AutoSizeText(
            title,
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: 18,
              color: Color(0xffffffff),
              letterSpacing: 0.18,
            ),
            maxFontSize: 20,
            minFontSize: 12,
            textAlign: TextAlign.center,
            softWrap: false,
          ),
        ),
      ),
    ),
  );
}
