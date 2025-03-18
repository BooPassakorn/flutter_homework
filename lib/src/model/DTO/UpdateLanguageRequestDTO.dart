import 'package:flutter_ui_homework/src/model/DTO/UserLanguagesDTO.dart';
import 'package:uuid/uuid.dart';

class UpdateLanguageRequestDTO {
  List<UserLanguagesDTO>? languages;
  Uuid? uuid;

  UpdateLanguageRequestDTO({
    this.languages,
    this.uuid
  });

  factory UpdateLanguageRequestDTO.fromJsonToUpdateLanguageRequestDTO(Map<String, dynamic> json) => UpdateLanguageRequestDTO(
    languages: json['languages'],
    uuid: json['uuid'],
  );
}