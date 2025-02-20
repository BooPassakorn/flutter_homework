import 'package:flutter/material.dart';
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                Spacer(),
                Icon(Icons.more_horiz),
              ],
            ),
          ],
        ),
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

  Widget _getColoredHashtagText(String text) {
    if (text.contains('#')) {
      var preHashtag = text.substring(0, text.indexOf('#'));
      var postHashtag = text.substring(text.indexOf('#'));
      var hashTag = postHashtag;
      var other;
      if (postHashtag.contains(' ')) {
        hashTag = postHashtag.substring(0, postHashtag.indexOf(' '));
        other = postHashtag.substring(postHashtag.indexOf(' '));
      }
      return RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(text: preHashtag),
            TextSpan(text: hashTag, style: TextStyle(color: Colors.blue)),
            TextSpan(text: other != null ? other : ""),
          ],
        ),
      );
    } else {
      return Text(text);
    }
  }

  Widget _detailPost() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: _getColoredHashtagText(widget.post.detailPost),
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
          _iconButton(Icons.mode_comment_outlined, Colors.grey, "21", () {}),
          _iconButton(
            isLiked ? Icons.favorite : Icons.favorite_outline,
            isLiked ? Colors.red : Colors.grey,
            "99",
            () {
              setState(() {
                isLiked = !isLiked;
              });
            },
          ),
          _iconButton(
            isBookmark ? Icons.bookmark : Icons.bookmark_border,
            isBookmark ? Color(0xff07699d) : Colors.grey,
            "12",
            () {
              setState(() {
                isBookmark = !isBookmark;
              });
            },
          ),
          _iconButton(Icons.file_upload_outlined, Colors.grey, "12", () {}),
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
