

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
        borderRadius: BorderRadius.circular(20),
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
            child: Text(
              title,
              style:  TextStyle(
                fontFamily: 'Calibri',
                fontSize: width * 0.05,
                color: Color(0xffffffff),
                letterSpacing: 0.18,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }