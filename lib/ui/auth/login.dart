import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:insurancehero/constants/gaps.dart';
import 'package:insurancehero/models/user_model.dart';
import 'package:insurancehero/services/firebase/auth_service.dart';
import 'package:insurancehero/ui/auth/forget_password.dart';
import 'package:insurancehero/ui/auth/signup.dart';
import 'package:insurancehero/utils/email_validate.dart';
import 'package:insurancehero/utils/toast_message.dart';
import 'package:insurancehero/widgets/custom_text_field.dart';
import 'package:insurancehero/widgets/full_width_button.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../controller/user_controller.dart';
import '../../main.dart';
import '../../services/firebase/user_services.dart';
import '../../utils/firebase_instances.dart';
import '../bottom_nav.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String userName = "";
  String password = "";

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

  addToHive() async {
    UserController userController = Get.put(UserController());
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get();

    UserModel users = UserModel.fromMap(snap.data() as Map<String, dynamic>);
    user
        .put("users", users)
        .then((value) => userController.userModel.value = user.get("users"))
        .then((value) {
      pushNewScreen(context, screen: HomeView());
    });
  }

  late Box box;
  Future<void> init() async {
    box = await Hive.openBox('users');
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
        title: const Text(
          'Enter your details',
          style: TextStyle(
            fontFamily: 'Calibri',
            fontSize: 18,
            color: Color(0xff000000),
          ),
          softWrap: false,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/images/back-arrow.png',
            scale: 3,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Gaps.horizontalPadding),
            child:
            Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [


                        Obx(
                              () => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                verticalGap(Gaps.verticalPadding),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff6f6f6),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 2.0, color: const Color(0xffe9e9e9)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      customTextField(
                                          validator: (v) {
                                            if (v == null ||
                                                v.isEmpty ||
                                                v.length < 6 ||
                                                !Validate(userName)) {
                                              return 'Please enter Valid Email Address';
                                            }
                                          },
                                          keyBoardType: TextInputType.emailAddress,
                                          hintText: "Email",
                                          onChanged: (val) {
                                            setState(() {
                                              userName = val;
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
                                verticalGap(25),
                                loadingController.isLoading.value
                                    ? loadingWidget(context)
                                    : fullWidthButton(
                                    context: context,
                                    title: "Log In",
                                    buttonColor: const Color(0xff89e100),
                                    shadowColor: const Color(0xff7ccc00),
                                    onTap: () {
                                      loadingController.isLoading.value = true;
                                      if (password != "" && userName != "") {
                                        loadingController.isLoading.value = true;
                                        performSigIn(
                                          boxs: box,
                                          password: password,
                                          email: userName,
                                          context: context,
                                        ).whenComplete(() =>
                                        loadingController
                                            .isLoading.value = false
                                        );
                                      } else {
                                        toastMessage(
                                            "Incorrect Username or Password");
                                      }
                                    }),
                                verticalGap(15),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(ForgetPassword());
                                  },
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "FORGET PASSWORD?",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),

                      ],
                    ),
                  ),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xff32599c),
                                borderRadius: BorderRadius.circular(17.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xff2c4f8b),
                                    offset: Offset(0, 3),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: TextButton.icon(
                                onPressed: () async {
                                     signInWithFaceboook().
                                     whenComplete(() => addSocialUserData()).then((value) => toHive(box, context));
                                },
                                icon: Image.asset(
                                  'assets/images/facebook.png',
                                  scale: 3,
                                ),
                                label: const Text(
                                  'FACEBOOK',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 16,
                                    color: Color(0xffffffff),
                                    letterSpacing: 0.16,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                            ),
                          ),
                          horizontalGap(10),
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xfffa2c26),
                                borderRadius: BorderRadius.circular(17.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xffdf2621),
                                    offset: Offset(0, 3),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: TextButton.icon(
                                onPressed: () async {
                                  await signInWithGoogle();
                                  if (auth.currentUser?.uid != null) {
                                    await addSocialUserData();
                                    await toHive(box, context);
                                  }
                                },
                                icon: Image.asset(
                                  'assets/images/google.png',
                                  scale: 3,
                                ),
                                label: const Text(
                                  'GOOGLE',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 16,
                                    color: Color(0xffffffff),
                                    letterSpacing: 0.16,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Offstage(
                        offstage: !Platform.isIOS,
                        child: SignInWithAppleButton(
                          height: 50,
                          onPressed: () async {
                            // final appleProvider = AppleAuthProvider();
                            // // await FirebaseAuth.instance.signInWithProvider(appleProvider);
                            // final AuthorizationResult result = await TheAppleSignIn.performRequests([
                            //   AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
                            // ]).onError((error, stackTrace) => toastMessage("error occured"));
                            // print(result.status);

                            final user = await AuthService().signInWithApple(
                                scopes: [Scope.email, Scope.fullName]);
                            print('uid: ${user.uid}');
                            //   appleProvider signInWithApple();
                            //   print(auth.currentUser?.uid ?? "");
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? ",
                              style: TextStyle(
                                  fontFamily: 'Calibri',
                                  fontSize: 15,
                                  color: Color(0xffb4b4b4))),
                          GestureDetector(
                              onTap: () {
                                Get.to(SignupView());
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Calibri',
                                  fontSize: 15,
                                ),
                              )),
                        ],
                      ),
                      verticalGap(70),

                    ],
                  ),


]          ),
        ),
      ),
    ),);
  }

  Widget passwordField(
      {required String hintText,
      required ValueChanged<String>? onChanged,
      VoidCallback? onTap}) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
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
              fontSize: 16,
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
}

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User> signInWithApple({List<Scope> scopes = const []}) async {
    // 1. perform the sign-in request
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = userCredential.user!;
        if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }
}
