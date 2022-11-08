import 'package:flutter/cupertino.dart';
import 'font_manager.dart';

TextStyle _getTextStyle({required Color color , required double fontSize,required FontWeight fontWeight}){
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}
// Regular Style
TextStyle getRegularStyle({required Color color ,double fontSize = FontSize.s12 }){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontsWeightManager.regular);
}

// Medium Style
TextStyle getMediumStyle({required Color color ,double fontSize = FontSize.s12 }){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontsWeightManager.medium);
}

// Bold Style
TextStyle getBoldStyle({required Color color ,double fontSize = FontSize.s12 }){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontsWeightManager.bold);
}

// Light Style
TextStyle getLightStyle({required Color color ,double fontSize = FontSize.s12 }){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontsWeightManager.light);
}

// SemiBold Style
TextStyle getSemiBoldStyle({required Color color ,double fontSize = FontSize.s12 }){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontsWeightManager.semiBold);
}