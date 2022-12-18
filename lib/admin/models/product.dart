class Product {
  String? id;
  String? catId;
  String nameAr;
  String nameEn;
  String descAr;
  String descEn;
  String imageUrl;
  num price;
  Product({
    this.id,
    this.catId,
    required this.nameAr,
    required this.nameEn,
    required this.descAr,
    required this.descEn,
    required this.imageUrl,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'catId': catId,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'descAr': descAr,
      'descEn': descEn,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      catId: map['catId'] ?? '',
      nameAr: map['nameAr'] ?? '',
      nameEn: map['nameEn'] ?? '',
      descAr: map['descAr'] ?? '',
      descEn: map['descEn'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price'] ?? 0.0,
    );
  }
}
