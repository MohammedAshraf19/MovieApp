import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/style/color_manager.dart';


class MovieVideo extends StatefulWidget {
  final YoutubePlayerController youtubePlayerController;
  const MovieVideo({Key? key,required this.youtubePlayerController}) : super(key: key);

  @override
  State<MovieVideo> createState() => _MovieVideoState(controller: youtubePlayerController);
}
class _MovieVideoState extends State<MovieVideo> {
  final YoutubePlayerController controller;
  _MovieVideoState({required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCubit,MovieStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body:  Stack(
            children: [
              Center(child: YoutubePlayer(
                  controller: controller,
                onEnded: (YoutubeMetaData metaData){
                  Navigator.pop(context);
                },
              )
              ),
              Positioned(
                top: 40,
                  right: 10,
                  child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        EvaIcons.closeCircle,
                        color: ColorManager.grey,
                      ),
                  )
              ),
            ],
          ),
        );
      },
    );
  }
}
