
class PostModel {
  String name;
  String uId;
  String image;
  String postVideo;
  String dateTime;
  String text;
  String postImage;
  PostModel(
      {this.name,
      this.uId,
      this.image,
      this.postVideo,
      this.dateTime,
      this.text,
      this.postImage});
  PostModel.fomJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    postVideo= json['postVideo'];
    dateTime = json['dateTime'];
    image = json['image'];
    text = json['text'];
    postImage = json['postImage'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'postVideo': postVideo,
      'dateTime': dateTime,
      'text': text,
      'postImage':postImage,
    };
  }
}
