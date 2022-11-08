import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../style/color_manager.dart';
import '../style/font_manager.dart';
import '../style/styles_manager.dart';

Widget textFormFiled({
  required textController,
  required String hintText,
  required Icon perfixIcon,
  IconButton? suffixIcon,
  required ValidationText,
  ValueChanged? change,
  ValueChanged? submitted,
  required TextInputType type,
  bool secure = false,
}){
  return  TextFormField(
    onChanged:change,
    onFieldSubmitted:submitted ,
    controller: textController,
    validator: (String? value){
      if(value!.isEmpty) {
        return '$ValidationText Must Not Be Null';
      } else {
        return null;
      }
    },
    obscureText: secure,
    keyboardType: type,
    style: const TextStyle(
      color: ColorManager.white
    ),
    decoration: InputDecoration(
      prefixIcon: perfixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle:getSemiBoldStyle(color: ColorManager.white.withOpacity(0.3),fontSize: FontSize.s16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      filled: true,
      fillColor: ColorManager.white.withOpacity(0.1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    ),
  );
}

Widget myButton({
  required context,
  required String txt,
  required width,
  required VoidCallback onpress,
}){
  return MaterialButton(
    minWidth: width,
    onPressed: onpress,
    color: ColorManager.red,
    child : Text(
      txt.toUpperCase(),
      style: Theme.of(context).textTheme.headlineLarge,
    ),
  );
}

void showToast({required String txt, required ToastState state}) {
  Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastState {SUCCESS, ERROR }
late Color color;
Color chooseToastColor(ToastState state) {
  switch (state) {
    case ToastState.SUCCESS:
      color = ColorManager.lightPrimary;
      break;
    case ToastState.ERROR:
      color = ColorManager.red;
      break;
  }
  return color;
}