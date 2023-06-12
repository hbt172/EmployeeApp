import 'dart:async';
import 'package:flutter_assignment/main.dart';
import 'package:flutter_assignment/networking/repository/add_employee_details_repository.dart';
import 'package:flutter_assignment/networking/source/employee_source.dart';
import '../../data_set/hive_middleware/database.dart';
import '../Response.dart';

class DeleteEmployeeBloc {
  EmployeeRepository? _employeeRepository;
  final _employeeBlocController = StreamController<Response<bool>>();

  StreamSink<Response<bool>> get deleteEmployeeDataSink => _employeeBlocController.sink;

  Stream<Response<bool>> get deleteEmployeeStream => _employeeBlocController.stream;

  late final dataset = HiveDatabase();
  DeleteEmployeeBloc() {
    _employeeRepository = EmployeeRepository(source: EmployeeSource(dataSet: database.employee));
  }

  deleteEmployeeDetails(
      {required int id}) async {
    deleteEmployeeDataSink.add(Response.loading('login..'));
    try {
      final deleteEmployeeDetails = await _employeeRepository?.deleteEmployee(id: id);
      deleteEmployeeDataSink.add(Response.completed(deleteEmployeeDetails ?? false));
    } catch (e) {
      deleteEmployeeDataSink.add(Response.error(e.toString()));
    }
    return null;
  }

 dispose() {
    _employeeBlocController.close();
  }
}
