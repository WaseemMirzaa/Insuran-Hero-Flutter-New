import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insurancehero/constants/gaps.dart';
import 'package:insurancehero/main.dart';
import 'package:insurancehero/ui/auth/login.dart';
import 'package:insurancehero/ui/privacy_policy.dart';
import 'package:insurancehero/utils/pick_image.dart';
import 'package:insurancehero/widgets/custom_text_field.dart';
import 'package:insurancehero/widgets/full_width_button.dart';

import '../../services/firebase/auth_service.dart';
import '../../utils/email_validate.dart';
import '../terms.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  File? _image;
  selectImageCamera() async {
    File im = await pickImage(
      ImageSource.camera,
    );
    setState(() {
      _image = im;
    });
  }

  selectImageGallery() async {
    File im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  final _formKey = GlobalKey<FormState>();
  String password = "";
  double lat = 0;
  double long = 0;

  late Box boxs;

  int index = 0;
  void changeIndex() {
    if (index == 0) {
      index = 1;
    } else {
      index = 0;
    }
    setState(() {});
    print(index);
  }

  Future<void> init() async {
    boxs = await Hive.openBox('users');
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Enter your details',
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
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xffffffff)),
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Gaps.horizontalPadding),
              child: Obx(
                () => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(height: MediaQuery.of(context).size.height*0.80,
              child: Column(children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _image == null
                          ? Padding(
                        padding:
                        EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                          height: 97,
                          width: 97,
                          decoration: BoxDecoration(
                            color: const Color(0xfff6f6f6),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 2.0,
                                color: const Color(0xffe9e9e9)),
                          ),
                          child: TextButton(
                              onPressed: () {
                                _showPicker(context);
                              },
                              child: Image.asset(
                                'assets/images/user.png',
                                scale: 3.5,
                              )),
                        ),
                      )
                          : Padding(
                        padding:
                        EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                          height: 97,
                          width: 97,
                          decoration: BoxDecoration(
                            color: const Color(0xfff6f6f6),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 2.0,
                                color: const Color(0xffe9e9e9)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xfff6f6f6),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 2.0, color: const Color(0xffe9e9e9)),
                        ),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            customTextField(
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                                hintText: "First Name",
                                onChanged: (val) {
                                  setState(() {
                                    firstName = val;
                                  });
                                }),
                            Container(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            customTextField(
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                                hintText: "Last Name",
                                onChanged: (val) {
                                  setState(() {
                                    lastName = val;
                                  });
                                }),
                            Container(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            customTextField(
                                validator: (v) {
                                  if (v == null ||
                                      v.isEmpty ||
                                      !Validate(email)) {
                                    return 'Please enter Valid Email address';
                                  }
                                  return null;
                                },
                                keyBoardType: TextInputType.emailAddress,
                                hintText: "Email Address",
                                onChanged: (val) {
                                  setState(() {
                                    email = val.trim();
                                  });
                                  Validate(email);
                                }),
                            Container(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            customTextField(
                                validator: (v) {
                                  if (v == null ||
                                      v.isEmpty ||
                                      v.length < 1) {
                                    return 'Invalid Phone Number';
                                  }
                                  return null;
                                },
                                keyBoardType: TextInputType.phone,
                                hintText: "Phone Number",
                                onChanged: (val) {
                                  setState(() {
                                    phone = val;
                                  });
                                }),
                            Container(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            passwordField(
                                hintText: "Password",
                                onChanged: (v) {
                                  setState(() {
                                    password = v;
                                  });
                                })
                          ],
                        ),
                      ),
                      verticalGap(30),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Column(children: [
                      //       AutoSizeText(
                      //         maxLines: 3,
                      //         'By signing up to Insurance  asd asd as dasd asd asd asd as dHero, You agree to our',
                      //         style: TextStyle(
                      //           fontFamily: 'Calibri',
                      //           fontSize: 15,
                      //           color: Color(0xffb4b4b4),
                      //         ),
                      //       ),
                      //     ],),
                      //
                      //   ],
                      // ),

                      verticalGap(10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     GestureDetector(
                      //         onTap: () {
                      //           Get.to(TermsConditionsView());
                      //         },
                      //         child:  Text(
                      //           'Terms & Conditions',
                      //           style: TextStyle(
                      //             decoration: TextDecoration.underline,
                      //             color: Color(0xff000000),
                      //             fontWeight: FontWeight.w700,
                      //             fontFamily: 'Calibri',
                      //             fontSize: 15,
                      //           ),
                      //         )),
                      //     Text(' and ',
                      //         style: TextStyle(
                      //             fontFamily: 'Calibri',
                      //             fontSize: 15,
                      //             color: Color(0xffb4b4b4))),
                      //     GestureDetector(
                      //         onTap: () {
                      //           Get.to(PrivacyPolicyView());
                      //         },
                      //         child:  Text(
                      //           'Privacy Policy',
                      //           style: TextStyle(
                      //             decoration: TextDecoration.underline,
                      //             color: Color(0xff000000),
                      //             fontWeight: FontWeight.w700,
                      //             fontFamily: 'Calibri',
                      //             fontSize: 15,
                      //           ),
                      //         )),
                      //   ],
                      // ),
                      privacyPolicyLinkAndTermsOfService(),
                      verticalGap(30),

                      loadingController.isLoading.value
                          ? loadingWidget()
                          : fullWidthButton(
                          context: context,
                          title: "Sign Up",
                          buttonColor: const Color(0xff89e100),
                          shadowColor: const Color(0xff7ccc00),
                          onTap: () {
                            Validate(email);
                            if (_formKey.currentState!.validate() &&

                                Validate(email)) {
                              if (_image == null || _image == "") {
                                Fluttertoast.showToast(msg: "Please select profile picture.");
                              } else {
                                loadingController.isLoading.value =
                                true;
                                setState(() {});
                                performSignUp(
                                    box: boxs,
                                    context: context,
                                    email: email,
                                    password: password,
                                    firstName: firstName,
                                    lastName: lastName,
                                    phone: phone,
                                    img: _image)
                                    .whenComplete(() =>
                                loadingController
                                    .isLoading.value = false);
                                //     .onError((error, stackTrace) {
                                //   loadingController.isLoading.value =
                                //       false;
                                //   setState(() {});
                                // });

                              }
                            }
                          }),
                      SizedBox(
                        height: 50,
                      ),
                      verticalGap(10),

                    ],
                  ),
                )
              ],),),
                      Column(children: [ Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? ",
                              style: TextStyle(
                                  fontFamily: 'Calibri',
                                  fontSize: 15,
                                  color: Color(0xffb4b4b4))),
                          GestureDetector(
                              onTap: () {
                                Get.to(LoginView());
                              },
                              child:  Text(
                                'Log In',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Calibri',
                                  fontSize: 15,
                                ),
                              )),
                        ],
                      ),],),
                    ]),
              ),
            ))));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      selectImageGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    selectImageCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }


  Widget privacyPolicyLinkAndTermsOfService() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Center(
          child: Text.rich(
              TextSpan(
                  text: 'By continuing, you agree to our ', style: TextStyle(
                  fontSize: 14, color: Colors.black
              ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Terms of Service', style: TextStyle(
                      fontSize: 14, color: const Color(0xff89e100),
                      decoration: TextDecoration.underline,
                    ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                                      Get.to(TermsConditionsView());

                            // code to open / launch terms of service link here
                          }
                    ),
                    TextSpan(
                        text: ' and ', style: TextStyle(
                        fontSize: 14, color: Colors.black
                    ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Privacy Policy', style: TextStyle(
                              fontSize: 14, color: const Color(0xff89e100),
                              decoration: TextDecoration.underline
                          ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(PrivacyPolicyView());
                                  // code to open / launch privacy policy link here
                                }
                          ),  TextSpan(
                              text: '.', style: TextStyle(
                              fontSize: 14, color: Colors.black
                          ),),
                        ]
                    )
                  ]
              )
          )
      ),
    );
  }


  Widget passwordField(
      {required String hintText,
      required ValueChanged<String>? onChanged,
      VoidCallback? onTap}) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          validator: (v) {
            if (v == null || v.isEmpty || v.length < 6) {
              return 'Password must be 6 digits long';
            }
            return null;
          },
          onChanged: onChanged,
          obscureText: index == 0 ? true : false,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
              left: 8,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Calibri',
              fontSize: 14,
              color: Color(0xff808080),
            ),
            border: InputBorder.none,
          ),
        ),
        IconButton(
            onPressed: changeIndex,
            icon: const Icon(
              Icons.remove_red_eye,
              color: Colors.black,
            ))
      ],
    );
  }

  Widget loadingWidget() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xff89e100),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff7ccc00),
            offset: Offset(0, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        // onPressed: () {
        //
        // },
        child: Center(
          child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(color: Colors.white)),
        ),
      ),
    );
  }
}

Widget loadingWidget(BuildContext context) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: const Color(0xff89e100),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: const Color(0xff7ccc00),
          offset: Offset(0, 3),
          blurRadius: 0,
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      // onPressed: () {
      //
      // },
      child: Center(
        child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(color: Colors.white)),
      ),
    ),
  );
}
