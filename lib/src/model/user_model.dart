class User {
  int? id;
  String? username;
  String? bio;
  String? profilePic;
  String? profilepic;

  User({this.id, this.username, this.bio, this.profilePic});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    bio = json['bio'];
    profilePic = json['profilePic'];
    profilepic = json['profile_pic'] ?? json['profilepic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['bio'] = bio;
    data['profilePic'] = profilePic;
    data['profile_pic'] = profilepic;
    return data;
  }
}
