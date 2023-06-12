import 'package:flutter_assignment/data_set/interface/prescriptions.dart';
import 'connection.dart';

abstract class IDatabase {
  late IConnectionInterface connection;
  late IEmployeeInterface employee;
  Future start();
  Future clear();
}
