import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/main.dart';
import 'package:get/get.dart';

class Routes {
  static const rootPage = "/";
  static const mainPage = "/main";

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      mainPage: (_) => MyApp(),
    };
  }

  static List<GetPage> getPageRoute() {
    return [
      GetPage(
        name: mainPage,
        page: () => MyApp(),
        transition: Transition.rightToLeft,
      )
    ];
  }
}
