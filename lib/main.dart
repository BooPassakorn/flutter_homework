import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/core/config/routes.dart';
import 'package:flutter_ui_homework/core/di/auth_controller.dart';
import 'package:flutter_ui_homework/core/di/di.dart';
import 'package:flutter_ui_homework/core/lifecycle/lifecycle_listener.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
                StoryItem(name: 'Your Story', imagePath: 'assets/story1.jpg'),
                StoryItem(name: 'pattanap...', imagePath: 'assets/story2.jpg'),
                StoryItem(name: 'bufrghm...', imagePath: 'assets/story3.jpg'),
                StoryItem(name: '13161.jpg', imagePath: 'assets/story4.jpg'),
                StoryItem(name: 'uwuwu', imagePath: 'assets/story5.jpg'),
              ],
            ),
          ),
          Expanded(child: Center(child: Text('Main Content Coming Soon'))),
        ],
      ),
    );
  }
}

class StoryItem extends StatefulWidget {
  final String name;
  final String imagePath;

  StoryItem({required this.name, required this.imagePath});

  @override
  _StoryItemState createState() => _StoryItemState();
}

class _StoryItemState extends State<StoryItem> with TickerProviderStateMixin { //TickerProviderStateMixin สามารถควบคุมแอนิเมชันได้ ใช้ควบคุม AnimationController
  late AnimationController _controller; //ตัวคุมอนิเมชัน
  bool playOnTap = false; //ป้องกันกดรัวๆ แล้วเล่นซ้ำ
  bool hasPlay = false; //ตรวจว่ามีการเล่นไปรึยัง

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 6000)); //กำหนดเวลาของ lottie เวลาแสดง

    WidgetsBinding.instance.addPostFrameCallback((_) { //โค้ดที่อยู่ในคลาสจะถูกเรียกหลังจากโหลดหน้าแรกเสร็จ
      _controller.forward().then((_) { //forward คือการให้อนิเมชันเล่น และหยุดด้วย then
        setState(() {
          hasPlay = true; //เล่นเสร็จ
        });
      });
    });
  }

  void _playAnimation() {
    if (!playOnTap && hasPlay) { //ป้องกันการกดรัวๆแล้วเล่น และcheckว่าต้องเล่นจบแล้ว
      setState(() {
        playOnTap = true;
      });

      _controller.forward(from: 0).then((_) { //กดแล้วต้องเล่นอนิเมชันตั้งแต่เริ่มต้นของ lottie
        setState(() {
          playOnTap = false; //false เพื่อ เมื่ออนิเมชันเล่นเสร็จ จะสามารถเล่นต่อได้
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _playAnimation, //เรียกใช้ฟังก์ชันเล่นอนิเมชัน
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.5),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Lottie.asset(
                    'assets/loading_story_IG.json',
                    controller: _controller,
                    animate: false, //ไม่เล่นออโต้
                    repeat: false, //ไม่วนลูป
                    onLoaded: (composition) { //ถ้าอนิเมชันเล่นเสร็จ จำทำงาน
                      setState(() {
                        _controller.duration = composition.duration; //ถ้าเล่นเสร็จ จะตั้งเวลาการเล่นของ lottie ตาม JSON
                      });
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(widget.imagePath),
                ),
              ],
            ),
            SizedBox(height: 3),
            Text(
              widget.name,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

