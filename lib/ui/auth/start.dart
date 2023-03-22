import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurancehero/constants/gaps.dart';
import 'package:insurancehero/ui/auth/signup.dart';
import 'package:insurancehero/widgets/full_width_button.dart';
import 'login.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Gaps.horizontalPadding),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        verticalGap(100),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15),
                            child: AutoSizeText(
                              'Welcome to\nInsurance Hero',
                              maxLines: 2,
                              minFontSize: 12,
                              maxFontSize: 100,
                              style: GoogleFonts.roboto(
                                  fontSize: 100,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w600,
                                  height: 1
                              ),
                              textAlign: TextAlign.center,
                              softWrap: false,
                            ),
                          ),
                        ),
                        verticalGap(10),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: AutoSizeText(
                            maxLines: 2,
                            minFontSize: 10,
                            maxFontSize: 20,
                            'Learn more about Insurance Industry\n at your own pace in an interactive way.',
                            style: TextStyle(
                              fontFamily: 'Calibri',
                              fontSize: 35,
                              color: Color(0xffb4b4b4),

                              letterSpacing: 0.21,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          width: width * 0.9,
                          height: height * 0.35
                          ,
                          child: Center(
                            child: Image.asset("assets/images/logo.png",fit: BoxFit.contain,),
                          ),
                        )
                      ],
                    ),
                      ],
                    ),

                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Column(
                    children: [
                      fullWidthButton(
                          context: context,
                          buttonColor: const Color(0xff77c801),
                          shadowColor: const Color(0xff6bb500),
                          title: 'GET STARTED',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignupView())
                            );
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      fullWidthButton(
                          context: context,
                          buttonColor: const Color(0xff89e100),
                          shadowColor: const Color(0xff7ccc00),
                          title: 'I ALREADY HAVE AN ACCOUNT',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginView())
                            );
                          }),
                      verticalGap(50)
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
