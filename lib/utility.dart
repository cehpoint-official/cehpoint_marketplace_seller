import 'package:flutter/material.dart';

class Utils {
  static int appId = 821820474;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static String appSign =
      "6ac4baebe9f8c71ee3af282c3d1bf139b36100eb5b7eb1f8d8f9d1c5a3320746";
  static int getappId() {
    return appId;
  }

  static String getappSign() {
    return appSign;
  }
}
