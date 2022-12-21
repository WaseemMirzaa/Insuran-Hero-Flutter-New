import 'dart:core';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurancehero/constants/gaps.dart';
import 'package:insurancehero/constants/routes.dart';
import 'package:insurancehero/home.dart';
import 'package:insurancehero/ui/bottom_nav.dart';
import 'package:insurancehero/utils/toast_message.dart';
import 'package:intl/intl.dart';

import 'package:insurancehero/answer.dart';
import 'package:insurancehero/services/firebase/quizz_service.dart';
import 'package:insurancehero/utils/colors.dart';
import 'package:insurancehero/utils/firebase_instances.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:progress_border/progress_border.dart';
// import 'package:sizer/sizer.dart';

import 'main.dart';
import 'models/paper_model.dart';
import 'models/question_model.dart';
import 'models/quiz_history_model.dart';

class QuestionView extends StatefulWidget {
  PaperModel paper;
  QuestionView({super.key, required this.paper});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView>
    with SingleTickerProviderStateMixin {
  CountDownController _controller = CountDownController();
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;
  String correctAns = "";
  String selectedAns = "";
  Color ansColor = lightGrey;

  void _nextQuestion() {
    setState(() {
      _questionIndex <= widget.paper.questions!.length
          ? _questionIndex++
          : null;
      isSelected = -1;
      // correctAnswerSelected = false;
    });

    if (selectedAns == correctAns) {
      _totalScore++;
    }
    if (_questionIndex >= widget.paper.questions!.length) {
      _resetQuiz();
    }

    if (_questionIndex > 0) {
    } else {}
  }

  int inComplete = 0;
  int complete = 0;

  List<List<QuestionModel>> subjects = [];
  List<String> ids = [];

  // List<QuestionModel> _questions = [];

  updatePaper() async {
    await firebaseFirestore
        .collection("subjects")
        .doc(widget.paper.title)
        .collection("papers")
        .doc(widget.paper.paperId)
        .update({
      "attemptedUsers":
          FieldValue.arrayUnion([userController.userModel.value.uid])
    });
  }

  void _resetQuiz() {
    print(DateFormat.EEEE().format(DateTime.now()));
    QuizHistoryModel quizHistoryModel = QuizHistoryModel(
        totalQuestions: widget.paper.questions!.length.toString(),
        correctAns: _totalScore.toString(),
        type: widget.paper.title,
        day: DateFormat.EEEE().format(DateTime.now()),
        time: DateFormat.jm().format(DateTime.now()),
        uid: userController.userModel.value.uid,
        level: widget.paper.lessonNo.toString(),
        img:
            "https://firebasestorage.googleapis.com/v0/b/insurance-hero.appspot.com/o/col-maths.png?alt=media&token=7da512f0-76fc-43c8-814a-6385895fe06a");
    addQuizzInHistort(quizHistoryModel);
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
    showsDialogue();
  }

  double sliderVal = 0;

  int isSelected =
      -1; // changed bool to int and set value to -1 on first time if you don't select anything otherwise set 0 to set first one as selected.

  _isSelecte(int index) {
    //pass the selected index to here and set to 'isSelected'
    setState(() {
      isSelected = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller.start();
    updatePaper();
    inComplete = widget.paper.questions!.length.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            pushNewScreen(context, screen: HomeView(), withNavBar: false);
          },
          icon: Image.asset(
            'assets/images/back-arrow.png',
            scale: 3,
          ),
        ),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              Expanded(
                      flex: complete,
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xff77c801),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        bottomLeft: Radius.circular(3)),
                  ),
                ),
              ),
              Expanded(
                flex: inComplete,
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3)),
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 1.5,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Gaps.horizontalPadding,
              vertical: Gaps.verticalPadding),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    QuestionModel.fromMap(
                                widget.paper.questions![_questionIndex])
                            .question ??
                        "",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 20,
                        color: Color(0xff000000),
                        letterSpacing: 0.25,
                        fontWeight: FontWeight.w500),
                    softWrap: true,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CircularCountDownTimer(
                        onComplete: () {
                          QuizHistoryModel quizHistoryModel = QuizHistoryModel(
                              level: widget.paper.lessonNo.toString(),
                              totalQuestions:
                                  widget.paper.questions!.length.toString(),
                              correctAns: _totalScore.toString(),
                              type: widget.paper.title,
                              day: DateFormat.EEEE().format(DateTime.now()),
                              time: DateFormat.j().format(DateTime.now()),
                              uid: userController.userModel.value.uid,
                              img:
                                  "https://firebasestorage.googleapis.com/v0/b/insurance-hero.appspot.com/o/col-maths.png?alt=media&token=7da512f0-76fc-43c8-814a-6385895fe06a");
                          addQuizzInHistort(quizHistoryModel);
                          Navigator.pop(context);
                        },
                        duration: widget.paper.time ?? 0,
                        initialDuration: 0,
                        controller: _controller,
                        isReverse: true,
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 4,
                        ringColor: lightGrey,
                        ringGradient: null,
                        fillColor: lightGreenColor,
                        backgroundColor: Colors.white,
                        backgroundGradient: null,
                        strokeWidth: 10.0,
                        strokeCap: StrokeCap.round,
                        textStyle: TextStyle(
                          fontSize: 33.0,
                          color: lightGreenColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textFormat: CountdownTextFormat.S,
                        isReverseAnimation: true,
                        isTimerTextShown: true,
                        autoStart: true),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: ((context, index) {
                        List<String> answers = [];
                        answers.add(QuestionModel.fromMap(
                                    widget.paper.questions![_questionIndex])
                                .A ??
                            "");
                        answers.add(QuestionModel.fromMap(
                                    widget.paper.questions![_questionIndex])
                                .B ??
                            "");
                        answers.add(QuestionModel.fromMap(
                                    widget.paper.questions![_questionIndex])
                                .C ??
                            "");
                        answers.add(QuestionModel.fromMap(
                                    widget.paper.questions![_questionIndex])
                                .D ??
                            "");
                        correctAns = QuestionModel.fromMap(
                                    widget.paper.questions![_questionIndex])
                                .correctAns ??
                            "";
                        return Answer(
                            answerText: answers[index],
                            answerColor: isSelected != null
                                //set condition like this. voila! if isSelected and list index matches it will colored as white else orange.
                                ? isSelected == index
                                    ? Color(0xff6bb500)
                                    : lightGrey
                                : lightGrey,
                            answerTap: () {
                              _isSelecte(index);

                              setState(() {
                                selectedAns = answers[index];
                                isSelected = index;
                              });
                              print(selectedAns + "<<<selected Answer is");
                              print(correctAns + "<<<correct Answer is");
                              print(_totalScore.toString() +
                                  "total scores are");
                            });
                      })),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color(0xff77c801),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xff6bb500),
                          offset: Offset(0, 3),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (isSelected != -1) {
                          inComplete--;
                          complete++;
                          isSelected = -1;
                          _nextQuestion();
                          setState(() {});
                        } else {
                          toastMessage("Please select Answer");
                        }
                      },
                      child: Center(
                        child: Text(
                          endOfQuiz ? 'Done!' : 'Next Question',
                          style: const TextStyle(
                            fontFamily: 'Calibri',
                            fontSize: 18,
                            color: Color(0xffffffff),
                            letterSpacing: 0.18,
                          ),
                          textHeightBehavior: const TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                          softWrap: false,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  showsDialogue() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 160,
              decoration: BoxDecoration(
                color: Color(0xffF6F6F6),
                border: Border.all(
                  width: 5,
                  color: lightGrey,
                ),
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Congragulations :",
                    style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 24,
                        color: greenColor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Quiz Completed Successfully!",
                    style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(lightGreenColor)),
                        onPressed: () {
                          Get.to(HomeView());
                        },
                        child: Text(
                          "Ok",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          );
        });
  }
}
