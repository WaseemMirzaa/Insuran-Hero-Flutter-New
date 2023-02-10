import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insurancehero/constants/gaps.dart';
import 'package:insurancehero/history.dart';
import 'package:insurancehero/models/paper_model.dart';
import 'package:insurancehero/models/title_model.dart';
import 'package:insurancehero/question.dart';
import 'package:insurancehero/services/firebase/quizz_service.dart';
import 'package:insurancehero/utils/colors.dart';
import 'package:insurancehero/utils/firebase_instances.dart';
import 'package:insurancehero/utils/toast_message.dart';
import 'main.dart';
import 'models/question_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PaperModel> allQuizz = [];
  List<QuestionModel> questionsList = [];

  List<String> ids = ["Chemistry", "test"];

  List<TitleModel> mySubjects = [];

  Future<List<TitleModel>> getMySubjects() async {
    List<dynamic> mySubject = [];
    mySubject = await QuizService().getMySubjects();
    if(mySubject.isNotEmpty) {
      QuerySnapshot mySnap = await FirebaseFirestore.instance.collection(
          "title").where("id", whereIn: mySubject).get();
      mySubjects = mySnap.docs.map((e) =>
          TitleModel.fromMap(e.data() as Map<String, dynamic>)).toList();
    }
    return mySubjects;
  }

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  int doneQUiz = 0;
  Future<void> init() async {
    mySubjects = await getMySubjects();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Insurance Hero',
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
        body: FutureBuilder<List<TitleModel>>(
          future: getMySubjects(),
          builder: ((context, snapshot) {
            if (snapshot.hasData && snapshot.data!.length > 0) {
              mySubjects = snapshot.data!;
              return Container(
                padding:
                    EdgeInsets.symmetric(horizontal: Gaps.horizontalPadding),
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xffffffff)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GridView.builder(
                            itemCount: mySubjects.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                               childAspectRatio: MediaQuery.of(context).size.height > 300 ?  0.9 : 0.9,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, i) {
                              return subjectItem(
                                img: mySubjects[i].homeUrl ?? "",
                                  title: mySubjects[i].title ?? "", onTap: () async {
                                    allQuizz = await QuizService()
                                        .getPaper(mySubjects[i].title ?? "");
                                    showsDialogue(mySubjects[i].generalUrl ?? "https://firebasestorage.googleapis.com/v0/b/insurance-hero.appspot.com/o/col-maths.png?alt=media&token=7da512f0-76fc-43c8-814a-6385895fe06a");
                                  });
                            }),
                      ),
                    ]),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                    height: 30, width: 30, child: CircularProgressIndicator()),
              );
            } else {
              return const Center(
                child: Text("Please select subjects from profile"),
              );
            }
          }),
        ));
  }

  Widget crownIcon(
      {required Color borderColor,
      required String img,
      required String lessonNo,
      required VoidCallback onTap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 45,
            width: 45,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 3, color: borderColor)),
            child: Center(
                child: Image.asset(
              "assets/images/$img.png",
              height: 17,
              width: 21,
            )),
          ),
        ),
        verticalGap(5),
        Text(
          overflow: TextOverflow.ellipsis,
          " Lesson $lessonNo",
          style: const TextStyle(
              fontFamily: 'Calibri',
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Text title(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Calibri',
        fontSize: 18,
        color: Color(0xffcccccc),
        letterSpacing: 0.18,
        height: 2.388888888888889,
      ),
      textHeightBehavior:
          const TextHeightBehavior(applyHeightToFirstAscent: false),
      textAlign: TextAlign.center,
    );
  }

  Container imageBox(String img) {
    return Container(
      height: 110,
      width: 110,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(width: 5.0, color: const Color(0xffe9e9e9)),
      ),
      child: Center(
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: const Color(0xfff6f6f6),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 5.0, color: const Color(0xffe9e9e9)),
          ),
          child: Image.asset('assets/images/$img.png'),
        ),
      ),
    );
  }

  showsDialogue(String img) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xffF6F6F6),
                border: Border.all(
                  width: 5,
                  color: lightGrey,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lessons",
                    style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 66,
                    child: ListView.builder(
                        itemCount: allQuizz.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (cnt, i) {
                          allQuizz[i]
                                  .attemptedUsers!
                                  .contains(userController.userModel.value.uid)
                              ? doneQUiz++
                              : null;
                          return crownIcon(
                            lessonNo: allQuizz[i].lessonNo ?? "",
                            borderColor: allQuizz[i].attemptedUsers!.contains(
                                    userController.userModel.value.uid)
                                ? lightGreenColor
                                : lightGrey,
                            onTap: () {
                              allQuizz[i].attemptedUsers!.contains(
                                      userController.userModel.value.uid)
                                  ? toastMessage("Quiz Already Completed")
                                  : {
                                Navigator.of(context).pop(),
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) =>
                                        QuestionView(
                                          img: img,
                                          paper: allQuizz[i],
                                        ))),
                              };
                            },
                            img: allQuizz[i].attemptedUsers!.contains(
                                    userController.userModel.value.uid)
                                ? "green-crown"
                                : "grey-crown",
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget subjectItem({required String title, required VoidCallback onTap,required String img}) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(width: 5.0, color: const Color(0xffe9e9e9)),
              ),
              child: Center(
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xfff6f6f6),
                    borderRadius: BorderRadius.circular(28),
                    border:
                        Border.all(width: 5.0, color: const Color(0xff89e100)),
                  ),
                  child: Image.network(img),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: AutoSizeText(
              maxLines: 3,
              minFontSize: 5,
              '$title',
              overflow: TextOverflow.ellipsis,
              style:  TextStyle(
                fontFamily: 'Calibri',
                fontSize: 18,
                color: Color(0xff000000),
                letterSpacing: 0.18,
              ),
              // textHeightBehavior:
              //     const TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
