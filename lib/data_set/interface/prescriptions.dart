import '../../networking/model/request/add_employee_details/req_add_employee_details.dart';

abstract class IEmployeeInterface {
  Future<bool> addEmployeeDetails({required Map<String,dynamic> data});
  Future<List<Map<String,dynamic>>?> getEmployeeDetails();
  Future<bool> deleteEmployee({required int id});
  deleteEmployeeList({required List<int> deleteIdList});
  // Future<bool> editEmployeeDetails({required int id,required AddEmployeeDetailsModel addEmployeeDetailsModel});
  Future<bool> editEmployeeDetails({required int id,required Map<String, dynamic> data});
  Future<bool> undoDeleteEmployeeDetails({required int deleteIndex,required Map<String, dynamic> data});
}