
import 'package:flutter_assignment/networking/model/request/add_employee_details/req_add_employee_details.dart';

import '../source/emplyee_source.dart';

abstract class IEmployeeRepository {

  Future addEmployeeDetails({required  AddEmployeeDetailsModel reqAddEmployeeDetailsModel});
  Future<List<AddEmployeeDetailsModel>?> getEmployeeDetails();
  Future deleteEmployee({required int id});
  Future deleteMedicineTakenList({required List<int> deleteIdList});
  Future<bool> editEmployeeDetails({required int id,required AddEmployeeDetailsModel addEmployeeDetailsModel});
}

class EmployeeRepository implements IEmployeeRepository {

  late final EmployeeSource source;

  EmployeeRepository({required this.source});

  @override
  Future<bool> addEmployeeDetails({required AddEmployeeDetailsModel reqAddEmployeeDetailsModel}) => source.addEmployeeDetails(addEmployeeDetailsModel: reqAddEmployeeDetailsModel);

  @override
  Future<List<AddEmployeeDetailsModel>?> getEmployeeDetails() => source.getEmployeeDetails();

  @override
  Future<bool> deleteEmployee({required int id}) => source.deleteEmployee(id: id);

  @override
  Future deleteMedicineTakenList({required List<int> deleteIdList}) => source.deleteMedicineTakenList(deleteIdList: deleteIdList);

  @override
  Future<bool> editEmployeeDetails({required int id,required AddEmployeeDetailsModel addEmployeeDetailsModel}) => source.editEmployeeDetails(id: id,addEmployeeDetailsModel: addEmployeeDetailsModel);

  Future<bool> undoDeleteEmployeeDetails({required int deleteIndex,required AddEmployeeDetailsModel addEmployeeDetailsModel}) => source.undoDeleteEmployeeDetails(deleteIndex: deleteIndex, addEmployeeDetailsModel: addEmployeeDetailsModel);
}