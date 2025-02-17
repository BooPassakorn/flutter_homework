import 'package:flutter_ui_homework/core/di/auth_controller.dart';
import 'package:get/get.dart';

Future<void> initGetX() async {
  Get.put<AuthController>(AuthController());

}