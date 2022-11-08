

import 'package:my_movie_app/models/genre_model.dart';

class MovieDetailsModel{
   MovieDetails? movieDetails;
  MovieDetailsModel({
    this.movieDetails,
});
   MovieDetailsModel.fromJson(Map<String, dynamic> json) {
     movieDetails = MovieDetails.fromJson(json);
   }
}


class MovieDetails{
  dynamic id;
  bool? adult;
  dynamic budget;
  List<Genres> genre=[];
  dynamic releaseDate;
  dynamic runTime;
  MovieDetails({
    this.id,
    this.adult,
    this.budget,
    required this.genre,
    this.releaseDate,
    this.runTime,
  });

  MovieDetails.fromJson(Map<String, dynamic> json) {
    id= json["id"];
    runTime= json["runtime"];
    releaseDate= json["release_date"];
    budget= json["budget"];
    adult= json["adult"];
    genre= (json['genres'] as List).map((e) =>  Genres.fromJson(e)).toList();
  }
}