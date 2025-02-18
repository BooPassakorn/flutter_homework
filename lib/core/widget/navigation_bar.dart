import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/main.dart';
import 'package:get/get.dart';

class NavigationBarPage extends StatelessWidget {
  const NavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) => controller.selectedIndex.value = index,
        
            destinations: [
              NavigationDestination(icon: Icon(Icons.home_outlined), label: ''),
              NavigationDestination(icon: Icon(Icons.workspaces_outline), label: ''),
              NavigationDestination(icon: Icon(Icons.add_circle_outline), label: ''),
              NavigationDestination(icon: Icon(Icons.move_to_inbox_outlined), label: ''),
              NavigationDestination(icon: Icon(Icons.account_circle_outlined), label: ''),
            ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [MyHomePage(), Container(color: Colors.blueAccent,), Container(color: Colors.red,),Container(color: Colors.yellow,),Container(color: Colors.green,)];
}


