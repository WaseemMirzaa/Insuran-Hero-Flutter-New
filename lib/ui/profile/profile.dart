import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:insurancehero/constants/gaps.dart';
import 'package:insurancehero/services/firebase/auth_service.dart';
import 'package:insurancehero/ui/auth/start.dart';
import 'package:insurancehero/ui/privacy_policy.dart';
import 'package:insurancehero/ui/profile/settings.dart';
import 'package:insurancehero/ui/terms.dart';
import 'package:insurancehero/utils/colors.dart';

import 'package:get/get.dart';
import 'package:insurancehero/controller/user_controller.dart';

import '../../../categories.dart';
import '../../main.dart';
import '../../models/user_model.dart';
import '../../utils/firebase_instances.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool status = false;
  UserController userController = Get.put(UserController());

  UserModel userd = UserModel();
  getUser() async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection("users")
        .doc(userController.userModel.value.uid)
        .get();
    UserModel currentUser =
    UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    userd = currentUser;
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Profile',
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Gaps.horizontalPadding),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          width: 2.0, color: const Color(0xffe9e9e9)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffe9e9e9),
                          offset: Offset(0, 3),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        userController.userModel.value.profile == null
                            ? SizedBox()
                            : Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 81,
                                width: 90,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 2, color: lightGrey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(9),
                                  child: Image.network(
                                    userController.userModel.value.profile ??
                                        "",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          height: 91,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 220,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    userd.fullName ?? "",
                                    style: TextStyle(
                                      fontFamily: 'Simply Rounded',
                                      fontSize: 30,
                                      color: const Color(0xff000000),
                                      letterSpacing: 0.3,
                                    ),
                                    softWrap: false,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Joined ${userController.userModel.value.joinedDate}',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 12,
                                    color: Color(0xffb4b4b4),
                                  ),
                                  softWrap: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              width: 2.0, color: const Color(0xffe9e9e9)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffe9e9e9),
                              offset: Offset(0, 3),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsView()));
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Account Settings',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 16,
                                    color: Color(0xffb4b4b4),
                                  ),
                                  softWrap: false,
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff6f6f6),
                                    borderRadius: BorderRadius.circular(7.0),
                                    border: Border.all(
                                        width: 2.0,
                                        color: const Color(0xffe9e9e9)),
                                  ),
                                  child: Image.asset(
                                    'assets/images/right-arrow.png',
                                    scale: 3,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      verticalGap(15),
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              width: 2.0, color: const Color(0xffe9e9e9)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffe9e9e9),
                              offset: Offset(0, 3),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoriesView()));
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Select Categories',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 16,
                                    color: Color(0xffb4b4b4),
                                  ),
                                  softWrap: false,
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff6f6f6),
                                    borderRadius: BorderRadius.circular(7.0),
                                    border: Border.all(
                                        width: 2.0,
                                        color: const Color(0xffe9e9e9)),
                                  ),
                                  child: Image.asset(
                                    'assets/images/right-arrow.png',
                                    scale: 3,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      verticalGap(15),
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              width: 2.0, color: const Color(0xffe9e9e9)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffe9e9e9),
                              offset: Offset(0, 3),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Notification',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 16,
                                    color: Color(0xffb4b4b4),
                                  ),
                                  softWrap: false,
                                ),
                                FlutterSwitch(
                                  height: 20,
                                  width: 35,
                                  padding: 1,
                                  toggleSize: 15,
                                  toggleBorder: Border.all(
                                      width: 1.0,
                                      color: const Color(0xff7ccc00)),
                                  toggleColor: const Color(0xff89e100),
                                  switchBorder: Border.all(
                                      width: 2.0,
                                      color: const Color(0xffe9e9e9)),
                                  activeColor: const Color(0xfff6f6f6),
                                  inactiveColor: const Color(0xfff6f6f6),
                                  value: status,
                                  onToggle: (val) {
                                    setState(() {
                                      status = val;
                                    });
                                  },
                                ),
                              ]),
                        ),
                      ),
                      verticalGap(15),
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              width: 2.0, color: const Color(0xffe9e9e9)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffe9e9e9),
                              offset: Offset(0, 3),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TermsConditionsView()));
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Terms And Conditions',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 16,
                                    color: Color(0xffb4b4b4),
                                  ),
                                  softWrap: false,
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff6f6f6),
                                    borderRadius: BorderRadius.circular(7.0),
                                    border: Border.all(
                                        width: 2.0,
                                        color: const Color(0xffe9e9e9)),
                                  ),
                                  child: Image.asset(
                                    'assets/images/right-arrow.png',
                                    scale: 3,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      verticalGap(15),
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              width: 2.0, color: const Color(0xffe9e9e9)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffe9e9e9),
                              offset: Offset(0, 3),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrivacyPolicyView()));
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 16,
                                    color: Color(0xffb4b4b4),
                                  ),
                                  softWrap: false,
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff6f6f6),
                                    borderRadius: BorderRadius.circular(7.0),
                                    border: Border.all(
                                        width: 2.0,
                                        color: const Color(0xffe9e9e9)),
                                  ),
                                  child: Image.asset(
                                    'assets/images/right-arrow.png',
                                    scale: 3,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              width: 2.0, color: const Color(0xff89e100)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff89e100),
                              offset: Offset(0, 3),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () async {
                            performSignOut();
                            user = await Hive.openBox("users");
                            user.delete("users");
                            userController.userModel.value = UserModel();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StartView()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Log Out',
                                style: TextStyle(
                                  fontFamily: 'Calibri',
                                  fontSize: 16,
                                  color: Color(0xff89e100),
                                ),
                                softWrap: false,
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xff89e100),
                                  borderRadius: BorderRadius.circular(7.0),
                                  border: Border.all(
                                      width: 2.0,
                                      color: const Color(0xff7ccc00)),
                                ),
                                child: Image.asset(
                                  'assets/images/white-arrow.png',
                                  scale: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
