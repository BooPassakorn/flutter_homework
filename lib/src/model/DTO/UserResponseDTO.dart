import 'package:flutter_ui_homework/src/model/DTO/UserDTO.dart';
import 'package:flutter_ui_homework/src/model/DTO/UserLanguagesDTO.dart';

class UserResponseDTO {
  List<UserDTO>? users;
  List<UserLanguagesDTO>? languages;

  UserResponseDTO({
    this.users,
    this.languages
  });

  factory UserResponseDTO.fromJsonToUserResponseDTO(Map<String, dynamic> json) => UserResponseDTO(
    users: json['users'],
    languages: json['languages']
  );
}