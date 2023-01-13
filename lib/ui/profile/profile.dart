import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

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
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          userController.userModel.value.profile == null
                              ? SizedBox()
                              : Container(
                                  height: 75,
                                  width: 75,
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
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 24,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                '${userd.fullName}'?? "",
                                style: TextStyle(
                                  fontFamily: 'Simply Rounded',
                                  color: const Color(0xff000000),
                                  letterSpacing: 0.3,
                                ),
                              ),
                              SizedBox(height: 10,),
                              AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                maxLines: 1,
                                'Joined ${userController.userModel.value.joinedDate}',
                                style: TextStyle(
                                  fontFamily: 'Calibri',
                                  fontSize: 15,
                                  color: Color(0xffb4b4b4),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                              width: 2.0, color:  Colors.red),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.red,
                              offset: Offset(0, 3),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () async{
                            deleteAccount();
                            user = await Hive.openBox("users");
                            user.delete("users");
                            pushNewScreen(context, screen: StartView(),withNavBar: false);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delete Account',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                  softWrap: false,
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color:  Colors.red,
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: Image.asset(
                                    'assets/images/right-arrow.png',
                                    color: Colors.white,
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
