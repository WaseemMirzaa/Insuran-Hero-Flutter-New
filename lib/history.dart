// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:insurancehero/constants/gaps.dart';
import 'package:insurancehero/models/question_model.dart';
import 'package:insurancehero/paper_details.dart';
import 'package:insurancehero/services/firebase/quizz_service.dart';
import 'package:insurancehero/ui/profile/profile.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'home.dart';
import 'models/quiz_history_model.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  int getNumeric(dynamic s) {
    var value = int.tryParse(s);
    return value ?? 0;
  }

  List<QuizHistoryModel> list = [];

  //
  getMyQuizz() async {
    list = await QuizService().myQuizz();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMyQuizz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Quiz History',
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: 18,
              color: Color(0xff000000),
            ),
            textAlign: TextAlign.center,
            softWrap: false,
          ),
          elevation: 1.5,
        ),
        body: list.isNotEmpty
            ? FutureBuilder<List<QuizHistoryModel>?>(
                future: QuizService().myQuizz(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    list = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            left: Gaps.horizontalPadding,
                            right: Gaps.horizontalPadding,
                            bottom: 20),
                        itemCount: list.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: historyListItem(
                                questions: list[i].questions ?? [],
                                title: list[i].type ?? "",
                                level: list[i].level ?? "",
                                img: list[i].img ?? "",
                                time: list[i].time ?? "",
                                day: list[i].day ?? "",
                                totalQuestions: list[i].totalQuestions ?? "",
                                right: getNumeric(list[i].correctAns),
                                wrong: getNumeric(list[i].totalQuestions) -
                                    getNumeric(list[i].correctAns)),
                          );
                        });
                  } else {
                    return Center(
                      child: Text("Your Quiz history will appear here."),
                    );
                  }
                }),
              )
            : Center(
                child: Text("Your Quiz history will appear here"),
              ));
  }

  Widget historyListItem(
      {
        required List<dynamic> questions,
        required String day,
      required String img,
      required String level,
      required String title,
      required String time,
      required String totalQuestions,
      required int right,
      required int wrong}) {
    int percentage = 0;
    int questoions = int.parse(totalQuestions);
    percentage = (right/questoions * 100).toInt();

    return GestureDetector(
      onTap: (){
        pushNewScreen(context,screen: PaperDetails(questions: questions),withNavBar: false);
      },
      child: Container(
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 93,
                  decoration: BoxDecoration(
                    color: const Color(0xfff6f6f6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: const Color(0xffe9e9e9)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffe9e9e9),
                        offset: Offset(0, 2),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Image.network(
                        img,
                        scale: 3,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: AutoSizeText(
                          minFontSize: 5,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          'Lesson $level',
                          style: const TextStyle(
                            fontFamily: 'Calibri',
                            fontSize: 14,
                            color: Color(0xff000000),
                            letterSpacing: 0.14,
                          ),
                          softWrap: false,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            horizontalGap(15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    '$title', maxLines: 3,
                    minFontSize: 10,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Calibri',
                      fontSize: 18,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                         const SizedBox(
                    height: 5,
                  ),

                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                              width: 1.5, color: const Color(0xffe9e9e9)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffe9e9e9),
                              offset: Offset(0, 2),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/grey-clock.png',
                          scale: 3,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${day}, ${time}',
                        style: TextStyle(
                          fontFamily: 'Calibri',
                          fontSize: 14,
                          color: Color(0xff7a7a7a),
                          letterSpacing: 0.14,
                        ),
                        softWrap: false,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Questions Correct ${percentage}%',
                        style: const TextStyle(
                          fontFamily: 'Calibri',
                          fontSize: 12,
                          color: Color(0xffb4b4b4),
                        ),
                        softWrap: false,
                      ),

                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: right,
                        child: Container(
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xff89e100),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3),
                              bottomLeft: Radius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: wrong,
                        child: Container(
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xffE9E9E9),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(3),
                              bottomRight: Radius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
