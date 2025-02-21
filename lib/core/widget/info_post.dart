import 'package:flutter/material.dart';

class InfoPost extends StatelessWidget {
  const InfoPost({super.key, required ScrollController scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10), // ปรับขนาดวงกลม
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black54, width: 2),
                      ),
                      child: Icon(Icons.bookmark_border, size: 30),
                    ),
                    const SizedBox(height: 10),
                    Text("บันทึก", style: TextStyle(fontSize: 18)),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10), // ปรับขนาดวงกลม
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black54, width: 2),
                      ),
                      child: Icon(Icons.qr_code_scanner, size: 30),
                    ),
                    const SizedBox(height: 10),
                    Text("คิวอาร์โค้ด", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.near_me_outlined, size: 33),
                ),
                const SizedBox(width: 10),
                Text("แชร์", style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.star_outline, size: 33),
                ),
                const SizedBox(width: 10),
                Text("เพิ่มในรายการโปรด", style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.person_remove_outlined, size: 33),
                ),
                const SizedBox(width: 10),
                Text("เลิกติดตาม", style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.info_outline, size: 33),
                ),
                const SizedBox(width: 10),
                Text("ทำไมคุณจึงเห็นฌพสต์นี้", style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.visibility_off_outlined, size: 33),
                ),
                const SizedBox(width: 10),
                Text("ซ่อน", style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.account_circle_outlined, size: 33),
                ),
                const SizedBox(width: 10),
                Text("เกี่ยวกับบัญชีนี้", style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.report_gmailerrorred,
                    color: Colors.red,
                    size: 33,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "รายงาน",
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
