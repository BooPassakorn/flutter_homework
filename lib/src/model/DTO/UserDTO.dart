import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_ui_homework/constant/constant_value.dart';
import 'package:http/http.dart' as http;

class UserDTO {
  String uuid = 'a9636a92-ffbd-11ef-ac51-88a4c2321035';
  String? user_id;
  String? user_name;
  Uint8List? user_profile;
  bool? user_verified;
  String? user_introduce;
  String? user_gender;
  DateTime? user_date_of_birth;
  int? followers;
  int? following;
  int? post;
  bool? story;

  UserDTO({
    required this.uuid,
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
    user_profile: json['user_profile'] != null
        ? base64Decode(json['user_profile'])
        : null,
    user_verified: json['user_verified'],
    user_introduce: json['user_introduce'],
    user_gender: json['user_gender'],
    user_date_of_birth: DateTime.parse(json['user_date_of_birth']),
    followers: json['followers'],
    following: json['following'],
    post: json['post'],
    story: json['story'],
  );

  Future<void> updateGender(String user_gender) async {
    final response = await http.put(
      Uri.parse('$baseURL/api/user/update-gender'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'uuid': uuid, 'user_gender': user_gender}),
    );

    if (response.statusCode == 200) {
      final updatedData = jsonDecode(response.body) as Map<String, dynamic>;
      this.user_gender = updatedData['updatedGender']['user_gender'];
    } else {
      throw Exception('Failed to update gender');
    }
  }
}

  // static Future<UserDTO> fetchUser() async {
  //   final response = await http.get(
  //     Uri.parse('$baseURL/api/user/all-user/$uuid'),
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final userData = jsonDecode(response.body) as Map<String, dynamic>;
  //     return UserDTO.fromJsonToUserDTO(userData);
  //   } else {
  //     throw Exception('Failed to load user data');
  //   }
  // }

  // static Future<UserDTO> fetchUser() async {
  //   final response = await http.get(
  //     Uri.parse('$baseURL/api/user/all-user/$uuid'),
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final userData = jsonDecode(response.body) as Map<String, dynamic>;
  //     return UserDTO.fromJsonToUserDTO(userData);
  //   } else {
  //     throw Exception('Failed to load user data');
  //   }
  // }

  // static Future<UserDTO> _fetchAllStoryUser() async {
  //   try {
  //     final url = Uri.parse('$baseURL/api/user/all-user/$uuid');
  //     http.Response response = await http.get(url);
  //
  //     if (response.statusCode == 200) {
  //       List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
  //
  //       final userData = jsonDecode(response.body) as Map<String, dynamic>;
  //       return UserDTO.fromJsonToUserDTO(userData);
  //     } else {
  //       print('Server responded with status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching posts: $e');
  //   }
  // }

