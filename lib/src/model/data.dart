import 'package:flutter_ui_homework/src/model/post_in_main.dart';

class Appdata {
  static List<PostInMain> postInMainList = [
    PostInMain(
        id: 1,
        name: "viooo",
        nickname: "@violadwip",
        imageProfile: "assets/story1.jpg",
        imagePost: "assets/post1.jpg",
        detailPost: "VALORANT Masters Bangkok 2025 กำลังจะเปิดฉากที่กรุงเทพฯ โดยมี 8 ทีมสุดแกร่งจากทั่วโลกลงประชันฝีมือ เพื่อคว้าแชมป์รายการ Masters แรกของปี 2025! #VLR and #VCT",
        isLiked: false,
        isBookmark: false,
        isVerified: false,
        datePost: DateTime.parse("2025-02-01 20:05:04Z").toIso8601String(),
        isRecommand: true,
    ),
    PostInMain(
        id: 2,
        name: "aespa",
        nickname: "@aespa_official",
        imageProfile: "assets/profile_logo_aespa.jpg",
        imagePost: "assets/post2.jpg",
        detailPost: "In 2024, #aespa embarked on their 2024 to 2025 ‘SYNK: Parallel Line’ world tour across Asia and Australia. After wrapping up their Asia leg this weekend in Bangkok, Thailand, they have announced new dates in North America and Europe for early 2025.",
        isLiked: false,
        isBookmark: false,
        isVerified: true,
        datePost: DateTime.parse("2025-02-15 10:05:04Z").toIso8601String(),
        isRecommand: false
    ),
    PostInMain(
        id: 3,
        name: "NJZ",
        nickname: "@newjeans",
        imageProfile: "assets/profile_logo_njz.jpg",
        imagePost: "assets/post3.jpg",
        detailPost: '#NJZ (Korean: 엔제이지; Japanese: エンジェイジ), formerly NewJeans (뉴진스), is a five-member girl group formed by ADOR. They debuted on July 22, 2022, with the lead single "Attention", prior to the release of their debut EP New Jeans on August 1, 2022.',
        isLiked: false,
        isBookmark: false,
        isVerified: true,
        datePost: DateTime.parse("2025-02-24 05:05:04Z").toIso8601String(), //ปี เดือน วัน ชั่วโมง นาที วินาที
        isRecommand: false,
    ),
  ];
}