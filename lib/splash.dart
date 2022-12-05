import 'package:flutter/material.dart';
import 'package:insurancehero/ui/auth/start.dart';
import 'package:google_fonts/google_fonts.dart';

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
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => StartView()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff77c801),
      child: const Center(
        child: Text(
          'Insurance\nHero',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'Calibri',
            fontSize: 60,
            color: Color(0xffffffff),
            height: 1,
            fontWeight: FontWeight.w400,
          ),
          textHeightBehavior:
              TextHeightBehavior(applyHeightToFirstAscent: false),
          textAlign: TextAlign.center,
          softWrap: false,
        ),
      ),
    );
  }
}
