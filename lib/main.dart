import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/core/config/routes.dart';
import 'package:flutter_ui_homework/core/di/di.dart';
import 'package:get/get.dart';

void main() async {

  await initGetX();
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
      // home: LoginPage(), // ตั้งค่า LoginPage เป็นหน้าแรก
      getPages: Routes.getPageRoute(),
      initialRoute: Routes.rootPage,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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



