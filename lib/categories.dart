// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurancehero/constants/gaps.dart';
import 'package:insurancehero/history.dart';
import 'package:insurancehero/home.dart';
import 'package:insurancehero/models/category.dart' as cae;
import 'package:insurancehero/services/firebase/quizz_service.dart';
import 'package:insurancehero/services/firebase/user_services.dart';
import 'package:insurancehero/ui/bottom_nav.dart';
import 'package:insurancehero/ui/profile/profile.dart';
import 'package:insurancehero/utils/colors.dart';
import 'package:insurancehero/widgets/full_width_button.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'models/Category.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  List<Category> categoryList = [];
  List<dynamic> titles = [];

  Future<List<dynamic>> getPapers() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('titles')
        .doc("iQJ1NqTmLw0ugCoOSMVu")
        .get();

    List<dynamic> titlesList = (snap.data() as Map<String, dynamic>)['titles'];
    titles = titlesList;
    print(titles.length);
    return Future.value(titlesList);
  }

  List<dynamic> categories = [];

  Future<List<dynamic>> getMySubjects() async {
    List<dynamic> mySubjects = [];
    mySubjects = await QuizService().getMySubjects();
    categories = mySubjects;
    return mySubjects;
  }

  getList() async {
    List<dynamic> mySubjects = await getMySubjects();
    //print(titles);
    List<dynamic> titles = await getPapers();
    for (int i = 0; i < titles.length; i++) {
      categoryList.add(Category(
          mySubjects.contains(titles[i]) ? true : false, titles[i] as String));
      setState(() {});
    }
  }

  bool i = false;

  @override
  void initState() {
    super.initState();
    getMySubjects();
    getList();
    getPapers();
    print(categoryList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/images/back-arrow.png',
            scale: 3,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Select Categories',
          style: TextStyle(
            fontFamily: 'Calibri',
            fontSize: 18,
            color: Color(0xff000000),
          ),
          textAlign: TextAlign.center,
          softWrap: false,
        ),
        actions: [
          Checkbox(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            side: const BorderSide(
              width: 2.0,
              color: Color(0xffe9e9e9),
            ),
            activeColor: const Color(0xff89e100),
            checkColor: Colors.white,
            value: i,
            onChanged: (bool? value) {
              setState(() {
                if (i) {
                  i = false;
                  for (int i = 0; i < categoryList.length; i++) {
                    categoryList[i].isChecked = false;
                    categories.remove(categoryList[i].subjectName);
                  }
                  setState(() {});
                } else {
                  i = true;
                  for (int i = 0; i < categoryList.length; i++) {
                    categoryList[i].isChecked = true;
                    categories.add(categoryList[i].subjectName);
                  }
                  setState(() {});
                }
              });
            },
          ),
        ],
        elevation: 1.5,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var category in categoryList)
                      Padding(
                        padding: EdgeInsets.only(
                          left: Gaps.horizontalPadding,
                          top: Gaps.verticalPadding,
                          right: Gaps.horizontalPadding,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              category.isChecked = !category.isChecked;
                              category.isChecked
                                  ? categories.add(category.subjectName)
                                  : categories.remove(category.subjectName);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 2.0,
                                color: !category.isChecked
                                    ? lightGrey
                                    : const Color(0xff89e100),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: !category.isChecked
                                      ? lightGrey
                                      : const Color(0xff89e100),
                                  offset: const Offset(0, 3),
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        category.subjectName,
                                        style: TextStyle(
                                          fontFamily: 'Calibri',
                                          fontSize: 17,
                                          color: !category.isChecked
                                              ? const Color(0xffb4b4b4)
                                              : const Color(0xff89e100),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  side: const BorderSide(
                                    width: 2.0,
                                    color: Color(0xffe9e9e9),
                                  ),
                                  activeColor: const Color(0xff89e100),
                                  checkColor: Colors.white,
                                  value: category.isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      category.isChecked = value!;
                                    });
                                    category.isChecked
                                        ? categories.add(category.subjectName)
                                        : categories
                                            .remove(category.subjectName);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    verticalGap(100)
                  ]),
            ),
            Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: fullWidthButton(
                    context: context,
                    title: "Save",
                    buttonColor: Color(0xff89e100),
                    shadowColor: Color(0xff7ccc00),
                    onTap: () {
                      categories.isNotEmpty
                          ? updateCategories(
                              categories: categories, context: context)
                          : Navigator.pop(context);
                      print(categories);
                    }))
          ],
        ),
      ),
    );
  }
}