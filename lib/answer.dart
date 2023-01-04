import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Color answerColor;
  final void Function()? answerTap;
  bool isPaperDetails;

  Answer(
      {
        required this.isPaperDetails,
        required this.answerText,
      required this.answerColor,
      required this.answerTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: answerTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
            child: Text(
              answerText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Calibri',
                fontSize: this.isPaperDetails ? 12 : 17,
                color: this.isPaperDetails ?   Color(0xffB4B4B4) :  Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
