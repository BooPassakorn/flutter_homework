class User_Languages {
  int? language_id;
  String? uuid;

  User_Languages({
    this.language_id,
    this.uuid
  });

  factory User_Languages.fromJsonToUser_Languages(Map<String, dynamic> json) => User_Languages(
    language_id: json['language_id'],
    uuid: json['uuid']
  );
}