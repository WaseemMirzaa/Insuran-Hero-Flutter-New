import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insurancehero/information_screen.dart';
import 'package:insurancehero/ui/auth/start.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurancehero/utils/firebase_instances.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/app_info_model.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  String? title;
  String? desc;

  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {

    await Future.delayed(Duration(milliseconds: 2000), () {});

    final prefs = await SharedPreferences.getInstance();

    final bool? informationScreen = prefs.getBool('information_screen');

    if (informationScreen == null || !informationScreen) {

      AppInfoModel infoModel = await _fetchInformation();
      if(infoModel != null && (infoModel.isEnabled ?? false)){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => InformationScreen()));
      } else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => StartView()));
      }

    }
    else {

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => StartView()));
    }
  }

  Future<AppInfoModel> _fetchInformation() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("settings")
        .doc('app-info')
        .get();

     return AppInfoModel.fromMap(snap.data() as Map<String, dynamic>);

    // setState(() {
    //   title = infoModel.title;
    //   desc = infoModel.description;
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
