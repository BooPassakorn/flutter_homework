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

class PostMain extends StatelessWidget {
  const PostMain({Key? key, required this.post}) : super(key: key);

  final PostInMain post;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              thickness: 1,
              height: 70,
            ),
            _profile(),
            _imagePost(),

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
                      backgroundImage: AssetImage(post.imageProfile),
                      radius: 25,
                    ),
                    if (post.isVerified)
                      Icon(Icons.verified, color: Colors.blue, size: 20),
                  ]
                ),
                SizedBox(width: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      post.nickname,
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

  Widget _imagePost (){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(post.imagePost),
      ),
    );
  }

}
