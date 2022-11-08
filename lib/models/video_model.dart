class VideoModel{
  List <Video>? videos;
  VideoModel(this.videos);

  VideoModel.fromJson(Map<String, dynamic> json,) {
    videos = (json['results'] as List).map((e) =>  Video.fromJson(e)).toList();
  }
}

class Video{
  dynamic id;
  dynamic key;
  dynamic name;
  dynamic site;
  dynamic type;
  Video(
      this.id,
      this.name,
      this.type,
      this.key,
      this.site
      );

  Video.fromJson(Map<String, dynamic> json) {
    id= json["id"];
    name= json["name"];
    type= json["type"];
    key= json["key"];
    site= json["site"];
  }
}