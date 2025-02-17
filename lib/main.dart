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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Qiyorie', style: TextStyle(color: Colors.blueAccent, fontSize: 24, fontWeight: FontWeight.bold)),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: Colors.black, size: 30,),
                onPressed: () {},
              ),
              Positioned(
                right: 20,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '61',
                    style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildStoryItem('Your Story', 'assets/story1.jpg'),
                _buildStoryItem('pattanap...', 'assets/story2.jpg'),
                _buildStoryItem('bufrghm...', 'assets/story3.jpg'),
                _buildStoryItem('13161.jpg', 'assets/story4.jpg'),
                _buildStoryItem('uwuwu', 'assets/story5.jpg'),
              ],
            ),
          ),
          Expanded(child: Center(child: Text('Main Content Here'))),
        ],
      ),
    );
  }

  Widget _buildStoryItem(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 4),
          Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}




