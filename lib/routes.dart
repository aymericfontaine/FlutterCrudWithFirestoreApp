import 'package:flutter/material.dart';
import 'package:flutter_crud_with_firestore_app/main.dart';
import 'package:flutter_crud_with_firestore_app/views/register_view.dart';
import 'package:flutter_crud_with_firestore_app/views/reset_view.dart';

class RouteGenerater {
  static const kRouteInitial = "/";
  static const kRouteRegister = "/register";
  static const kRouteReset = "/reset";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kRouteReset:
        return MaterialPageRoute(builder: (context) => ResetView());
      case kRouteRegister:
        return MaterialPageRoute(builder: (context) => RegisterView());
      default:
        return MaterialPageRoute(builder: (context) => MyAppWrapper());
    }
  }
}
