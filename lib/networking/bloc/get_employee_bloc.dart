import 'dart:async';
import 'package:flutter_assignment/networking/model/request/add_employee_details/req_add_employee_details.dart';
import 'package:flutter_assignment/networking/repository/add_employee_details_repository.dart';
import 'package:flutter_assignment/networking/source/employee_source.dart';
import '../../main.dart';
import '../Response.dart';

class GetEmployeeBloc {
  EmployeeRepository? _employeeRepository;
  final _employeeBlocController = StreamController<Response<List<AddEmployeeDetailsModel>>>();

  StreamSink<Response<List<AddEmployeeDetailsModel>>> get getEmployeeDataSink => _employeeBlocController.sink;

  Stream<Response<List<AddEmployeeDetailsModel>>> get getEmployeeStream => _employeeBlocController.stream;
  GetEmployeeBloc() {
    _employeeRepository = EmployeeRepository(source: EmployeeSource(dataSet: database.employee));
  }

  getEmployeeDetails() async {
    getEmployeeDataSink.add(Response.loading('login..'));
    try {
      final list = await _employeeRepository?.getEmployeeDetails();

      if(list != null) {
        final finalList = list.toList();
        getEmployeeDataSink.add(Response.completed(finalList));
      } else {
        throw "Something went wrong.";
      }

    } catch (e) {
      getEmployeeDataSink.add(Response.error(e.toString()));
    }
    return null;
  }

 dispose() {
    _employeeBlocController.close();
  }
}
