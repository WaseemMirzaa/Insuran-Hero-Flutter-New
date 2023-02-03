import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insurancehero/models/app_info_model.dart';
import 'package:insurancehero/ui/auth/start.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurancehero/utils/firebase_instances.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {

  String? title;
  String? desc;

  @override
  void initState() {
    super.initState();
    _fetchInformation();
  }

  _fetchInformation() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("settings")
        .doc('app_info')
        .get();

    AppInfoModel infoModel = AppInfoModel.fromMap(snap.data() as Map<String, dynamic>);
    setState(() {
      title = infoModel.title;
      desc = infoModel.description;
    });
  }

  _navigatetohome() async {
    final prefs = await SharedPreferences.getInstance();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
             child: Text(
              title ?? "Information Screen",
                style: TextStyle(
                  fontFamily: 'Calibri',
                  fontSize: 18,
                  color: Color(0xff000000),
                ),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            ),
            Text(
              desc ?? '',
              style: TextStyle(
                fontFamily: 'Calibri',
                fontSize: 18,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          ]),
      ),
    );
  }
}
