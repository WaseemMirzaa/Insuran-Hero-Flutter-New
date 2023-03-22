import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:insurancehero/constants/routes.dart';
import 'package:insurancehero/controller/loading_controller.dart';
import 'package:insurancehero/home.dart';
import 'package:insurancehero/ranking.dart';
import 'package:insurancehero/ui/auth/signup.dart';
import 'package:insurancehero/splash.dart';
import 'package:insurancehero/ui/auth/start.dart';
import 'package:insurancehero/ui/bottom_nav.dart';
import 'package:insurancehero/ui/profile/profile.dart';
import 'package:insurancehero/ui/profile/settings.dart';
import 'package:path_provider/path_provider.dart';

import 'categories.dart';
import 'controller/user_controller.dart';
import 'firebase_options.dart';
import 'history.dart';
import 'models/user_model.dart';
import 'ui/auth/login.dart';

late Box user;

UserController userController = Get.put(UserController());
LoadingController loadingController = Get.put(LoadingController());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loadingController.isLoading.value = false;

  var directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);

  Hive.registerAdapter(UserModelAdapter());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FacebookAuth.instance.webAndDesktopInitialize(
    appId: "713969236758394",
    cookie: true,
    xfbml: true,
    version: "v15.0",
  );
  user = await Hive.openBox("users");
  userController.userModel.value = user.get("users", defaultValue: UserModel());

  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // final appleSignInAvailable = await AppleSignInAvailable.check();
  // runApp(Provider<AppleSignInAvailable>.value(
  //   value: appleSignInAvailable,
  //   child: MyApp(),
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      routes: {
        loginRoute: (context) => const LoginView(),
        signupRoute: (context) => const SignupView(),
        homeRoute: (context) => const Home(),
        startRoute: (context) => const StartView(),
        historyRoute: (context) => const HistoryView(),
        profileRoute: (context) => const ProfileView(),
        settingsRoute: (context) => const SettingsView(),
        categoriesRoute: (context) => const CategoriesView(),
        rankingRoute: (context) => const RankingView()
      },
        debugShowCheckedModeBanner: false,
      home: userController.userModel.value.uid == null ? Splash() : HomeView(),
    );
  }
}
