import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_movie_app/layout/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../models/cast_model.dart';
import '../../models/genre_model.dart';
import '../../models/movie_details.dart';
import '../../models/movie_model.dart';
import '../../models/person_model.dart';
import '../../models/similar_model.dart';
import '../../models/user_model.dart';
import '../../models/video_model.dart';
import '../../modules/movies/movie_similar_details.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/remote/dio_helper.dart';


class MovieCubit extends Cubit<MovieStates>{
  MovieCubit() : super(MovieInit());
  static MovieCubit get(context)=>BlocProvider.of(context);



  MovieModel? movieModel ;
  void getMovies(){
    emit(GetMovieLoading());
    DioHelperMovie.getData(
        url: getTopMovieUrl,
    ).then((value) {
      movieModel = MovieModel.fromJson(value.data);
      getPopularMovie();
      getGenre();
      getPlayMovies();
      getPersons();
      emit(GetMovieSuccess());
    }).catchError((error){
      emit(GetMovieError(error: error.toString()));
    });
  }

  UserModel? userModel ;
  void getUserData(){
    emit(GetUserDataLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccess());
    })
        .catchError((error){
      emit(GetUserDataError());
    });
  }


  MovieModel? popularMovie ;
  void getPopularMovie(){
    DioHelperMovie.getData(
      url: getPopularMovieUrl,
    ).then((value) {
      popularMovie = MovieModel.fromJson(value.data);
      emit(GetMoviePopularSuccess());
    }).catchError((error){
      emit(GetMoviePopularError());
    });
  }

  MovieModel? playMovie;
  void getPlayMovies(){
    DioHelperMovie.getData(
        url: getPlayingUrl,
    ).then((value) {
      playMovie = MovieModel.fromJson(value.data);
    })
        .catchError((error){
          emit(GetPlayingMovieError());
    });
  }

  GenreModel? genreModel;
  void getGenre(){
    DioHelperMovie.getData(
        url: getGenresUrl
    ).then((value) {
      genreModel = GenreModel.fromJson(value.data);
    })
        .catchError((error){
          emit(GetGenreError());
    });
  }

  PersonModel? personModel;
  void getPersons(){
    DioHelperMovie.getData(
        url: getPersonUrl
    ).then((value) {
      personModel = PersonModel.fromJson(value.data);
      emit(GetPersonSuccess());
    })
        .catchError((error){
      emit(GetPersonError());
    });
  }


  MovieModel? movieByGenre;
  void getMovieByGenre(int id){
    emit(GetMovieByGenreLoading());
    DioHelperMovie.getDataUseId(
        url:getMoviesUrl,
        id: id
    )
        .then((value) {
          movieByGenre = MovieModel.fromJson(value.data);
          emit(GetMovieByGenreSuccess());
    })
        .catchError((error){
          emit(GetMovieByGenreError());
    });
  }




  MovieDetailsModel? movieDetailsModel;
  void getMovieDetails(int id){
    emit(GetMovieDetailsLoading());
    DioHelperMovie.getDataMovieId(
        url: getMovieDetailsUrl,
      id: id
    ).then((value) {
      movieDetailsModel = MovieDetailsModel.fromJson(value.data);
     getMovieSimilar(id);
     getMovieVideo(id);
     getMovieCast(id);
      emit(GetMovieDetailsSuccess());
    })
        .catchError((error){
      emit(GetMovieDetailsError());
    });
  }
  CastModel? castModel;
  void getMovieCast(int id){
    DioHelperMovie.getDataCastId(
        url: getMovieDetailsUrl,
        id: id,
    ).then((value) {
      castModel = CastModel.fromJson(value.data);
      emit(GetMovieCastSuccess());
    })
        .catchError((error){
      emit(GetMovieCastError());
    });
  }
  SimilarModel? movieSimilarModel;
  void getMovieSimilar(int id){
    DioHelperMovie.getDataSimilarId(
        url: getMovieDetailsUrl,
        id: id
    ).then((value) {
      movieSimilarModel = SimilarModel.fromJson(value.data);
    })
        .catchError((error){
      emit(GetMovieSimilarError());
    });
  }
  VideoModel? videoModel;
  void getMovieVideo(int id){
    DioHelperMovie.getDataVideo(
        url: getMovieDetailsUrl,
        id: id
    ).then((value) {
      videoModel = VideoModel.fromJson(value.data);
    })
        .catchError((error){
      emit(GetMovieVideoError());
    });
  }
  void pressButton({context,id,result}){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context)=>MovieSimilarDetailsScreen
          (
          id: id,movie: result,
        ),
      ),
    );
    emit(PressSuccess(id: id,results: result));
  }


  bool search =false;
  SimilarModel? searchModel;
  void getMovieSearch({required String movie}){
    searchModel = null;
    search = true;
    emit(GetMovieSearchLoading());
    DioHelperMovie.getDataSearch(
        url: getMovieSearchUrl,
        movie: movie
    ).then((value) {
      searchModel = SimilarModel.fromJson(value.data);
      emit(GetMovieSearchSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetMovieSearchError());
    });
  }

  // User Update
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(MovieProfileImagePickedSuccessState());
    } else {
      emit(MovieProfileImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    @required name,
    @required phone,
  }){
    emit(MovieUpdateProfileLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
      value.ref.getDownloadURL()
          .then((value) {
        updateUser(
          name: name,
          phone: phone,
          image: value,
        );
      })
          .catchError((error){
        emit(MovieUpdateProfileSuccessState());
      }
      );
    })
        .catchError((error){
      emit(MovieUpdateProfileErrorState());
    });
  }

  void updateUser({
    required name,
    required phone,
    String? image,
  }){
    emit(MovieUpdateProfileLoadingState());
    UserModel usermodel = UserModel(
      email: userModel!.email,
      name: name,
      phone: phone,
      uId: userModel!.uId,
      image:image?? userModel!.image,
    );
    FirebaseFirestore.instance.collection('users')
        .doc(usermodel.uId)
        .update(usermodel.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error){
      emit(MovieUpdateProfileErrorState());
    });
  }
}