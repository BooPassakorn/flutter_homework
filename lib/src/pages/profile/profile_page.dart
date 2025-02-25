import 'package:flutter/material.dart';

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
                      child: Icon(Icons.dehaze, size: 15, color: Colors.white70),
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
                Text(
                  "@violadwip",
                  style: TextStyle(color: Colors.grey),
                ),
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
                  ),
                  child: Text("Edit Profile"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Icon(Icons.share, color: Colors.white,),
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
              indicatorColor: Colors.blue, //สีแถบด้านล่าง
              indicatorSize: TabBarIndicatorSize.tab, //ขนาดเส้นแถบด้านล่าง
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.grid_view, size: 25,),
                      SizedBox(width: 10,),
                      Text("Post", style: TextStyle(fontSize: 22),),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.account_box_outlined, size: 25,),
                      SizedBox(width: 10 ,),
                      Text("About", style: TextStyle(fontSize: 22),),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const Center(child: Text("")),
                  AboutSection(),
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

class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Basic Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey)),
            SizedBox(height: 10),
            _infoTile(Icons.person, "Gender", "Male"),
            Divider(thickness: 0.7,),
            _infoTile(Icons.calendar_today, "Birth Of Date", "10 November 2024"),
            Divider(thickness: 0.7,),
            _infoTile(Icons.message, "Languages", "Thai, English"),
            Divider(thickness: 0.7,),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blue.shade50,
        child: Icon(icon, color: Color(0xff07699d), size: 30,),
      ),
      title: Text(title, style: TextStyle(fontSize: 15, fontWeight:FontWeight.w400, color: Colors.grey),),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
      trailing: Icon(Icons.edit_outlined, color: Colors.grey[300], size: 27,),
    );
  }
}
