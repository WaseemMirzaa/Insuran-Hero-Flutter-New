import 'dart:core';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurancehero/constants/gaps.dart';
import 'package:insurancehero/controller/nav_bar_controller.dart';
import 'package:insurancehero/ui/bottom_nav.dart';
import 'package:insurancehero/utils/toast_message.dart';
import 'package:intl/intl.dart';

import 'package:insurancehero/answer.dart';
import 'package:insurancehero/services/firebase/quizz_service.dart';
import 'package:insurancehero/utils/colors.dart';
import 'package:insurancehero/utils/firebase_instances.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'main.dart';
import 'models/paper_model.dart';
import 'models/question_model.dart';
import 'models/quiz_history_model.dart';

class QuestionView extends StatefulWidget {
  PaperModel paper;
  String img;
  QuestionView({super.key, required this.paper,required this.img});

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
  NavBarController navBarController = Get.put(NavBarController());

  int index = 0;
  update(){
    if(index == 0){
      setState(() {
        index = 1;
      });
    }else{
      setState(() {
        index = 0;
      });
    }
  }

  List<Map<String,dynamic>> quizzQuestions = [];

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
    print(quizzQuestions.length.toString() + "this is lenght of questions before uploading");
    QuizHistoryModel quizHistoryModel = QuizHistoryModel(
        questions: quizzQuestions,
        totalQuestions: widget.paper.questions!.length.toString(),
        correctAns: _totalScore.toString(),
        type: widget.paper.title,
        day: DateFormat.EEEE().format(DateTime.now()),
        time: DateFormat.jm().format(DateTime.now()),
        uid: userController.userModel.value.uid,
        level: widget.paper.lessonNo.toString(),
         img: widget.img,
        );
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
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Gaps.horizontalPadding,
              vertical: Gaps.verticalPadding),
          child: Stack(
            children: [
              SingleChildScrollView(
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
                            fontSize: 16,
                            color: Color(0xff000000),
                            letterSpacing: 0.25,
                            fontWeight: FontWeight.w500),
                        softWrap: true,
                      ),
                      verticalGap(5),
                      QuestionModel.fromMap(widget.paper.questions![_questionIndex]).hint != null ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Hint : ",
                                style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 16,
                                    color: Color(0xffB4B4B4),
                                    letterSpacing: 0.25,
                                    fontWeight: FontWeight.w500
                                ),),
                              Offstage(
                                offstage: index == 0,
                                child: Text(
                                  "${QuestionModel.fromMap(widget.paper.questions![_questionIndex]).hint}",
                                  style: TextStyle(
                                      fontFamily: 'Calibri',
                                      fontSize: 16,
                                      color: Color(0xffB4B4B4),
                                      letterSpacing: 0.25,
                                      fontWeight: FontWeight.w500
                                  ),),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: (){
                                update();
                                print("this is index" + index.toString());
                                },
                              icon: Icon(index == 0 ?  Icons.visibility_off : Icons.visibility))
                        ],
                      ) : Container(),
                      verticalGap(25),
                      Align(
                        alignment: Alignment.center,
                        child: CircularPercentIndicator(
                          radius: 45.0,
                          animation: true,
                          animateFromLastPercent: true,
                          animationDuration: (widget.paper.time ?? 0) * 1000,
                          lineWidth: 4.0,
                          percent: 1,
                          backgroundColor: lightGrey,
                          center: TweenAnimationBuilder<Duration>(
                              duration: Duration(milliseconds: widget.paper.time! * 1000),
                              tween: Tween(begin: Duration(milliseconds: widget.paper.time! * 1000), end: Duration.zero),
                              onEnd: () {
                                QuizHistoryModel quizHistoryModel = QuizHistoryModel(
                                    questions: quizzQuestions,
                                    level: widget.paper.lessonNo.toString(),
                                    totalQuestions:
                                    widget.paper.questions!.length.toString(),
                                    correctAns: _totalScore.toString(),
                                    type: widget.paper.title,
                                    day: DateFormat.EEEE().format(DateTime.now()),
                                    time: DateFormat.j().format(DateTime.now()),
                                    uid: userController.userModel.value.uid,
                                    img: widget.img
                               );
                                addQuizzInHistort(quizHistoryModel);
                                navBarController.currentIndex.value = 1;
                                navBarController.controller.index = 1;
                                showsDialogue();
                                // pushNewScreen(context, screen: Home(),withNavBar: false);
                              },
                              builder: (BuildContext context, Duration value, Widget? child) {
                                final minutes = value.inMinutes;
                                var seconds = value.inSeconds % 60;
                                String scnds = "";
                                if(seconds >10 ){
                                  scnds = seconds.toString();
                                }else{
                                  scnds = "0" + seconds.toString();
                                }
                                return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    child:   AutoSizeText(
                                      '$minutes:$scnds', maxLines: 1,
                                      minFontSize: 10,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontFamily: 'Calibri',
                                        fontSize: 30,
                                        color:Color(0xff6bb500),
                                          fontWeight: FontWeight.bold,
                                      ),
                                    ),



                                   );
                              }),
                          progressColor: Color(0xff6bb500),
                        ),
                      ),
                      verticalGap(25),
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
                                isPaperDetails: false,
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
                      verticalGap(20),
                    ]),
              ),
              Positioned(
                bottom: 5,
                right: 1,
                left: 1,
                child: Container(
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
                        QuestionModel question = QuestionModel(
                            hint: QuestionModel.fromMap(widget.paper.questions![_questionIndex]).hint,
                            A: QuestionModel.fromMap(widget.paper.questions![_questionIndex]).A,
                            B: QuestionModel.fromMap(widget.paper.questions![_questionIndex]).B,
                            C: QuestionModel.fromMap(widget.paper.questions![_questionIndex]).C,
                            D: QuestionModel.fromMap(widget.paper.questions![_questionIndex]).D,
                            correctAns: QuestionModel.fromMap(widget.paper.questions![_questionIndex]).correctAns,
                            selectedAns: selectedAns,
                            question: QuestionModel.fromMap(widget.paper.questions![_questionIndex]).question
                        );
                        quizzQuestions.add(question.toMap());
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
              ),
            ],
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
              height: 140,
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
                  AutoSizeText(
                    maxLines: 1,
                    minFontSize: 10,
                    maxFontSize: 24,
                    "Congratulations",
                    style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 24,
                        color: greenColor,

                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AutoSizeText(
                    maxLines: 1,
                    minFontSize: 10,
                    maxFontSize: 18,
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



