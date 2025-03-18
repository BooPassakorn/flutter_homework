class SearchPostDTO {
  String? post_caption;

  SearchPostDTO({
    this.post_caption
  });

  factory SearchPostDTO.fromJsonToSearchPostDTO(Map<String, dynamic> json) => SearchPostDTO(
    post_caption: json['post_caption'],
  );
}