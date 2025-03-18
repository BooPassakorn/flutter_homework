class UserLanguagesDTO {
  int? language_id;

  UserLanguagesDTO({
    this.language_id  
  });

  factory UserLanguagesDTO.fromJsonToUserLanguagesDTO(Map<String, dynamic> json) => UserLanguagesDTO(
    language_id: json['language_id'],
  );
}