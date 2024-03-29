// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurancehero/constants/gaps.dart';
import 'package:insurancehero/history.dart';
import 'package:insurancehero/home.dart';
import 'package:insurancehero/models/category.dart' as cae;
import 'package:insurancehero/models/title_model.dart';
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
  List<TitleModel> titles= [];


  Future<List<TitleModel>>  getTitles() async{
    QuerySnapshot snap = await FirebaseFirestore.instance.collection("title").get();
    List<TitleModel> allTitles = snap.docs.map((e) => TitleModel.fromMap(e.data() as Map<String,dynamic>)).toList();
    print(allTitles.length.toString() + "this is my");
    titles = allTitles;
    print(titles.length);
    return Future.value(allTitles);
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
    List<TitleModel> titles = await getTitles();
    for (int i = 0; i < titles.length; i++) {
      categoryList.add(Category(
        isChecked: mySubjects.contains(titles[i].id) ? true : false,subjectName:  titles[i].title as String,id:  titles[i].id as String));
      setState(() {});
    }
  }

  bool i = false;

  @override
  void initState() {
    super.initState();
    getMySubjects();
    getList();
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
                  }
                  categories = [];
                  setState(() {});
                } else {
                  i = true;
                  categories = [];
                  for (int i = 0; i < categoryList.length; i++) {
                    categoryList[i].isChecked = true;
                    categories.add(categoryList[i].id);
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
                                  ? categories.add(category.id)
                                  : categories.remove(category.id);
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
                                        ? categories.add(category.id)
                                        : categories
                                            .remove(category.id);
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
                      updateCategories(categories: categories, context: context);
                      print(categories);
                    }))
          ],
        ),
      ),
    );
  }
}
