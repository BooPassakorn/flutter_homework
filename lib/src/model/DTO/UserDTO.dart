import 'dart:ffi';
import 'dart:typed_data';

class UserDTO {
  String? uuid;
  String? user_id;
  String? user_name;
  Uint8List? user_profile;
  bool? user_verified;
  String? user_introduce;
  String? user_gender;
  DateTime? user_date_of_birth;
  Long? followers;
  Long? following;
  Long? post;
  bool? story;

  UserDTO({
    this.uuid,
    this.user_id,
    this.user_name,
    this.user_profile,
    this.user_verified,
    this.user_introduce,
    this.user_gender,
    this.user_date_of_birth,
    this.followers,
    this.following,
    this.post,
    this.story
  });

  factory UserDTO.fromJsonToUserDTO(Map<String, dynamic> json) => UserDTO(
    uuid: json['uuid'],
    user_id: json['user_id'],
    user_name: json['user_name'],
    user_profile: json['user_profile'],
    user_verified: json['user_verified'],
    user_introduce: json['user_introduce'],
    user_gender: json['user_gender'],
    user_date_of_birth: json['user_date_of_birth'],
    followers: json['followers'],
    following: json['following'],
    post: json['post'],
    story: json['story'],
  );
}