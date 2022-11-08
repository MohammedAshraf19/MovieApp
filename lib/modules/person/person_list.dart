import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/constants.dart';
import '../../shared/style/color_manager.dart';
import '../../shared/style/values_manager.dart';

class PersonList extends StatelessWidget {
  const PersonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCubit,MovieStates>(
        listener: (context,state){},
      builder: (context,state){
          var cubit = MovieCubit.get(context).personModel;
          return Container(
            height: 116,
            padding: const EdgeInsets.only(left: AppSize.s16),
            child: ListView.builder(
              itemCount: cubit!.persons!.length,
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
                      cubit.persons![index].profileImage == null?
                    const CircleAvatar(
                    radius: 30,
                   child: Icon(
                     FontAwesomeIcons.user
                   ),
                  )
                        :
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(getMovieImageUrl+cubit.persons![index].profileImage),
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      Text(
                        cubit.persons![index].name,
                        style: const TextStyle(
                          color: ColorManager.white,
                          fontSize: 8
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      Text(
                        cubit.persons![index].known,
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
          );
      },
    );
  }
}
