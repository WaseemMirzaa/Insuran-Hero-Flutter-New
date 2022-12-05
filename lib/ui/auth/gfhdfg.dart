import 'dart:io';
// Needed because we can't import `dart:html` into a mobile app,
// while on the flip-side access to `dart:io` throws at runtime (hence the `kIsWeb` check below)

import 'package:flutter/material.dart';
import 'package:insurancehero/utils/firebase_instances.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../services/firebase/auth_service.dart';


class SignIngoggo extends StatefulWidget {
  const SignIngoggo({Key? key}) : super(key: key);

  @override
  _SignIngoggoState createState() => _SignIngoggoState();
}

class _SignIngoggoState extends State<SignIngoggo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example app: Sign in with Apple'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SignInWithAppleButton(
              onPressed: () async {
                signInWithApple();
                print(auth.currentUser?.uid ?? "");
              },
            ),
          ),
        ),
      ),
    );
  }
}
