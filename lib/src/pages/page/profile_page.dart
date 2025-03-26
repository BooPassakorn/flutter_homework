import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/constant/constant_value.dart';
import 'package:flutter_ui_homework/src/model/DTO/UpdateLanguageRequestDTO.dart' show UpdateLanguageRequestDTO;
import 'package:flutter_ui_homework/src/model/DTO/UserDTO.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none, //ป้องกันการตัดภาพ
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/wallpaper2.jpg',
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 50, //ตำแหน่งด้านบน
                  right: 30, //ตำแหน่งทางขวา
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black12,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.dehaze,
                        size: 15,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/story1.jpg',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "viooo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
                Text("@violadwip", style: TextStyle(color: Colors.grey)),
                SizedBox(width: 5),
                Icon(Icons.verified, color: Colors.blue, size: 18),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Hello My name is Hello world nice to meet you",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    elevation: 0,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(150, 55),
                  ),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(color: Color(0xff07699d), fontSize: 17),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff07699d),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(20, 55),
                  ),
                  child: Icon(Icons.share, color: Colors.white, size: 17),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileStat(label: "Post", value: "21"),
                ProfileStat(label: "Followers", value: "1,904"),
                ProfileStat(label: "Following", value: "614"),
              ],
            ),
            Divider(),
            TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.grid_view, size: 25),
                      SizedBox(width: 10),
                      Text("Post", style: TextStyle(fontSize: 22)),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.account_box_outlined, size: 25),
                      SizedBox(width: 10),
                      Text("About", style: TextStyle(fontSize: 22)),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const Center(child: Text("")),
                  AboutSection(
                    user: UserDTO(uuid: 'a9636a92-ffbd-11ef-ac51-88a4c2321035'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String label;
  final String value;

  const ProfileStat({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(color: Colors.black)),
      ],
    );
  }
}

class AboutSection extends StatefulWidget {
  final UserDTO user;

  const AboutSection({Key? key, required this.user}) : super(key: key);

  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  late Future<UpdateLanguageRequestDTO> futureUpdateLangugae;
  late Future<UserDTO> futureUser;
  late String selectedGender ;

  bool isThaiSelected = false;
  bool isEnglishSelected = false;
  bool isChineseSelected = false;
  Set<String> selectedLanguages = {};

  UserDTO? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUser();
    selectedGender = "Loading...";
  }

  Future<void> _fetchUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.parse('$baseURL/api/user/all-user/a9636a92-ffbd-11ef-ac51-88a4c2321035',);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));

        if (jsonData != null && jsonData is Map && jsonData.containsKey('users')) {
          var userData = jsonData['users'][0];

          setState(() {
            user = UserDTO(
              uuid: userData['uuid'],
              user_gender: userData['user_gender'],
            );
            selectedGender = user?.user_gender ?? "Not";
            isLoading = false;
          });
        }
      } else {
        print('Error: Server responded with status code ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> updateGender(String gender) async {
    final url = Uri.parse('$baseURL/api/user/update-gender');
    final response = await http.put(
      url,
      body: jsonEncode({
        'uuid': user?.uuid ?? 'a9636a92-ffbd-11ef-ac51-88a4c2321035',
        'user_gender': gender,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse != null && jsonResponse.containsKey('updatedGender')) {
        setState(() {
          user?.user_gender = jsonResponse['updatedGender']['gender'];
        });
        return true;
      }
    } else {
      print("Failed to update gender. Status code: ${response.statusCode}");
    }
    return false;
  }

  void _updateGender(String gender) async {
    bool success = await updateGender(gender);
    if (success) {
      await _fetchUser();
    }
  }

  void _selectGender() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Male"),
                leading: Radio<String>(
                  value: "male",
                  groupValue: selectedGender,
                  onChanged: (value) async {
                    Navigator.pop(context);
                    _updateGender(value!);
                  },
                ),
              ),
              ListTile(
                title: Text("Female"),
                leading: Radio<String>(
                  value: "female",
                  groupValue: selectedGender,
                  onChanged: (value) async {
                    Navigator.pop(context);
                    _updateGender(value!);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectedLanguage() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    value: selectedLanguages.contains('Thai'),
                    title: Text('Thai'),
                    onChanged: (bool? value) {
                      setModalState(() {
                        if (value == true) {
                          selectedLanguages.add('Thai');
                        } else {
                          selectedLanguages.remove('Thai');
                        }
                      });
                      setState(() {}); //
                    },
                  ),
                  CheckboxListTile(
                    value: selectedLanguages.contains('English'),
                    title: Text('English'),
                    onChanged: (bool? value) {
                      setModalState(() {
                        if (value == true) {
                          selectedLanguages.add('English');
                        } else {
                          selectedLanguages.remove('English');
                        }
                      });
                      setState(() {});
                    },
                  ),
                  CheckboxListTile(
                    value: selectedLanguages.contains('Chinese'),
                    title: Text('Chinese'),
                    onChanged: (bool? value) {
                      setModalState(() {
                        if (value == true) {
                          selectedLanguages.add('Chinese');
                        } else {
                          selectedLanguages.remove('Chinese');
                        }
                      });
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Confirm'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Basic Information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
              ),
              SizedBox(height: 10),

              _infoTile(Icons.person, "Gender", selectedGender,
                IconButton(
                  onPressed: () => _selectGender(),
                  icon: Icon(Icons.edit_outlined, color: Colors.grey[300], size: 27),
                ),
              ),
              Divider(thickness: 0.7),
              _infoTile(
                Icons.message,
                "Birth Of Date",
                "01 MAY 2003",
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.grey[300],
                    size: 27,
                  ),
                ),
              ),
              Divider(thickness: 0.7),
              _infoTile(
                Icons.message,
                "Languages",
                "Thai, English",
                IconButton(
                  onPressed: () => _selectedLanguage(),
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.grey[300],
                    size: 27,
                  ),
                ),
              ),
              Divider(thickness: 0.7),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(
      IconData icon,
      String title,
      String subtitle,
      IconButton icons,
      ) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blue.shade50,
        child: Icon(icon, color: Color(0xff07699d), size: 30),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      trailing: icons,
    );
  }
}
