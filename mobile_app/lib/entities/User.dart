class User {
  int? id;
  String? email;
  String? username;
  String? image;

  User({
    required this.id,
    required this.email,
    required this.username,
    this.image,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    data['image'] = image;
    return data;
  }
}
