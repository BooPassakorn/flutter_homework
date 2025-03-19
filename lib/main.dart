import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/core/config/routes.dart';
import 'package:flutter_ui_homework/core/di/auth_controller.dart';
import 'package:flutter_ui_homework/core/di/di.dart';
import 'package:flutter_ui_homework/core/lifecycle/lifecycle_listener.dart';
import 'package:flutter_ui_homework/core/widget/custom_confirm_dialog.dart';
import 'package:flutter_ui_homework/src/model/DTO/UserStoryDTO.dart';
import 'package:flutter_ui_homework/src/pages/main/main_content.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import 'constant/constant_value.dart';

void main() async {
  await initGetX();
  Get.put(AuthController());
  runApp(GetMaterialApp(
    getPages: Routes.getPageRoute(),
    initialRoute: Routes.rootPage, //เริ่มที่หน้า Login
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: Routes.getPageRoute(),
      initialRoute: Routes.rootPage,
    );
  }
}

class MyHomePage extends StatefulWidget  {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with LifecycleListenerEvent {
  late LifecycleListener _lifecycleListener;

  List<UserStoryDTO> storyList = [];

  @override
  void initState() {
    super.initState();
    _fetchAllStoryUser();

    _lifecycleListener = LifecycleListener(providerInstance: this);
  }

  Future<void> _fetchAllStoryUser() async {
    try {
      final url = Uri.parse('$baseURL/api/user/get-all-story-users');
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));

        setState(() {
          storyList = jsonData.map((json) => UserStoryDTO.fromJsonToUserStoryDTO(json)).toList();
        });
      } else {
        print('Server responded with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  void onResume() {
    print("onResume MyHomePage");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showDialog(
            context: context,
            builder: (ctx) {
              return CustomConfirmDialog(
                title: "Confirm to close the application??",
                description: "",
                positiveText: "Confirm",
                negativeText: "Cancel",
                positiveColor: Colors.blueAccent,
                assetImage: "assets/logout.svg",
                positiveHandler: () async {
                  Get.find<AuthController>().endSession();

                  //  Get.offAllNamed(Routes.rootPage); //ออกมาหน้าแรก

                  //_exitApp();
                },

                negativeHandler: () async {

                },
              );
            });

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFF14BDD9), Color(0xFF7FE4EE), Color(0xFF7281C1), Color(0xFF6A73C0)],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ).createShader(bounds),
            child: Text('Qiyorie',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold),
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
              child: storyList.isEmpty ? Center(child: CircularProgressIndicator(),)
                  : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: storyList.length,
                  itemBuilder: (context, index) {
                    return StoryItem(
                      name: storyList[index].user_name ?? '',
                      imageBase64: storyList[index].user_profile,
                      story: storyList[index].story,
                    );
                  },
                ),
              ),
              // child: ListView(
              //   scrollDirection: Axis.horizontal,
              //   children: [
              //     StoryItem(name: 'Your Story', imagePath: 'assets/story1.jpg'),
              //     StoryItem(name: 'pattanap...', imagePath: 'assets/story2.jpg'),
              //     StoryItem(name: 'bufrghm...', imagePath: 'assets/story3.jpg'),
              //     StoryItem(name: '13161.jpg', imagePath: 'assets/story4.jpg'),
              //     StoryItem(name: 'uwuwu', imagePath: 'assets/story5.jpg'),
              //     StoryItem(name: 'MainJett', imagePath: 'assets/story6.jpg'),
              //   ],
              // ),
            Expanded(child: MainContent()),
          ],
        ),
      ),
    );
  }
}

class StoryItem extends StatefulWidget {
  final String name;
  final Uint8List? imageBase64;
  final bool? story;

  StoryItem({required this.name, required this.imageBase64, this.story});

  @override
  _StoryItemState createState() => _StoryItemState();
}

class _StoryItemState extends State<StoryItem> with TickerProviderStateMixin { //TickerProviderStateMixin สามารถควบคุมแอนิเมชันได้ ใช้ควบคุม AnimationController
  late AnimationController _controller; //ตัวคุมอนิเมชัน
  bool playOnTap = false; //ป้องกันกดรัวๆ แล้วเล่นซ้ำ
  bool hasPlay = false; //ตรวจว่ามีการเล่นไปรึยัง
  String lottieAsset = 'assets/loading_story_IG.json';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController( vsync: this, duration: Duration(milliseconds: 6000)); //กำหนดเวลาของ lottie เวลาแสดง

    WidgetsBinding.instance.addPostFrameCallback((_) { //โค้ดที่อยู่ในคลาสจะถูกเรียกหลังจากโหลดหน้าแรกเสร็จ
      _controller.forward(from: 1).then((_) { //forward คือการให้อนิเมชันเล่น และหยุดด้วย then
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

      //เล่น Lottie ตัวเดิม
      _controller.forward(from: 0).then((_) { //กดแล้วต้องเล่นอนิเมชันตั้งแต่เริ่มต้นของ lottie
        setState(() { //เมื่อเล่นเสร็จแล้วจะทำให้เปลี่ยนไปใช้ lottie ตัวใหม่
          lottieAsset = 'assets/loading_story_IG_black.json';
        });

        //เล่น lottie ตัวใหม่
        _controller.reset();
        _controller.forward(from: 1).then((_) {
          setState(() {
            playOnTap = false; //false เพื่อ เมื่ออนิเมชันเล่นเสร็จ จะสามารถเล่นต่อได้
          });
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
                if (widget.story != false)
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Lottie.asset(
                    lottieAsset,
                    controller: _controller,
                    animate: false,//ไม่เล่นออโต้
                    repeat: false,//ไม่วนลูป
                    onLoaded: (composition) { //ถ้าอนิเมชันเล่นเสร็จ จะทำงาน
                      setState(() {
                        _controller.duration = composition .duration; //ถ้าเล่นเสร็จ จะตั้งเวลาการเล่นของ lottie ตาม JSON
                      });
                    },
                  ),
                ),
                if (widget.story != false)
                CircleAvatar(
                  radius: 30,
                  // backgroundImage: AssetImage(widget.imagePath),
                  backgroundImage: widget.imageBase64 is Uint8List ? MemoryImage(widget.imageBase64 as Uint8List) : null,
                ),
              ],
            ),
            SizedBox(height: 3),
            if (widget.story != false)
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
