import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../../models/user_model.dart';
import '../../utils/firebase_instances.dart';
import '../../utils/toast_message.dart';

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('MMMM, y');
final String formattedDate = formatter.format(now);
late Box box;

Future addUserData({
  required String email,
  BuildContext? context,
  required String firstName,
  required String lastName,
  required String phone,
  required String profileUrl,
}) async {
  try {
    // showLoadingIndicator(context!);
    if (auth.currentUser != null) {
      UserModel userModel = UserModel(
        firstName: firstName,
        email: email,
        lastName: lastName,
        phone: phone,
        profile: profileUrl,
        uid: auth.currentUser!.uid,
        fullName: "$firstName $lastName",
        categories: <String>[],
        joinedDate: formattedDate,
        isSocialUser: false,
      );
      firebaseFirestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set(userModel.toMap());
      Fluttertoast.showToast(msg: 'Account Created Successfully');
    } else {
      Navigator.pop(context!);
      Fluttertoast.showToast(msg: 'Internet Connection Error');
    }
  } on FirebaseAuthException catch (e) {
    Navigator.of(context!).pop();
    if (e.message != null) print(e.message!);
  }
}

addSocialUserData() async {
  if (auth.currentUser != null) {
    UserModel userModel = UserModel(
        categories: [],
        joinedDate: formattedDate,
        firstName: "",
        lastName: "",
        fullName: auth.currentUser!.displayName,
        email: auth.currentUser!.providerData[0].email,
        phone: auth.currentUser!.providerData[0].phoneNumber,
        profile: auth.currentUser!.photoURL,
        isSocialUser: true,
        uid: auth.currentUser!.uid);

    DocumentSnapshot documentSnapshot = await firebaseFirestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get();
    if (!documentSnapshot.exists) {
      firebaseFirestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set(userModel.toMap());
      Fluttertoast.showToast(msg: 'Account Created Successfully');
    } else {
      Fluttertoast.showToast(msg: 'Logged In Successfully');
    }
  } else {
    toastMessage("Authentication Failed");
  }
}

// getData(BuildContext context){
//   UserProvider _userProvider = Provider.of(context,listen: false);
//   _userProvider.refreshUser();
// }

Future<void> updateUser({
  required String fullName,
  required String phone,
}) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  return users.doc(auth.currentUser!.uid).update({
    'fullName': fullName,
    'phone': phone,
  }).catchError((error) => print("Failed to update user: $error"));
}

Future<void> updateCategories(
    {required List<dynamic> categories, required BuildContext context}) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // ignore: avoid_single_cascade_in_expression_statements
  users
      .doc(auth.currentUser!.uid)
      .update({'categories': FieldValue.delete()}).whenComplete(() {
    users
        .doc(auth.currentUser!.uid)
        .update({
          'categories': categories,
        })
        .then((value) => toastMessage("Categories Updated Successfully"))
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to update user: $error"));
    ;
  });
}
