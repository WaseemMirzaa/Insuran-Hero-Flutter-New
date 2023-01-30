import 'package:flutter/material.dart';
import 'package:insurancehero/constants/routes.dart';
import 'package:insurancehero/ui/bottom_nav.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'answer.dart';
import 'constants/gaps.dart';
import 'models/question_model.dart';


class PaperDetails extends StatefulWidget {
  List<dynamic> questions;
   PaperDetails({Key? key,required this.questions}) : super(key: key);

  @override
  State<PaperDetails> createState() => _PaperDetailsState();
}

class _PaperDetailsState extends State<PaperDetails> {
  String correctAns = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Quiz Details',
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: 18,
              color: Color(0xff000000),
            ),
            textAlign: TextAlign.center,
            softWrap: false,
          ),
          leading: IconButton(
            onPressed: () {
              pushNewScreen(context, screen: HomeView(), withNavBar: false);
            },
            icon: Image.asset(
              'assets/images/back-arrow.png',
              scale: 3,
            ),
          ),
          elevation: 1.5,
        ),
      body: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: widget.questions.length,
          itemBuilder: (c,i){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (i+1).toString()+") " + widget.questions[i]["question"],
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontFamily: 'Calibri',
                      fontSize: 16,
                      color: Color(0xff000000),
                      letterSpacing: 0.25,
                      fontWeight: FontWeight.normal),
                  softWrap: true,
                ),
                widget.questions[i]["hint"] != null ?
                Text("Hint : ${widget.questions[i]["hint"]}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'Calibri',
                      fontSize: 12,
                      color: Color(0xffB4B4B4),
                      letterSpacing: 0.25,
                      fontWeight: FontWeight.w500
                  ),) : Container(),
                verticalGap(10),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: ((context, index) {
                      List<String> answers = [];
                      answers.add(widget.questions[i]["A"] ?? "");
                      answers.add(widget.questions[i]["B"] ?? "");
                      answers.add(widget.questions[i]["C"] ?? "");
                      answers.add(widget.questions[i]["D"] ?? "");

                      correctAns =  widget.questions[i]["correctAns"] ?? "" ?? "";
                      return Answer(
                          isPaperDetails: true,
                          answerText: answers[index],
                          answerColor: widget.questions[i]["correctAns"]  == answers[index] || widget.questions[i]["selectedAns"]  == answers[index] ?
                          widget.questions[i]["correctAns"]  == answers[index] ? Color(0xff7CCC00) :Color(0xffE10034)
                               :
                          Color(0xffE9E9E9),
                          answerTap: (){},
                        );

                    })),
                Divider()
              ],
            );
          }
      ),
    );
  }
}
