import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/modules/register_screen/cubit/states.dart';

import '../../../models/user_model.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInit());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  bool showPassword = true;
  IconData suffixIcon = Icons.visibility_off_outlined;
  void showPasswordVisibility(){
    showPassword =!showPassword;
    suffixIcon =  showPassword?Icons.visibility_off_outlined:Icons.visibility;
    emit(RegisterChangePasswordVisibility());
  }


  void userRegister({
    required email,
    required password,
    required name,
    required phone,
  }){
    emit(MovieRegisterLoading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      createUser(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error){
      emit(MovieCreateUserError(error));
    });
  }

  void createUser({
    required email,
    required name,
    required phone,
    required uId,
  }){
    UserModel _userModel = UserModel(
      name: name,
      phone: phone,
      uId: uId,
      email: email,
      image: 'https://t3.ftcdn.net/jpg/03/01/94/34/240_F_301943459_hZqG7C4F3nnACx811k2CwS4YfomRT1n1.jpg',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(_userModel.toMap())
        .then((value){
      emit(MovieCreateUserSuccess(uId: uId));
    }).catchError((error){
      emit(MovieCreateUserError(error));
    });
  }


}