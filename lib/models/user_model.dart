class UserModel {
  /// Creating the model here
  String? id;
  String phone;

  UserModel({this.id, required this.phone});

  /// fromMap() function
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toString(),
      phone: map["phone"] ?? "",
    );
  }

  /// toMap() function
  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id,
      "phone": phone
    };
  }

  ///

}
