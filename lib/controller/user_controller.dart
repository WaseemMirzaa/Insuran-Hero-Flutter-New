import 'package:get/get.dart';
import 'package:insurancehero/models/user_model.dart';


class UserController extends GetxController {
   Rx<UserModel> userModel = UserModel().obs;
}
