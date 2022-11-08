import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/modules/login_screen/cubit/states.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInit());
  static LoginCubit get(context)=>BlocProvider.of(context);
  bool showPassword = true;
  IconData suffixIcon = Icons.visibility_off_outlined;
  void showPasswordVisibility(){
    showPassword =!showPassword;
    suffixIcon =  showPassword?Icons.visibility_off_outlined:Icons.visibility;
    emit(LoginChangePasswordVisibility());
  }

  void userLogin({
    required String email,
    required String password,
  }){
    emit(MovieLoginLoading());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      emit(MovieLoginSuccess(value.user!.uid));
    }).catchError((error){
      emit(MovieLoginError(error));
    });
  }
}