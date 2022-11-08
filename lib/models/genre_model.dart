class GenreModel{
  List<Genres>? genres;
  GenreModel(this.genres);

  GenreModel.fromJson(Map<String, dynamic> json,) {
    genres = (json['genres'] as List).map((e) => Genres.fromJson(e)).toList();
  }
}
class Genres{
  dynamic id;
  dynamic name;
  Genres({
    this.id,
    this.name
  });

  Genres.fromJson(Map<String, dynamic> json) {
    id= json["id"];
    name= json["name"];
  }

}
