class User {
  final String name;
  final String email;
  final String no_telepon;
  final String posisi;
 

  User({required this.name, required this.email, required this.no_telepon, required this.posisi});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      no_telepon:json['no_telepon'],
      posisi: json['posisi']
    );
  }
}
