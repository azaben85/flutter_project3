class SliderModel {
  String? id;
  String title;
  String url;
  String imageURL;
  SliderModel({
    this.id,
    required this.title,
    required this.url,
    required this.imageURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'imageURL': imageURL,
    };
  }

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id'],
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      imageURL: map['imageURL'] ?? '',
    );
  }
}
