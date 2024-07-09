import 'package:flutter/material.dart';
import 'package:weather_app/ui/home_screen.dart';
import 'package:weather_app/ui/loading_screen.dart';

class Routes {
  static const String HOME_ACTIVITY = "/homeActivity";
  static const String LOADING_ACTIVITY = "/loadingActivity";
}

final Map<String, WidgetBuilder> routes = {
  Routes.HOME_ACTIVITY: (context) => HomeScreen(key: UniqueKey()),
  Routes.LOADING_ACTIVITY: (context) => LoadingScreen(),
};
