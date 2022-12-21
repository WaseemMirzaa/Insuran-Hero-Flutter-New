import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insurancehero/constants/gaps.dart';
import 'package:insurancehero/models/user_model.dart';
import 'package:insurancehero/services/firebase/auth_service.dart';
import 'package:insurancehero/services/firebase/user_services.dart';
import 'package:insurancehero/ui/profile/profile.dart';
import 'package:insurancehero/utils/firebase_instances.dart';
import 'package:insurancehero/utils/loading_indicator.dart';
import 'package:insurancehero/utils/toast_message.dart';
import 'package:insurancehero/widgets/full_width_button.dart';

import '../../../classes/colors.dart';
import '../../utils/colors.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  int index = 0;

  updateIndex() {
    if (index == 0) {
      index = 1;
    } else {
      index = 0;
    }
    setState(() {});
  }

  UserModel user = UserModel();


  getUser() async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection("users")
        .doc(userController.userModel.value.uid)
        .get();
    UserModel currentUser =
        UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    user = currentUser;
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // setInitialValues();
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
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileView()));
          },
          icon: Image.asset(
            'assets/images/back-arrow.png',
            scale: 3,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Account Settings',
          style: TextStyle(
            fontFamily: 'Calibri',
            fontSize: 18,
            color: Color(0xff000000),
          ),
          textAlign: TextAlign.center,
          softWrap: false,
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/edit.png',
              scale: 3,
            ),
            onPressed: () {
              updateIndex();
            },
          ),
        ],
        elevation: 1.5,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Gaps.horizontalPadding,
                vertical: Gaps.verticalPadding),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 81,
                width: 90,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: lightGrey),
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.network(
                    userController.userModel.value.profile ?? "",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              verticalGap(5),
              Text(
                user.fullName ?? "",
                style: TextStyle(
                  fontFamily: 'Simply Rounded',
                  fontSize: 25,
                  color: Color(0xff000000),
                  letterSpacing: 0.3,
                ),
                softWrap: false,
              ),
                verticalGap(35),
                 StreamBuilder(
                  stream: firebaseFirestore.collection("users").doc(userController.userModel.value.uid).snapshots(),
                  builder: (context,snap){
                    if(snap.hasData ) {
                      name.text = snap.data?["fullName"] ?? "";
                      phone.text = snap.data?["phone"] ?? "";
                      return Column(
                        children: [
                          Row(
                            children: [
                              buildIconBox("Icon awesome-user-alt"),
                              const SizedBox(
                                width: 10,
                              ),
                              customsTextField("User Name", name, width
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 15),
                            child: divider(),
                          ),
                          Row(
                            children: [
                              buildIconBox("mail"),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                      fontFamily: 'Calibri',
                                      fontSize: 12,
                                      color: Color(0xffd5d5d5),
                                    ),
                                  ),
                                  Text(snap.data?["email"] ?? "",
                                      style: TextStyle(
                                        fontFamily: 'Simply Rounded',
                                        fontSize: width * 0.06,
                                        color: Colors.black,
                                      )),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 15),
                            child: divider(),
                          ),
                          Offstage(
                            offstage: user.isSocialUser ?? false,
                            child: Row(
                              children: [
                                buildIconBox("phone"),
                                const SizedBox(
                                  width: 10,
                                ),
                                customsTextField("Phone", phone, width

                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }else {
                      return Center(child: Text("Please login "),);
                    } },
              ),


              Offstage(
                  offstage: user.isSocialUser ?? false,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 15),
                    child: divider(),
                  )),
              Offstage(
                offstage: index == 0 ? true : false,
                child: fullWidthButton(
                    context: context,
                    title: "Update",
                    buttonColor: Color(0xff89e100),
                    shadowColor: Color(0xff7ccc00),
                    onTap: () async {
                      try {
                        toastMessage("Updating");
                        await updateUser(
                            fullName: name.text, phone: phone.text);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Updated Successfully"),
                          duration: Duration(milliseconds: 300),
                        ));
                        index = 0;
                        setState(() {});
                      } catch (e) {
                        LoadingIndicatorDialog().dismiss();
                        print(e.toString());
                      }
                    }),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Container divider() {
    return Container(
      height: 1,
      color: ColorsManager.borderColor,
    );
  }

  Expanded customsTextField(
      String text,TextEditingController controller,double width) {
    return Expanded(
      child: TextFormField(
        enabled: index == 1 ? true : false,
        controller: controller,
        keyboardType: TextInputType.name,
        style: TextStyle(
          fontFamily: 'Simply Rounded',
          fontSize: 18,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(
            fontFamily: 'Calibri',
            fontSize: 12,
            color: Color(0xffd5d5d5),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Container buildIconBox(String img) {
    return Container(
      height: 52,
      width: 45,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(width: 2.0, color: const Color(0xffe9e9e9)),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffe9e9e9),
            offset: Offset(0, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          'assets/images/$img.png',
          height: 25,
          width: 20,
        ),
      ),
    );
  }
}
