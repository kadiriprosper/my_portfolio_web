class ArticleModel {
  ArticleModel({
    required this.title,
    required this.subtitle,
    required this.imgUrl,
    required this.url,
  });
  String title;
  String subtitle;
  String imgUrl;
  String url;

  factory ArticleModel.fromStorageMap(Map<String, dynamic> data) {
    return ArticleModel(
      title: data['title'],
      subtitle: data['subtitle'],
      imgUrl: data['imgUrl'],
      url: data['url'],
    );
  }

  Map<String, dynamic> toStorageMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imgUrl': imgUrl,
      'url': url,
    };
  }
}
