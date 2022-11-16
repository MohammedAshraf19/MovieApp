import 'package:buildcondition/buildcondition.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/modules/login_screen/login_screen.dart';
import '../modules/genres/genres_list.dart';
import '../modules/movies/popular_movies.dart';
import '../modules/movies/top_movies.dart';
import '../modules/now_playing/now_playing.dart';
import '../modules/person/person_list.dart';
import '../modules/search/search_screen.dart';
import '../modules/user/person_screen.dart';
import '../shared/network/local/cache_helper.dart';
import '../shared/style/color_manager.dart';
import '../shared/style/values_manager.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class MovieLayout extends StatelessWidget {
  const MovieLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCubit,MovieStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = MovieCubit.get(context);
        return BuildCondition(
          condition:
          state is! GetMovieLoading
              && state is! GetMovieError
              && state is! GetMovieSuccess
              && state is! GetUserDataSuccess
              && state is! GetUserDataLoading ,
          builder: (context)=>Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=> SearchScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      EvaIcons.searchOutline,
                      color: ColorManager.white,

                    )
                ),
                IconButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>const PersonScreen())
                      );
                    },
                    icon: const Icon(
                      //Icons.logout_outlined,
                      EvaIcons.personOutline,
                      color: ColorManager.white,

                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(right: AppSize.s4),
                  child: IconButton(
                      onPressed: (){
                        CacheHelper.removeData(key: 'uId').then((value) {
                          if(value){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context)=>const LoginScreen())
                            );
                          }
                        });
                      },
                      icon: const Icon(
                        EvaIcons.logOutOutline,
                        color: ColorManager.white,

                      )
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NowPlaying(cubit: cubit),
                  if(cubit.genreModel != null)
                    GenresList(genres: cubit.genreModel!),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSize.s12,bottom: AppSize.s12),
                    child: Text(
                      'trending persons in the week'.toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorManager.lightGrey),
                    ),
                  ),
                  const PersonList(),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSize.s12,bottom: AppSize.s12),
                    child: Text(
                      'Top Rated Movies'.toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorManager.lightGrey),
                    ),
                  ),
                  const TopMovies(),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSize.s12,bottom: AppSize.s12),
                    child: Text(
                      'Popular Movies'.toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorManager.lightGrey),
                    ),
                  ),
                  const PopularMovies(),
                ],
              ),
            ),
          ),
          fallback: (context)=>const Center(
              child: CircularProgressIndicator(
                  backgroundColor: ColorManager.primary,color: ColorManager.white
              ),
          ),
        );
      },
    );
  }
}


