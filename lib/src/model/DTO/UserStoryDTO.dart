import 'dart:convert';
import 'dart:typed_data';

class UserStoryDTO {
  String? uuid;
  String? user_name;
  Uint8List? user_profile;
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
    user_profile: json['user_profile'] != null
        ? base64Decode(json['user_profile'])
        : null,
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