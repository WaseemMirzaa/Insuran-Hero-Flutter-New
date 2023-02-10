import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:insurancehero/models/app_info_model.dart';
import 'package:insurancehero/ui/auth/start.dart';
import 'package:insurancehero/utils/firebase_instances.dart';
import 'package:insurancehero/widgets/full_width_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen

  ({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  String? title;
  String? htmlData = "";
  late AppInfoModel infoModel;
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    _fetchInformation();

    htmlData =
        "<!DOCTYPE html>"
            "<html>"
            "<head>"
            "<meta charset='UTF-8'>"
            '<title>My Page</title>'
            '</head>'
            '<body>'
            '</body>'
            '</html>';
  }

  _fetchInformation() async {
    prefs = await SharedPreferences.getInstance();

    DocumentSnapshot snap = await firebaseFirestore.collection("settings").doc('app-info').get();

    infoModel = AppInfoModel.fromMap(snap.data() as Map<String, dynamic>);
    setState(() {
      title = infoModel.title;
      htmlData = infoModel.htmlData;
    });
  }

  _navigatetohome() async {
    final prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 20,
          ),
          // Center(
          //   child: Text(
          //     title ?? "Information Screen",
          //     style: TextStyle(
          //       fontFamily: 'Calibri',
          //       fontSize: 24,
          //       fontWeight: FontWeight.bold,
          //       color: Color(0xff000000),
          //     ),
          //     textAlign: TextAlign.center,
          //     softWrap: false,
          //   ),
          // ),
          // Container(
          //   height: 20,
          // ),

          Html(
            data: htmlData,
          ),

          // Container(
          //   margin: EdgeInsets.all(10.0),
          //   child: Text(
          //     htmlData ?? '',
          //     style: TextStyle(
          //       fontFamily: 'Calibri',
          //       fontSize: 18,
          //       color: Color(0xff000000),
          //     ),
          //     textAlign: TextAlign.start,
          //     softWrap: true,
          //   ),
          // ),
        ]),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: TextButton(
          onPressed: () async => {

          prefs.setBool('information_screen', true),
          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => StartView())),
        },
          child: const Text('Done', style: TextStyle(
            fontFamily: 'Calibri',
            fontSize: 18,
            color: const Color(0xff77c801),
            letterSpacing: 0.18,
          ),),
        ),
        // child: fullWidthButton(
        //     context: context,
        //     buttonColor: const Color(0xff77c801),
        //     shadowColor: const Color(0xff6bb500),
        //     title: 'Done',
        //     onTap: () {
        //       prefs.setBool('information_screen', true);
        //         Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => StartView()));
        //     }),
      ),
    );
  }
}
