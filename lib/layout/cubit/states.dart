

import '../../models/similar_model.dart';

abstract class MovieStates{}
class MovieInit extends MovieStates{}

class GetMovieLoading extends MovieStates{}
class GetMovieSuccess extends MovieStates{}
class GetMovieError extends MovieStates{
  String error;
  GetMovieError({required this.error});
}

class GetUserDataLoading extends MovieStates{}
class GetUserDataSuccess extends MovieStates{}
class GetUserDataError extends MovieStates{}

class GetPlayingMovieLoading extends MovieStates{}
class GetPlayingMovieSuccess extends MovieStates{}
class GetPlayingMovieError extends MovieStates{}

class GetGenreLoading extends MovieStates{}
class GetGenreSuccess extends MovieStates{}
class GetGenreError extends MovieStates{}

class GetPersonLoading extends MovieStates{}
class GetPersonSuccess extends MovieStates{}
class GetPersonError extends MovieStates{}

class GetMovieByGenreLoading extends MovieStates{}
class GetMovieByGenreSuccess extends MovieStates{}
class GetMovieByGenreError extends MovieStates{}

class GetMovieDetailsLoading extends MovieStates{}
class GetMovieDetailsSuccess extends MovieStates{}
class GetMovieDetailsError extends MovieStates{}


class GetMovieCastSuccess extends MovieStates{}
class GetMovieCastError extends MovieStates{}

class GetMovieSimilarError extends MovieStates{}


class GetMovieVideoError extends MovieStates{}

class GetMovieDataSuccess extends MovieStates{}
class PressSuccess extends MovieStates{
  int id;
  Results results;
  PressSuccess({required this.id,required this.results});
}

class GetMovieSearchLoading extends MovieStates{}
class GetMovieSearchSuccess extends MovieStates{}
class GetMovieSearchError extends MovieStates{}


class GetMoviePopularError extends MovieStates{}
class GetMoviePopularSuccess extends MovieStates{}


class MovieProfileImagePickedSuccessState extends MovieStates{}
class MovieProfileImagePickedErrorState extends MovieStates{}

class MovieUpdateProfileLoadingState extends MovieStates{}
class MovieUpdateProfileSuccessState extends MovieStates{}
class MovieUpdateProfileErrorState extends MovieStates{}
