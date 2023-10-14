class CommerceSettingsModel {
  String? id;
  String? whatsappNumber;
  num? shippingValue;
  CommerceSettingsModel({
    this.id,
    this.whatsappNumber,
    this.shippingValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'whatsappNumber': whatsappNumber,
      'shippingValue': shippingValue,
    };
  }

  factory CommerceSettingsModel.fromMap(Map<String, dynamic> map) {
    return CommerceSettingsModel(
      id: map['id'],
      whatsappNumber: map['whatsappNumber'],
      shippingValue: map['shippingValue'],
    );
  }
}
