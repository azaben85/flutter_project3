class OrderItem {
  int? lineNumber;
  String? itemId;
  String? catName;
  String nameEn;
  String descEn;
  String imageUrl;
  int quantity;
  num price;
  OrderItem({
    this.lineNumber,
    this.itemId,
    this.catName,
    required this.nameEn,
    required this.descEn,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'lineNumber': lineNumber,
      'catName': catName,
      'nameEn': nameEn,
      'descEn': descEn,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      lineNumber: map['lineNumber']?.toInt(),
      catName: map['catName'],
      nameEn: map['nameEn'] ?? '',
      descEn: map['descEn'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      price: map['price'] ?? 0,
    );
  }
}
