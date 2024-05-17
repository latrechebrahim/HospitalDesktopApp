

import 'package:flutter/material.dart';

class AppTheme {
  // Light Mode Colors
  static const Color lightDark = Color(0xFF1E1E1E);
  static const Color lightWhite = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFE8E8E8);
  static const Color lightWhite1 = Color.fromARGB(255, 126, 126, 126);
  static const Color lightBlue = Color(0xFF3B7BC7);
  static const Color lightBlue2 = Color(0xFF0B50A4);
  static const Color lightBlue1 = Color(0xFF0000FF);
  static const Color lightgreen = Color.fromARGB(255, 2, 246, 50);
  static const Color lightRed = Color.fromARGB(255, 249, 7, 7);


  static const Color darkDark = Color(0xFF121212);
  static const Color darkWhite = Color(0xFF1E1E1E);
  static const Color darkWhite1 = Color.fromARGB(255, 180, 180, 180);
  static const Color darkBlue = Color(0xFF1A237E);
  static const Color darkBlue1 = Color(0xFF2196F3);
  static const Color darkBlue2 = Color(0xFF0B50A4);
  static const Color darkGray = Color(0xFF424242);
  static const Color darkRed = Color.fromARGB(255, 94, 1, 19);
  static const Color darkgreen = Color.fromARGB(255, 2, 130, 50);

  static Color getModeColor(Color lightColor, Color darkColor, int isMod) {
    if (isMod == 1){
      return lightColor;
    }else if (isMod == 2){
      return darkColor;
    }
    return lightColor;
  }
}



class AppIcons {
  static const IconData calendar_today = IconData(
    0xe122, fontFamily: 'MaterialIcons',);
  static const IconData settings = IconData(
      0xe57f, fontFamily: 'MaterialIcons');
  static const IconData logout = IconData(
      0xe3b3, fontFamily: 'MaterialIcons');
  static const IconData support_agent = IconData(0xe621, fontFamily: 'MaterialIcons');
  static const IconData phone = IconData(0xe4a2, fontFamily: 'MaterialIcons');
  static const IconData personal_injury_outlined = IconData(0xf281, fontFamily: 'MaterialIcons');




}

