import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/core/widget/navigation_bar.dart';
import 'package:flutter_ui_homework/src/pages/login/login_page.dart';
import 'package:get/get.dart';

class Routes {
  static const rootPage = "/";
  static const mainPage = "/main";

  static Map<String, WidgetBuilder> getRoute(){
    return <String, WidgetBuilder>{
      rootPage : (_) => LoginPage(),
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
        page: () => NavigationBarPage(),
        transition: Transition.rightToLeft,
      )
    ];
  }
}
