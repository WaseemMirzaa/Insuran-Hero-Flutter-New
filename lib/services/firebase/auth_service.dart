import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:insurancehero/controller/user_controller.dart';
import 'package:insurancehero/main.dart';
import 'package:insurancehero/models/user_model.dart';
import 'package:insurancehero/services/firebase/storage_service.dart';
import 'package:insurancehero/services/firebase/user_services.dart';
import 'package:insurancehero/ui/auth/start.dart';
import 'package:insurancehero/utils/toast_message.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../ui/bottom_nav.dart';
import '../../utils/firebase_instances.dart';

UserController userController = Get.put(UserController());

String errorMessage = "";
Future<void> performSignUp({
  required String email,
  required String password,
  required BuildContext context,
  required String firstName,
  required String lastName,
  required String phone,
  required Box box,
  File? img,
}) async {

  print('🔴🔴🔴🔴🔴🔴🔴Sign Up called');
 try{
    print('🔴🔴🔴🔴🔴🔴🔴photo url uploaded');
   await auth.createUserWithEmailAndPassword(email: email, password: password);
    print('🔴🔴🔴🔴🔴🔴🔴User created');
    String photoUrl =
    await StorageMethods().uploadImageToStorage("profiles", img!);
    await addUserData(
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      profileUrl: photoUrl,
    );
    print('🔴🔴🔴🔴🔴🔴🔴🔴Added user data');
  await  toHive(box, context);
    print('🔴🔴🔴🔴🔴🔴🔴🔴to Hive Called');
  }  on FirebaseAuthException catch  (e) {
    loadingController.isLoading.value = false;
    print('🔴🔴🔴🔴🔴🔴🔴🔴 error message ${e.message}');
    toastMessage(e.message ?? '');
    print('Failed with error code: ${e.code}');
print(e.message);
}

}

Future<void> performSigIn(
    {required String email,
    required String password,
    required BuildContext context,
    required Box boxs}) async {
  try{
    await auth.signInWithEmailAndPassword(email: email, password: password);
    await toHive(boxs, context);
  } on FirebaseAuthException catch  (e) {
    loadingController.isLoading.value = false;
    print('🔴🔴🔴🔴🔴🔴🔴🔴 error message ${e.message}');
    toastMessage(e.message ?? '');
    print('Failed with error code: ${e.code}');
    print(e.message);
  }


}

Future resetPassword({required String email}) async {
  await auth.sendPasswordResetEmail(email: email).then((value) =>
      Fluttertoast.showToast(msg: "")
          .then((value) => Get.back()));
}

toHive(Box box, BuildContext context) async {
  DocumentSnapshot snap = await firebaseFirestore
      .collection("users")
      .doc(auth.currentUser?.uid ?? "")
      .get();
  UserModel userModel = UserModel.fromMap(snap.data() as Map<String, dynamic>);
  box
      .put("users", userModel)
      .then((value) => userController.userModel.value = box.get("users"))
      .then((value) {
    pushNewScreen(context, screen: HomeView(), withNavBar: false);
  });
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

 signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  if(loginResult.accessToken != null){
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  // Create a credential from the access token

  // Once signed in, return the UserCredential
}


performSignOut() {
  userController.userModel.value = UserModel();
  auth.signOut().then((value) => Get.to(StartView()));
}

 signInWithApple() async {
  final appleProvider = AppleAuthProvider();
  if (kIsWeb) {
    await FirebaseAuth.instance.signInWithPopup(appleProvider);
  } else {
    await FirebaseAuth.instance.signInWithProvider(appleProvider);
  }
}