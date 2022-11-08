// Top Rated , Now Playing
class MovieModel{
List<Movie>?movies;
 String? error;

MovieModel(this.movies, this.error);

 MovieModel.fromJson(Map<String, dynamic> json,) {
movies = (json['results'] as List).map((e) =>  Movie.fromJson(e)).toList();
error ='';
  }

}

class Movie{
  dynamic id;
  dynamic popularity;
  String? title;
  dynamic backPoster;
  dynamic poster;
  dynamic overview;
  dynamic rating;
  Movie({
     this.id,
     this.title,
     this.backPoster,
     this.overview,
     this.popularity,
     this.poster,
     this.rating,
});

  Movie.fromJson(Map<String, dynamic> json) {
      id= json["id"];
      popularity= json["popularity"];
      title= json["title"];
      backPoster= json["backdrop_path"];
      poster= json["poster_path"];
      overview= json["overview"];
      rating= json["vote_average"].toDouble();
  }
}
