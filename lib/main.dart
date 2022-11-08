import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/shared/bloc_observer.dart';
import 'package:my_movie_app/shared/components/components.dart';
import 'package:my_movie_app/shared/components/constants.dart';
import 'package:my_movie_app/shared/network/local/cache_helper.dart';
import 'package:my_movie_app/shared/network/remote/dio_helper.dart';
import 'package:my_movie_app/shared/style/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'modules/splash_screen/splash_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelperMovie.init();
  uId = CacheHelper.getData(key: 'uId');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> MovieCubit()..getMovies()..getUserData(),
      child: BlocConsumer<MovieCubit,MovieStates>(
        listener: (context,state){
          if(state is GetMovieError){
            showToast(
              txt: 'Check Internet',
              state: ToastState.ERROR,
            );
          }
        },
        builder: (context,state){
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: getAppTheme(),
              home: SplashScreen()
          );
        },
      ),
    );
  }
}
