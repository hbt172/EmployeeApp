import 'dart:async';
import 'package:flutter_assignment/main.dart';
import 'package:flutter_assignment/networking/repository/add_employee_details_repository.dart';
import 'package:flutter_assignment/networking/source/employee_source.dart';
import '../../data_set/hive_middleware/database.dart';
import '../Response.dart';
import '../model/request/add_employee_details/req_add_employee_details.dart';

class EditEmployeeBloc {
  EmployeeRepository? _employeeRepository;
  final _employeeBlocController = StreamController<Response<bool>>();

  StreamSink<Response<bool>> get editEmployeeDataSink => _employeeBlocController.sink;

  Stream<Response<bool>> get editEmployeeStream => _employeeBlocController.stream;

  late final dataset = HiveDatabase();
  EditEmployeeBloc() {
    _employeeRepository = EmployeeRepository(source: EmployeeSource(dataSet: database.employee));
  }

  editEmployeeDetails({required int id,required AddEmployeeDetailsModel addEmployeeDetailsModel}) async {
    editEmployeeDataSink.add(Response.loading('login..'));
    try {
      final deleteEmployeeDetails = await _employeeRepository?.editEmployeeDetails(id: id,addEmployeeDetailsModel: addEmployeeDetailsModel);
      editEmployeeDataSink.add(Response.completed(deleteEmployeeDetails ?? false));
    } catch (e) {
      editEmployeeDataSink.add(Response.error(e.toString()));
    }
    return null;
  }

 dispose() {
    _employeeBlocController.close();
  }
}
