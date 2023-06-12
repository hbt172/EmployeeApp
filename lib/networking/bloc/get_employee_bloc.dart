import 'dart:async';
import 'package:flutter_assignment/networking/model/request/add_employee_details/req_add_employee_details.dart';
import 'package:flutter_assignment/networking/repository/add_employee_details_repository.dart';
import 'package:flutter_assignment/networking/source/emplyee_source.dart';
import '../../data_set/hive_middleware/database.dart';
import '../../main.dart';
import '../Response.dart';

class GetEmployeeBloc {
  EmployeeRepository? _employeeRepository;
  final _employeeBlocController = StreamController<Response<List<AddEmployeeDetailsModel>>>();

  StreamSink<Response<List<AddEmployeeDetailsModel>>> get getEmployeeDataSink => _employeeBlocController.sink;

  Stream<Response<List<AddEmployeeDetailsModel>>> get getEmployeeStream => _employeeBlocController.stream;
  // late final dataset = HiveDatabase();
  GetEmployeeBloc() {
    // _employeeBlocController = StreamController<Response<List<AddEmployeeDetailsModel>>>();
    _employeeRepository = EmployeeRepository(source: EmployeeSource(dataSet: database.employee));
  }

  bool isLoggedIn = false;

  getEmployeeDetails() async {
    getEmployeeDataSink.add(Response.loading('login..'));
    try {
      final list = await _employeeRepository?.getEmployeeDetails();

      if(list != null) {
        final finalList = list.toList();
        isLoggedIn = true;
        getEmployeeDataSink.add(Response.completed(finalList));
      } else {
        print("list ===> $list");
        throw "Something went wrong.";
      }

    } catch (e) {
      print("list ===>");
      getEmployeeDataSink.add(Response.error(e.toString()));
      isLoggedIn = false;
      print(e);
    }
    return null;
  }

 dispose() {
    _employeeBlocController.close();
  }
}
