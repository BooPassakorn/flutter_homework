class Languages {
  int? language_id;
  String? language;

  Languages({
    this.language_id,
    this.language
  });

  factory Languages.fromJsonToLanguages(Map<String, dynamic> json) => Languages(
    language_id: json['language_id'],
    language: json['language']
  );
}