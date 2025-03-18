import 'package:flutter_ui_homework/src/model/DTO/UserLanguagesDTO.dart';

class UpdateLanguageRequestDTO {
  List<UserLanguagesDTO>? languages;
  String? uuid;

  UpdateLanguageRequestDTO({
    this.languages,
    this.uuid
  });

  factory UpdateLanguageRequestDTO.fromJsonToUpdateLanguageRequestDTO(Map<String, dynamic> json) => UpdateLanguageRequestDTO(
    languages: json['languages'],
    uuid: json['uuid'],
  );
}