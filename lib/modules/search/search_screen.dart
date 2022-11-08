import 'package:buildcondition/buildcondition.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/style/color_manager.dart';
import '../../shared/style/values_manager.dart';
import '../movies/movie_similar_details.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return BlocConsumer<MovieCubit,MovieStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = MovieCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                }
                , icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: ColorManager.white,
            )
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                textFormFiled(
                    submitted: (value){
                      cubit.getMovieSearch(movie: value);
                    },
                    textController:searchController ,
                    hintText: 'What Movie you want?',
                    perfixIcon:   const Icon(
                      EvaIcons.searchOutline,
                      color: ColorManager.white,
                    ),
                    ValidationText: 'you should write movie',
                    type: TextInputType.text
                ),
                if(cubit.search)
                  BuildCondition(
            condition: state is! GetMovieSearchLoading,
            builder: (context){
              if(MovieCubit.get(context).searchModel!.results!.length > 1) {
                return Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: AppSize.s12),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.searchModel!.results?.length,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          MovieCubit.get(context).getMovieDetails(cubit.searchModel!.results![index].id!);

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>MovieSimilarDetailsScreen(id: cubit.searchModel!.results![index].id,movie:cubit.searchModel!.results![index] ,))
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if(cubit.searchModel!.results![index].posterPath != null)
                                  Container(
                                    width: 120,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all( Radius.circular(AppSize.s1_5)),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image: NetworkImage(getMovieImageUrl+cubit.searchModel!.results![index].posterPath!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                if(cubit.searchModel!.results![index].posterPath != null)
                                  const SizedBox(
                                  height:  AppSize.s8,
                                ),
                                if(cubit.searchModel!.results![index].posterPath != null)
                                  SizedBox(
                                  width: 100,
                                  child: Text(
                                    cubit.searchModel!.results![index].title!,
                                    style: const TextStyle(
                                        height: AppSize.s1,
                                        fontSize: 11,
                                        color: ColorManager.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                if(cubit.searchModel!.results![index].posterPath != null)
                                  const SizedBox(
                                  height: AppSize.s4,
                                ),
                                if(cubit.searchModel!.results![index].posterPath != null)
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      cubit.searchModel!.results![index].voteAverage.toString(),
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
                                        initialRating: cubit.searchModel!.results![index].voteAverage!/2,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
              }
              return Expanded(
                child: Center(
                  child: Text(
                    'Can\'t Find Any Thing',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              );
            },
            fallback: (context)=>const Expanded(
                child:  Center(
                  child: CircularProgressIndicator(color: ColorManager.white,
                  ),
                )
            ),
          ),
              ],
            ),
          ),
        );
      },
    );
  }
}
