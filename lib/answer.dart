import 'package:flutter/material.dart';


class Answer extends StatelessWidget {
  final String answerText;
  final Color answerColor;
  final void Function()? answerTap;

   Answer(
      {required this.answerText,
      required this.answerColor,
      required this.answerTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: answerTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 2.0,
            color: answerColor,
          ),
          boxShadow: [
            BoxShadow(
              color: answerColor,
              offset: const Offset(0, 3),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            answerText,
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: 17,
              color: answerColor,
            ),
            softWrap: false,
          ),
        ),
      ),
    );
  }
}
