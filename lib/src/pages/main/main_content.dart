import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/core/widget/info_post.dart';
import 'package:flutter_ui_homework/src/model/data.dart';
import 'package:flutter_ui_homework/src/model/post_in_main.dart';

class MainContent extends StatelessWidget {
  MainContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Appdata.postInMainList.length,
      itemBuilder: (context, index) {
        final post = Appdata.postInMainList[index];
        return PostMain(post: post);
      },
    );
  }
}

class PostMain extends StatefulWidget {
  const PostMain({Key? key, required this.post}) : super(key: key);

  final PostInMain post;

  @override
  _PostMainState createState() => _PostMainState();
}

class _PostMainState extends State<PostMain> {
  late bool isLiked;
  late bool isBookmark;

  int favoriteCount = 0;
  int bookmarkCount = 0;

  @override
  void initState() {
    super.initState();
    isLiked = widget.post.isLiked;
    isBookmark = widget.post.isBookmark;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(thickness: 1, height: 70),
            _profile(),
            _imagePost(),
            _detailPost(),
            _iconPosts(),
          ],
        ),
      ),
    );
  }

  Widget _profile() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      shadowColor: Colors.white,
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment(1, 1.2),
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(widget.post.imageProfile),
                      radius: 25,
                    ),
                    if (widget.post.isVerified)
                      Icon(Icons.verified, color: Colors.blue, size: 20),
                  ],
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.post.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.post.nickname,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(() {
                      Duration diff = DateTime.now().difference(widget.post.datePostAsDateTime);
                      if (diff.inMinutes < 1) {
                        return "Just now";
                      } else if (diff.inMinutes < 60) {
                        return "${diff.inMinutes} mins ago";
                      } else if (diff.inHours < 24) {
                        return "${diff.inHours} hours ago";
                      } else {
                        return "${diff.inDays} days ago";
                      }
                    }(), style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: (_showOption),
                  icon: Icon(Icons.more_horiz),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOption() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, //ทำให้เต็มจอ
      builder:
          (ctx) => DraggableScrollableSheet(
            expand: false, //ไม่ใส่ false จะเต็มจอ
            initialChildSize: 0.67,
            builder: (_, controller) => InfoPost(scrollController: controller),
          ),
    );
  }

  Widget _imagePost() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(widget.post.imagePost),
      ),
    );
  }

  Widget _makeColorHashtag(String text) {
    List<TextSpan> spans = [];
    RegExp regExp = RegExp(
      r"(#[^\s]+)",
    ); //ตรวจคำที่มี # นำหน้า ความหมาย # ต้องมี # เป็นตัวแรก [^\s]+ หมายถึงตัวอักษรที่ไม่ใช่ช่องว่าง (\s) อย่างน้อย 1 ตัวขึ้นไป
    Iterable<RegExpMatch> matches = regExp.allMatches(
      text,
    ); //allMatches(text) ค้นหาทุกคำที่ตรงกับ RegExp ที่อยู่ใน text คืนค่ามาเป็น Iterable ที่จะเก็บข้อมูลเกี่ยวกับการจับคู่แต่ละคำ

    int lastIndex =
        0; //ไว้เก็บตำแหน่งสุดท้ายข้อความที่่ถูกตรวจแล้ว เอาไปใช้เพื่อตัดข้อความที่ไม่มี # ออก
    for (RegExpMatch match in matches) {
      if (match.start > lastIndex) {
        //match.start ตำแหน่งเริ่มต้นของ # ใน text || lastIndex ตำแหน่งข้อความก่อนหน้า ถ้ามีข้อความอยู่ก่อนหน้า # จะถูกนำมาใส่ spans และสีจะไม่เปลี่ยน
        spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
      }
      spans.add(
        TextSpan(
          text: match.group(0), //ดึง # ออกมา
          style: TextStyle(color: Colors.blue), //กำหนด # ให้เป็นสีฟ้า
        ),
      );
      lastIndex =
          match
              .end; //กำหนด lastIndex ให้เป็นตำแหน่งที่ # จบลง ใช้ตัดข้อความที่เหลือ
    }

    if (lastIndex < text.length) {
      //ตรวจสอบว่ามีข้อความที่ยังไม่ได้แสดงหลัง # สุดท้าย ถ้ามี จะถูกเพิ่มใน spans
      spans.add(TextSpan(text: text.substring(lastIndex)));
    }

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 15),
        children: spans,
      ),
    );
  }

  Widget _detailPost() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: _makeColorHashtag(widget.post.detailPost),
      // child: Text(
      //   widget.post.detailPost,
      //   style: TextStyle(fontSize: 15),
      // ),
    );
  }

  Widget _iconPosts() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconButton(Icons.mode_comment_outlined, Colors.grey, "0", () {}),
          _iconButton(
            isLiked ? Icons.favorite : Icons.favorite_outline,
            isLiked ? Colors.red : Colors.grey,
            "$favoriteCount",
            () {
              setState(() {
                isLiked = !isLiked;
                favoriteCount += isLiked ? 1 : -1;
              });
            },
          ),
          _iconButton(
            isBookmark ? Icons.bookmark : Icons.bookmark_border,
            isBookmark ? Color(0xff07699d) : Colors.grey,
            "$bookmarkCount",
            () {
              setState(() {
                isBookmark = !isBookmark;
                bookmarkCount += isBookmark ? 1 : -1;
              });
            },
          ),
          _iconButton(Icons.file_upload_outlined, Colors.grey, "0", () {}),
        ],
      ),
    );
  }

  Widget _iconButton(
    IconData icon,
    Color color,
    String text,
    VoidCallback onPressed,
  ) {
    return Row(
      children: [
        IconButton(onPressed: onPressed, icon: Icon(icon, color: color)),
        Text(text),
      ],
    );
  }
}
