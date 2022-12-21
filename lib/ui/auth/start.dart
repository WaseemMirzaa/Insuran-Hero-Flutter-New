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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Gaps.horizontalPadding),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  verticalGap(170),
                  Center(
                    child: Text(
                      'Welcome to\nInsurance Hero',
                      maxLines: 2,
                      style: GoogleFonts.roboto(
                        fontSize: width * 0.12,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w600,
                        height: 1
                      ),
                      textHeightBehavior:
                          const TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.center,
                      softWrap: false,
                    ),
                  ),
                  verticalGap(10),
                   Text(
                    'Learn different languages at your\nown pace in an interactive way.',
                    style: TextStyle(
                      fontFamily: 'Calibri',
                      fontSize: width * 0.05,
                      color: Color(0xffb4b4b4),
                      letterSpacing: 0.21,
                      height: 1.2857142857142858,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                    softWrap: false,
                  ),
                ],
              ),
              Column(
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
            ]),
      ),
    );
  }
}
