import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/main.dart';
import 'package:flutter_ui_homework/src/pages/login/login_page.dart';
import 'package:get/get.dart';

class Routes {
  static const rootPage = "/";
  static const mainPage = "/main";

  static Map<String, WidgetBuilder> getRoute(){
    return <String, WidgetBuilder>{
      rootPage : (_) => MyHomePage(),
    };
  }

  static List<GetPage> getPageRoute() {
    return [
      GetPage(
        name: rootPage,
        page: () => LoginPage(),
      ),
      GetPage(
        name: mainPage,
        page: () => MyHomePage(),
        transition: Transition.rightToLeft,
      )
    ];
  }
}
