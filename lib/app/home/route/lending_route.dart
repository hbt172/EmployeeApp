import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment/Screen/AddEmployeeDetailsScreen/add_employee_details_screen.dart';

import '../../../Screen/EmployeeListScreen/employee_list_screen.dart';

class HomeRouting {
  static String route = "/";
  static String employeeListScreenRoute = "/EmployeeListScreen";
  static String addEmployeeDetailsScreenRoute = "/AddEmployeeDetailsScreen";

  static Widget get childEmployeeListScreen => const EmployeeListScreen();
  static Widget get childAddEmployeeDetailsScreen => const AddEmployeeDetailsScreen();

  static goToLending(BuildContext context) {
    Navigator.of(context).pushNamed(HomeRouting.route);
  }

  static goToDetailsScreen(BuildContext context) {
    Navigator.of(context).pushNamed(addEmployeeDetailsScreenRoute);
  }

}