import 'package:buildcondition/buildcondition.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/constants.dart';
import '../../shared/style/color_manager.dart';
import '../../shared/style/values_manager.dart';
import 'movie_details.dart';
class PopularMovies extends StatelessWidget {
  const PopularMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCubit,MovieStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = MovieCubit.get(context).popularMovie;
        return Container(
          height: 270,
          padding: const EdgeInsets.only(left: AppSize.s12),
          child: BuildCondition(
            condition: cubit!.movies!.length > 0,
            builder: (context)=> ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: cubit.movies!.length,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    MovieCubit.get(context).getMovieDetails(cubit.movies![index].id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>MovieDetailsScreen(id: cubit.movies![index].id,movie: cubit.movies![index],))
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top:AppSize.s12,
                      bottom:AppSize.s12 ,
                      right:AppSize.s12 ,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppSize.s8),
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
                                image: NetworkImage(getMovieImageUrl+cubit.movies![index].poster),
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
                              cubit.movies![index].title!,
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
                                cubit.movies![index].rating.toString(),
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
                                  initialRating: cubit.movies![index].rating/2,
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
                  ),
                );
              },
            ),
            fallback: (context)=>const Center(
              child: CircularProgressIndicator(
                  backgroundColor: ColorManager.primary,color: ColorManager.white
              ),
            ),
          ),
        );
      },
    );
  }
}
