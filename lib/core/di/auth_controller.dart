
import 'package:flutter_ui_homework/core/config/routes.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  void bypassLogin() {
    Get.offAllNamed(
        Routes.mainPage); //ไม่เอาตัวเองลง stack และล้าง stack ออกด้วย

    // Get.toNamed(Routes.mainPage);
  }
}