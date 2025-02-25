import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/main.dart';
import 'package:flutter_ui_homework/src/pages/page/profile_page.dart';
import 'package:flutter_ui_homework/src/pages/page/recommand_page.dart';
import 'package:get/get.dart';

class NavigationBarPage extends StatelessWidget {
  const NavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBarTheme(
          //กำหนดธีม
          data: NavigationBarThemeData(
            indicatorColor: Colors.transparent, //ปิด overlay
          ),
          child: NavigationBar(
            backgroundColor: Colors.white,
            height: 50,
            //ความสูงของแถบ
            elevation: 0,
            //ไม่มีเงาข้างใต้
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected:
                (index) => controller.selectedIndex.value = index,

            destinations: [
              _navigationIcon(Icons.home_outlined, 0, controller),
              _navigationIcon(Icons.category_outlined, 1, controller),
              _navigationIcon(Icons.add_circle_outline, 2, controller),
              _navigationIcon(Icons.move_to_inbox_outlined, 3, controller),
              _navigationIcon(Icons.account_circle_outlined, 4, controller),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }

  NavigationDestination _navigationIcon(
    IconData icon,
    int index,
    NavigationController controller,
  ) {
    bool isSelected = controller.selectedIndex.value == index;
    return NavigationDestination(
      icon: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: isSelected ? Color(0xff07699d) : Colors.black54,
                ),
                if (isSelected)
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    width: 20,
                    height: 2,
                    color: Color(0xff07699d),
                  ),
              ],
            ),
            if (index == 3)
              Positioned(
                top: -4,
                right: 16,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "4",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
      label: '',
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs; //เก็บค่าปัจจุบันที่ถูกเลือก

  final screens = [
    MyHomePage(),
    RecommandPage(),
    Container(color: Colors.red),
    Container(color: Colors.yellow),
    ProfilePage(),
  ];
}
