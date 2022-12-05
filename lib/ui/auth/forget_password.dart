import 'package:flutter/material.dart';

import '../../services/firebase/auth_service.dart';
import '../../utils/email_validate.dart';
import '../../utils/toast_message.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/full_width_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email = "";
  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Reset Password',
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: 18,
              color: Color(0xff000000),
            ),
            softWrap: false,
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              'assets/images/back-arrow.png',
              scale: 3,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xfff6f6f6),
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(width: 2.0, color: const Color(0xffe9e9e9)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customTextField(
                        validator: (v) {
                          if (v == null || v.isEmpty || v.length < 6) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        hintText: "Email",
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              fullWidthButton(
                  context: context,
                  title: "Reset",
                  buttonColor: const Color(0xff89e100),
                  shadowColor: const Color(0xff7ccc00),
                  onTap: () async {
                    if (Validate(email)){
                      await resetPassword(email: email);
                    }else{
                      toastMessage("Enter Valid Email Address");
                    }
                  }),
            ],
          ),
        ));
  }
  
}
