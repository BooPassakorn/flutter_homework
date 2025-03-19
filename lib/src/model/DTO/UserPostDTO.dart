import 'dart:convert';
import 'dart:typed_data';

class UserPostDTO {
  int? post_id;
  String? uuid;
  String? user_id;
  String? user_name;
  Uint8List? user_profile;
  bool? user_verified;
  DateTime? post_created_datetime;
  String? post_caption;
  Uint8List? post_image;
  bool? post_recommend;
  bool? post_trending;

  UserPostDTO({
    this.post_id,
    this.uuid,
    this.user_id,
    this.user_name,
    this.user_profile,
    this.user_verified,
    this.post_created_datetime,
    this.post_caption,
    this.post_image,
    this.post_recommend,
    this.post_trending,
  });

  factory UserPostDTO.fromJsonToUserPostDTO(Map<String, dynamic> json) => UserPostDTO(
        post_id: json['post_id'],
        uuid: json['uuid'],
        user_id: json['user_id'],
        user_name: json['user_name'],
        user_profile: json['user_profile'] != null
            ? base64Decode(json['user_profile'])
            : null,
        user_verified: json['user_verified'],
        post_created_datetime: DateTime.parse(json['post_created_datetime']),
        post_caption: json['post_caption'],
        post_image: json['post_image'] != null
            ? base64Decode(json['post_image'])
            : null,
        post_recommend: json['post_recommend'],
        post_trending: json['post_trending'],
      );
}