class SocialUserModel {
  String name;
  String email;
  String phone;
  String uId;
  String image;
  String cover;
  dynamic bio;
  dynamic password;
  bool isEmailVerified;
  SocialUserModel(
      {this.email,
      this.name,
      this.phone,
      this.uId,
      this.isEmailVerified,
      this.image,
      this.bio,
      this.cover,
      this.password});
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    password = json['password'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'cover': cover,
      'password': password,
      'bio': bio,
      'isEmailVerified': isEmailVerified
    };
  }
}
