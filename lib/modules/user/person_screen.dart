import 'package:buildcondition/buildcondition.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/layout/cubit/cubit.dart';
import 'package:my_movie_app/layout/cubit/states.dart';
import 'package:my_movie_app/modules/user/edit_screen.dart';

import '../../shared/style/color_manager.dart';
import '../../shared/style/values_manager.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCubit,MovieStates>(
      listener: (context,state){},
      builder: (context,state){
        MovieCubit cubit = MovieCubit.get(context);
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
          body: BuildCondition(
            condition: cubit.userModel != null,
            builder: (context){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 68,
                      backgroundImage: NetworkImage(
                        '${cubit.userModel!.image}',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                  Text(
                    '${cubit.userModel!.name}',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSize.s12),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              primary: ColorManager.lightPrimary
                            ),
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=> EditScreen())
                                );
                              },
                              child:  Icon(
                                EvaIcons.editOutline,
                                color: ColorManager.white,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s4,
                  ),
                ],
              );
            },
            fallback:(context)=> Center(child:CircularProgressIndicator(color: ColorManager.primary)),
          ),
        );
      },
    );
  }
}
