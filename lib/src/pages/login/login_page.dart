import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/core/config/routes.dart';
import 'package:flutter_ui_homework/core/di/auth_controller.dart';
import 'package:flutter_ui_homework/core/theme/theme.dart';
import 'package:flutter_ui_homework/core/widget/extentions.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Spacer(), //ดันให้อยู่ตรงกลางของหน้าจอ
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.red, Colors.orangeAccent], //กำหนดสีของ
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ).createShader(bounds),
                    child: Text(
                      "Qiyorie",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, //ต้องกำหนดเป็นสีขาวเพื่อให้ Shader แสดงผล
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login to your Account",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300, //ความยาวกล่อง
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _loginButton(),
                  SizedBox(height: 80),
                  Text("- Or sign in with -",
                      style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialButton("assets/google.png"),
                        SizedBox(width: 17.5),
                        _socialButton("assets/facebook.png"),
                        SizedBox(width: 17.5),
                        _socialButton("assets/x.png"),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(), //เอา "Don't have an account? Sign up" ไปข้างล่าง
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {},
                    child:
                        Text("Sign up", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor:
          WidgetStateProperty.all<Color>(Color(0xFF233097)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(color: Color(0xFF233097)),
            ),
          ),
        ),
        child: TitleText(
          text: "Sign in",
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    ).ripple(() {
      _authController.bypassLogin();
    }, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }

  Widget _socialButton(String assetPath) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        assetPath,
        width: 80,
        height: 30,
      ),
    ).ripple(() {}, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }
}
