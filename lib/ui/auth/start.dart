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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Gaps.horizontalPadding),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Container(
                     margin: EdgeInsets.only(top: height * 0.2),
                    width: width * 0.7,
                    height: height * 0.4,
                    child: Center(
                      child: Image.asset("assets/images/logo.png",fit: BoxFit.contain,),
                    ),
                  )
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
