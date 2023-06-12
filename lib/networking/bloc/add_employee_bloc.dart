import 'dart:async';
import 'package:flutter_assignment/main.dart';
import 'package:flutter_assignment/networking/model/request/add_employee_details/req_add_employee_details.dart';
import 'package:flutter_assignment/networking/repository/add_employee_details_repository.dart';
import 'package:flutter_assignment/networking/source/emplyee_source.dart';
import '../../data_set/hive_middleware/database.dart';
import '../Response.dart';
import '../../main.dart';

class AddEmployeeBloc {
  EmployeeRepository? _employeeRepository;
  final _employeeBlocController = StreamController<Response<bool>>();

  StreamSink<Response<bool>> get addEmployeeDataSink => _employeeBlocController.sink;

  Stream<Response<bool>> get addEmployeeStream => _employeeBlocController.stream;

  late final dataset = HiveDatabase();
  AddEmployeeBloc() {
    // _employeeBlocController = StreamController<Response<bool>>();
    _employeeRepository = EmployeeRepository(source: EmployeeSource(dataSet: database.employee));
  }

  bool isLoggedIn = false;

  addEmployeeDetails(
      {required AddEmployeeDetailsModel reqAddEmployeeDetailsModel}) async {
    addEmployeeDataSink.add(Response.loading('login..'));
    try {
      final isAddEmployeeDetails = await _employeeRepository?.addEmployeeDetails(reqAddEmployeeDetailsModel: reqAddEmployeeDetailsModel);
      isLoggedIn = true;
      addEmployeeDataSink.add(Response.completed(isAddEmployeeDetails ?? false));
    } catch (e) {
      addEmployeeDataSink.add(Response.error(e.toString()));
      isLoggedIn = false;
      print(e);
    }
    return null;
  }

 dispose() {
    _employeeBlocController.close();
  }
}
