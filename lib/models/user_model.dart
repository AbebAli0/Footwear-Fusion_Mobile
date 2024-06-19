class UserModel {
  final int id;
  final String name;
  final String email;
  final String username;
  final String image;
  final String remember_token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.image,
    required this.remember_token,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        username = json['username'],
        image = json['image'],
        remember_token = json['remember_token'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'image': image,
      'remember_token': remember_token,
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? username,
    String? image,
    String? remember_token,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      image: image ?? this.image,
      remember_token: remember_token ?? this.remember_token,
    );
  }
}
