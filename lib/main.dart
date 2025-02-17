import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/core/config/routes.dart';
import 'package:flutter_ui_homework/core/di/auth_controller.dart';
import 'package:flutter_ui_homework/core/di/di.dart';
import 'package:flutter_ui_homework/core/lifecycle/lifecycle_listener.dart';
import 'package:get/get.dart';

void main() async {

  await initGetX();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: Routes.getPageRoute(),
      initialRoute: Routes.rootPage,
    );
  }
}

class MyHomePage extends StatelessWidget with LifecycleListenerEvent {
  // MyHomePage({Key? key}) : super(key: key);

  late LifecycleListener _lifecycleListener;

  MyHomePage({Key? key}) : super(key: key) {
    _lifecycleListener = LifecycleListener(providerInstance: this);
  }
  @override
  void onResume() {
    print("onResume MyHomePage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Test")
          ],
        ),
      ),
    );
  }
}



