import 'package:flutter/material.dart';

import '../app/home/route/lending_route.dart';

class Routes {
  Map<String, WidgetBuilder> routes = {
    HomeRouting.route : (context) => HomeRouting.childEmployeeListScreen,
    HomeRouting.addEmployeeDetailsScreenRoute : (context) => HomeRouting.childAddEmployeeDetailsScreen,
  };
}