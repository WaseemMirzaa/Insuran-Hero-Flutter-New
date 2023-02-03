import 'package:flutter/material.dart';
import 'package:insurancehero/information_screen.dart';
import 'package:insurancehero/ui/auth/start.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => InformationScreen()));
    }
    else {

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => StartView()));
    }
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
