import 'package:flutter/material.dart';

class ThemeController with ChangeNotifier {
  bool isDark = false;

  toggleTheme() {
    isDark =!isDark;
    notifyListeners();
    // if(isDark == false) {
    //   isDark = true;
    // } else if(isDark == true) {
    //   isDark = false;
    // }
  }

  ThemeData get theme {
    return isDark
        ? ThemeData.dark()
        : ThemeData.light();
  }

  // bool changeTheme(){
  //   if(isDark == true) {
  //     isDark = false;
  //   } else if(isDark == false) {
  //     isDark = true;
  //   } else {
  //     isDark = false;
  //   }
  //   return false;
  // }
}