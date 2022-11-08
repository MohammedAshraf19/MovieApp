import 'package:flutter/material.dart';
import 'package:my_movie_app/shared/style/styles_manager.dart';
import 'package:my_movie_app/shared/style/values_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getAppTheme(){
  return ThemeData(
    // main color
    scaffoldBackgroundColor: ColorManager.primary,
    backgroundColor: ColorManager.primary,
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      disabledColor: ColorManager.grey,
      splashColor: ColorManager.lightPrimary,
      // card theme
      cardTheme: const CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4,
      ),

      // appBar Theme
      appBarTheme: AppBarTheme(
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.lightPrimary,
        centerTitle: true,
        titleTextStyle: getRegularStyle(
            color: ColorManager.white,
            fontSize: FontSize.s16
        ),
        iconTheme: const IconThemeData(
          color: ColorManager.white,
        ),

      ),
      // button theme
      buttonTheme: const ButtonThemeData(
        shape: StadiumBorder(),
        splashColor: ColorManager.lightPrimary,
        buttonColor: ColorManager.primary,
        disabledColor: ColorManager.grey,
      ),

      // ElevatedButtonTheme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(color: ColorManager.white,fontSize:FontSize.s17),
          primary: ColorManager.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
          ),
        ),
      ),
      // text theme
      textTheme: TextTheme(
        displayLarge: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s30),
        headlineLarge: getSemiBoldStyle(color: ColorManager.white,fontSize: FontSize.s16),
        titleMedium: getMediumStyle(color: ColorManager.lightPrimary,fontSize: FontSize.s14),
        bodyLarge: getRegularStyle(color: ColorManager.grey),
        bodySmall: getRegularStyle(color: ColorManager.grey),
        titleLarge: getSemiBoldStyle(color: ColorManager.grey,fontSize: 20),
      ),
      //input decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14),
        labelStyle: getMediumStyle(color: ColorManager.grey,fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: ColorManager.red),
        enabledBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.grey,width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.darkWhite,width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.red,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all( Radius.circular(AppSize.s8)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
          borderRadius:  BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
      )
  );
}