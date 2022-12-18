class AppUser {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? imageURL;
  AppUser({this.email, this.name, this.phone, this.id, this.imageURL});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'imageURL': imageURL,
    };
  }

  AppUser.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    phone = map['phone'];
    email = map['email'];
    imageURL = map['imageURL'];
  }
}
