import 'dart:convert';
import 'dart:ffi';
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
import 'package:flutter_ui_homework/constant/constant_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class UserStoryDTO {
  Uuid? uuid;
  String? user_name;
  ByteData? user_profile;
  bool? story;

  UserStoryDTO({
    this.uuid,
    this.user_name,
    this.user_profile,
    this.story,
  });

  factory UserStoryDTO.fromJsonToUserStoryDTO(Map<String, dynamic> json) => UserStoryDTO(
    uuid: json['uuid'],
    user_name: json['user_name'],
    user_profile: json['user_profile'],
    story: json['story'],
  );
}

// class userStory {
//   static const String baseUrl = (baseURL + '/story-users');
//
//   static Future<List<UserStoryDTO>> fetchStories(String uuid) async {
//     final response = await http.get(Uri.parse("$baseUrl/$uuid"));
//
//     if (response.statusCode == 200) {
//       List<dynamic> jsonList = json.decode(response.body);
//       return jsonList.map((json) => UserStoryDTO.fromJsonToUserStoryDTO(json)).toList();
//     } else {
//       return [];
//     }
//   }
// }