import 'dart:async';
import 'package:flutter_assignment/main.dart';
import 'package:flutter_assignment/networking/model/request/add_employee_details/req_add_employee_details.dart';
import 'package:flutter_assignment/networking/repository/add_employee_details_repository.dart';
import 'package:flutter_assignment/networking/source/emplyee_source.dart';
import '../../data_set/hive_middleware/database.dart';
import '../Response.dart';
import '../../main.dart';

class UndoDeleteEmployeeBloc {
  EmployeeRepository? _employeeRepository;
  final _employeeBlocController = StreamController<Response<bool>>();

  StreamSink<Response<bool>> get undoDeleteEmployeeDataSink => _employeeBlocController.sink;

  Stream<Response<bool>> get undoDeleteEmployeeStream => _employeeBlocController.stream;

  late final dataset = HiveDatabase();
  UndoDeleteEmployeeBloc() {
    // _employeeBlocController = StreamController<Response<bool>>();
    _employeeRepository = EmployeeRepository(source: EmployeeSource(dataSet: database.employee));
  }

  bool isLoggedIn = false;

  undoDeleteEmployeeDetails({required int deleteIndex,required AddEmployeeDetailsModel addEmployeeDetailsModel}) async {
    undoDeleteEmployeeDataSink.add(Response.loading('login..'));
    try {
      final isUndoDeleteEmployeeDetails = await _employeeRepository?.undoDeleteEmployeeDetails(deleteIndex: deleteIndex, addEmployeeDetailsModel: addEmployeeDetailsModel);
      isLoggedIn = true;
      undoDeleteEmployeeDataSink.add(Response.completed(isUndoDeleteEmployeeDetails ?? false));
    } catch (e) {
      undoDeleteEmployeeDataSink.add(Response.error(e.toString()));
      isLoggedIn = false;
      print(e);
    }
    return null;
  }

 dispose() {
    _employeeBlocController.close();
  }
}
