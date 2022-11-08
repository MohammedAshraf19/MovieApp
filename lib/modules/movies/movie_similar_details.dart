import 'package:buildcondition/buildcondition.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/similar_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/style/color_manager.dart';
import '../../shared/style/values_manager.dart';
import '../video/movie_video.dart';

class MovieSimilarDetailsScreen extends StatelessWidget {
  Results movie;
  int id;
  MovieSimilarDetailsScreen({Key? key,required this.id,required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<MovieCubit,MovieStates>(
      listener: (context,state){
        if(state is PressSuccess) {
          MovieCubit.get(context).getMovieDetails(state.id);
        }
      },
      builder: (context,state){
        var cubit = MovieCubit.get(context);
        return BuildCondition(
          condition: state is! GetMovieDetailsLoading && state is! GetMovieDetailsSuccess,
          builder: (context)=>Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Builder(
                    builder:(context){
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 220,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        getImageUrl+'${movie.backdropPath}',
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),
                               Positioned(
                                 left: MediaQuery.of(context).size.width -80,
                                 top: 180,
                                right: 0,
                                bottom: 0,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context)=>MovieVideo(
                                                youtubePlayerController: YoutubePlayerController(
                                                  initialVideoId: cubit.videoModel!.videos![0].key,
                                                  flags: const YoutubePlayerFlags(
                                                    autoPlay: true,
                                                  ),
                                                )
                                            )
                                        )
                                    );
                                  },
                                  child: const Icon(
                                    FontAwesomeIcons.solidCirclePlay,
                                    color: ColorManager.grey,
                                    size: 50,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      ColorManager.primary.withOpacity(0.4),
                                      ColorManager.primary.withOpacity(0.4),
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: const [
                                      0.1,
                                      0.9,
                                    ],
                                  ),

                                ),
                              ),
                              IconButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }
                                  , icon: const Icon(
                                Icons.arrow_back_ios_rounded,
                                color: ColorManager.white,
                              )
                              ),
                              Positioned(
                                left: 10,
                                top: 180,
                                child: Text(
                                  movie.title!,
                                  style: Theme.of(context).textTheme.headlineLarge,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppSize.s12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      movie.voteAverage.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: ColorManager.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    RatingBar.builder(
                                        itemSize: 12,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        initialRating: movie.voteAverage!/2,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                                        itemBuilder: (context, index){
                                          return const Icon(
                                            EvaIcons.star,
                                            color: Colors.orange,
                                          );
                                        },
                                        onRatingUpdate:(rating){
                                        }
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: AppSize.s12,
                                ),
                                Text(
                                    'Overview'.toUpperCase(),
                                    style: Theme.of(context).textTheme.titleLarge
                                ),
                                const SizedBox(
                                  height: AppSize.s4,
                                ),
                                Text(
                                    '${movie.overview}',
                                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: AppSize.s12)
                                ),
                                const SizedBox(
                                  height: AppSize.s12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Budget',
                                            style: Theme.of(context).textTheme.titleLarge
                                        ),
                                        const SizedBox(
                                          height: AppSize.s4,
                                        ),
                                        Text(
                                            '${cubit.movieDetailsModel!.movieDetails!.budget}\$',
                                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: AppSize.s12)
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Duration',
                                            style: Theme.of(context).textTheme.titleLarge
                                        ),
                                        const SizedBox(
                                          height: AppSize.s4,
                                        ),
                                        Text(
                                            '${cubit.movieDetailsModel!.movieDetails!.runTime}min',
                                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: AppSize.s12)
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Release Date',
                                            style: Theme.of(context).textTheme.titleLarge
                                        ),
                                        const SizedBox(
                                          height: AppSize.s4,
                                        ),
                                        Text(
                                            '${cubit.movieDetailsModel!.movieDetails!.releaseDate}',
                                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: AppSize.s12)
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: AppSize.s12,
                                ),

                                Text(
                                    'Genres'.toUpperCase(),
                                    style: Theme.of(context).textTheme.titleLarge
                                ),
                                const SizedBox(
                                  height: AppSize.s4,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for(int i =0;i<cubit.movieDetailsModel!.movieDetails!.genre.length;i++)
                                        Padding(
                                          padding: const EdgeInsets.only(right: AppSize.s12),
                                          child: Text(
                                            '${cubit.movieDetailsModel!.movieDetails!.genre[i].name}',
                                            style: Theme.of(context).textTheme.headlineLarge,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: AppSize.s12,
                                ),
                                Text(
                                    'Casts'.toUpperCase(),
                                    style: Theme.of(context).textTheme.titleLarge
                                ),
                                const SizedBox(
                                  height: AppSize.s4,
                                ),
                                SizedBox(
                                  height: 116,
                                  child: ListView.builder(
                                      itemCount: cubit.castModel!.cast!.length,
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context,index){
                                        return Container(
                                          padding: const EdgeInsets.only(
                                            top: AppSize.s8,
                                            right: AppSize.s8,
                                          ),
                                          child: Column(
                                            children: [
                                              cubit.castModel!.cast![index].profilePath == null?
                                              const CircleAvatar(
                                                radius: 30,
                                                child: Icon(
                                                    FontAwesomeIcons.user
                                                ),
                                              )
                                                  :
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(getMovieImageUrl+'${cubit.castModel!.cast![index].profilePath}'),
                                              ),
                                              const SizedBox(
                                                height: AppSize.s4,
                                              ),
                                              Text(
                                                '${cubit.castModel!.cast![index].name}',
                                                style: const TextStyle(
                                                    color: ColorManager.white,
                                                    fontSize: 8
                                                ),
                                              ),
                                              const SizedBox(
                                                height: AppSize.s4,
                                              ),
                                              Text(
                                                '${cubit.castModel!.cast![index].character}',
                                                style: TextStyle(
                                                    color: ColorManager.lightGrey,
                                                    fontSize: 8
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  ),
                                ),

                                const SizedBox(
                                  height: AppSize.s12,
                                ),
                                Text(
                                    'Similar Movies'.toUpperCase(),
                                    style: Theme.of(context).textTheme.titleLarge
                                ),
                                const SizedBox(
                                  height: AppSize.s4,
                                ),
                                SizedBox(
                                  height: 320,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cubit.movieSimilarModel!.results!.length,
                                    itemBuilder: (context,index){
                                      return InkWell(
                                        onTap: (){
                                          cubit.pressButton(context: context,id: cubit.movieSimilarModel!.results![index].id!,result: cubit.movieSimilarModel!.results![index],);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top:AppSize.s12,
                                            bottom:AppSize.s12 ,
                                            right:AppSize.s12 ,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 180,
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(AppSize.s1_5)),
                                                  shape: BoxShape.rectangle,
                                                  image: DecorationImage(
                                                    image: NetworkImage(getMovieImageUrl+'${cubit.movieSimilarModel!.results![index].posterPath}'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height:  AppSize.s8,
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  cubit.movieSimilarModel!.results![index].title!,
                                                  style: const TextStyle(
                                                      height: AppSize.s1,
                                                      fontSize: 11,
                                                      color: ColorManager.white,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: AppSize.s4,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    cubit.movieSimilarModel!.results![index].voteAverage.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: ColorManager.white,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: AppSize.s4,
                                                  ),
                                                  RatingBar.builder(
                                                      itemSize: 8,
                                                      minRating: 1,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      initialRating: cubit.movieSimilarModel!.results![index].voteAverage!/2,
                                                      itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                                                      itemBuilder: (context, index){
                                                        return  Icon(
                                                          EvaIcons.star,
                                                          color: ColorManager.starColor,
                                                        );
                                                      },
                                                      onRatingUpdate:(rating){
                                                      }
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      );
                    }
                ),
              ),
            ),
          ),
          fallback: (context)=>const Center(
              child: CircularProgressIndicator(
                backgroundColor: ColorManager.primary,color: ColorManager.white,
              )
          ),
        );
      },
    );
  }
}
