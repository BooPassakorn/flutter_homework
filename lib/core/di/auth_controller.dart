
import 'package:flutter/foundation.dart';
import 'package:flutter_ui_homework/core/config/routes.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  void bypassLogin() {
    print("BypassLogin function is called!!!!!!!!!!!!");
    Get.offAllNamed(Routes.mainPage);
  }

  void endSession() async {
    try {
      Get.offAllNamed(Routes.rootPage);
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

}