class PostInMain {
  int id;
  String name;
  String nickname;
  String imageProfile;
  String imagePost;
  String detailPost;
  bool isLiked;
  bool isBookmark;
  bool isVerified;

  PostInMain(
      {required this.id,
      required this.name,
      required this.nickname,
      required this.imageProfile,
      required this.imagePost,
      required this.detailPost,
      required this.isLiked,
      required this.isBookmark,
      required this.isVerified});
}
