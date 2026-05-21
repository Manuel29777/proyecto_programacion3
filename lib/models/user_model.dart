class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String city;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      city: json['address']['city'],
    );
  }
}
