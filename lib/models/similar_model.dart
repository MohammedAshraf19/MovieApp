class SimilarModel {
  List<Results>? results;
  SimilarModel({this.results});

  SimilarModel.fromJson(Map<String, dynamic> json) {
      results =(json['results'] as List).map((e) =>  Results.fromJson(e)).toList();
  }

}

class Results {
  dynamic adult;
  dynamic backdropPath;
  dynamic id;
  dynamic originalLanguage;
  dynamic originalTitle;
  dynamic overview;
  dynamic popularity;
  dynamic posterPath;
  dynamic releaseDate;
  dynamic title;
  dynamic video;
  dynamic voteAverage;
  dynamic voteCount;

  Results(
      {this.adult,
        this.backdropPath,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount});

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

}
