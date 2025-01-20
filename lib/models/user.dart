class User {
  final String uid;
  final String name;
  final String email;
  final bool online;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.online,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      online: json['online'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'online': online,
    };
  }
}
