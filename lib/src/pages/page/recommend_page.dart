import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_ui_homework/constant/constant_value.dart';
import 'package:flutter_ui_homework/core/widget/info_post.dart';
import 'package:flutter_ui_homework/src/model/DTO/UserPostDTO.dart' show UserPostDTO;
import 'package:http/http.dart' as http;

class RecommandPage extends StatefulWidget {
  const RecommandPage({super.key});

  @override
  _RecommandPageState createState() => _RecommandPageState();
}

class _RecommandPageState extends State<RecommandPage> {
  List<UserPostDTO> posts = [];
  String searchQuery = "";
  bool isFirstRecommend = true;
  bool isFirstTrending = true;

  @override
  void initState() {
    super.initState();
    _fetchAllUserPost();
  }

  Future<void> _fetchAllUserPost() async {
    try {
      final url = Uri.parse('$baseURL/api/post/get-all-user-post');
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));

        setState(() {
          posts = jsonData.map((json) => UserPostDTO.fromJsonToUserPostDTO(json)).toList();
        });
      } else {
        print('Server responded with status: $response');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    final filteredPosts = posts.where((post) {
      return post.post_caption != null && post.post_caption!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    final recommendPosts = filteredPosts.where((post) => post.post_recommend ?? false).toList();
    final normalPosts = filteredPosts.where((post) => post.post_trending ?? false).toList();

    final mergePosts = [...recommendPosts, ...normalPosts];

    final firstRecommendIndex = recommendPosts.isNotEmpty ? mergePosts.indexOf(recommendPosts.first) : -1;
    final firstNormalIndex = normalPosts.isNotEmpty ? mergePosts.indexOf(normalPosts.first) : -1;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Find what you're looking for",
              prefixIcon: Icon(Icons.search, color: Colors.black),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 13),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
        ),
      ),
      body: posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: mergePosts.length,
        itemBuilder: (context, index) {
          final post = mergePosts[index];
          if (post.post_recommend ?? false) {
            return PostRecommand(post: post, isFirst: isFirstRecommend && index == firstRecommendIndex);
          } else {
            return PostNormal(post: post, isFirst: isFirstTrending && index == firstNormalIndex);
          }
        },
      ),
    );
  }
}


class PostRecommand extends StatefulWidget {
  const PostRecommand({super.key, required this.post,required this.isFirst});

  final UserPostDTO post;
  final bool isFirst;

  @override
  State<PostRecommand> createState() => _PostRecommandState();
}

class _PostRecommandState extends State<PostRecommand>
    with TickerProviderStateMixin {

  bool isLiked = false;
  bool isBookmark = false;

  bool isLikedRecommand = false;
  bool isDislikedRecommand = false;

  int favoriteCount = 0;
  int bookmarkCount = 0;

  bool postRecommend = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            widget.isFirst?
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 27),
                  SizedBox(width: 10),
                  Text(
                    "Recommended For you",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ):SizedBox(),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 15,
                  right: 10,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _profile(),
                    _imagePost(),
                    _detailPost(),
                    _iconPosts(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            _iconLikeAndDisLike(),
            SizedBox(height: 10),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _profile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Stack(
            alignment: Alignment(1, 1.2),
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: widget.post.user_profile is Uint8List ? MemoryImage(widget.post.user_profile as Uint8List) : null,
              ),
              if (widget.post.user_verified != false)
                Icon(Icons.verified, color: Colors.blue, size: 20),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.post.user_name as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.post.user_id as String,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              Text(() {
                Duration diff = DateTime.now().difference(widget.post.post_created_datetime as DateTime);
                if (diff.inMinutes < 1) {
                  return "Just now";
                } else if (diff.inMinutes < 60) {
                  return "${diff.inMinutes} mins ago";
                } else if (diff.inHours < 24) {
                  return "${diff.inHours} hours ago";
                } else {
                  return "${diff.inDays} days ago";
                }
              }(), style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: _showOption,
            icon: const Icon(Icons.more_horiz),
          ),
        ],
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
          child: widget.post.post_image is Uint8List ? Image.memory(widget.post.post_image as Uint8List) : null
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
      child: _makeColorHashtag(widget.post.post_caption as String),
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
          _iconButton(Icons.chat_bubble_outline, Colors.grey, "0", () {}),
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

  Widget _iconLikeAndDisLike() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Does this suggestion appeal to you?",
            style: TextStyle(
              color: Color(0xff07699d),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          IconButton(
            icon: Icon(
              isLikedRecommand ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
              color: isLikedRecommand ? Color(0xff07699d) : Color(0xff07699d),
            ),
            onPressed: () {
              setState(() {
                isLikedRecommand = !isLikedRecommand;
                if (isLikedRecommand) isDislikedRecommand = false;
              });
            },
          ),
          IconButton(
            icon: Icon(
              isDislikedRecommand ? Icons.thumb_down : Icons.thumb_down_alt_outlined,
              color: isDislikedRecommand ? Color(0xff07699d) : Color(0xff07699d),
            ),
            onPressed: () {
              setState(() {
                isDislikedRecommand = !isDislikedRecommand;
                if (isDislikedRecommand) isLikedRecommand = false;
              });
            },
          ),
        ],
      ),
    );
  }
}

class PostNormal extends StatefulWidget {

  const PostNormal({super.key, required this.post, required this.isFirst});

  final UserPostDTO post;
  final bool isFirst;

  @override
  State<PostNormal> createState() => _PostNormalState();
}

class _PostNormalState extends State<PostNormal> {
  bool isLiked = false;
  bool isBookmark = false;

  int favoriteCount = 0;
  int bookmarkCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          widget.isFirst?
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.explore_rounded, color: Color(0xff07699d), size: 27),
                SizedBox(width: 10),
                Text(
                  "Trending Post",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ):SizedBox(),
          SizedBox(height: 10),
          _profile(),
          _imagePost(),
          _detailPost(),
          _iconPosts(),
          SizedBox(height: 10),
          Divider(),
        ],
      ),
    );
  }

  Widget _profile() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment(1, 1.2),
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: widget.post.user_profile is Uint8List ? MemoryImage(widget.post.user_profile as Uint8List) : null,
                  ),
                  if (widget.post.user_verified != false)
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
                        widget.post.user_name as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.post.user_id as String,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(() {
                    Duration diff = DateTime.now().difference(widget.post.post_created_datetime as DateTime);
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
          child: widget.post.post_image is Uint8List ? Image.memory(widget.post.post_image as Uint8List) : null
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
      child: _makeColorHashtag(widget.post.post_caption as String),
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
          _iconButton(Icons.chat_bubble_outline, Colors.grey, "0", () {}),
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