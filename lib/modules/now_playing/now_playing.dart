import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/components/constants.dart';
import '../../shared/style/color_manager.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final MovieCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: PageIndicatorContainer(
        shape: IndicatorShape.circle(size: 5),
        align: IndicatorAlign.bottom,
        indicatorSpace: 5,
        indicatorColor: ColorManager.grey,
        indicatorSelectorColor: ColorManager.darkWhite,
        length: cubit.movieModel!.movies!.take(5).length,
        child: PageView.builder(
          itemCount: cubit.movieModel!.movies!.take(5).length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: NetworkImage(
                          getImageUrl+cubit.movieModel!.movies![index].backPoster,
                        ),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                const Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: Icon(
                    FontAwesomeIcons.circlePlay,
                    color: ColorManager.white,
                    size: 50,
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
                        0.9
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 180,
                  child: Text(
                    cubit.movieModel!.movies![index].title!,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ],
            );
          },

        ),

      ),
    );
  }
}