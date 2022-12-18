class Category {
  String imageUrl;
  String nameAr;
  String nameEn;
  String? id;
  Category({
    required this.nameEn,
    this.id,
    required this.imageUrl,
    required this.nameAr,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'nameAr': nameAr,
      'nameEn': nameEn,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      imageUrl: map['imageUrl'] ?? '',
      nameAr: map['nameAr'] ?? '',
      nameEn: map['nameEn'] ?? '',
      id: map['id'] ?? '',
    );
  }
}
