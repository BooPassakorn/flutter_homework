import 'dart:ffi';
import 'dart:typed_data';

class Post{
  int? post_id;
  DateTime? post_created_datetime;
  String? post_caption;
  ByteData? post_image;
  bool? post_recommend;
  bool? post_trending;

  Post ({
    this.post_id,
    this.post_created_datetime,
    this.post_caption,
    this.post_image,
    this.post_recommend,
    this.post_trending
  });

  factory Post.fromJsonToPost(Map<String, dynamic> json)  => Post(
    post_id: json['post_id'],
    post_created_datetime: json['post_created_datetime'],
    post_caption: json['post_caption'],
    post_image: json['post_image'],
    post_recommend: json['post_recommend'],
    post_trending: json['post_trending'],
  );
}