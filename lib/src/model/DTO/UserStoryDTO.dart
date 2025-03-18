import 'dart:ffi';
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:uuid/uuid.dart';

class UserStoryDTO {
  Uuid? uuid;
  String? user_name;
  ByteData? user_profile;
  Bool? story;

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