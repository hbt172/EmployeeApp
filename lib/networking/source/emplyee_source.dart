import 'package:flutter_assignment/data_set/interface/prescriptions.dart';
import 'package:flutter_assignment/networking/model/request/add_employee_details/req_add_employee_details.dart';

class EmployeeSource {
  late final IEmployeeInterface dataSet;

  EmployeeSource({required this.dataSet});

  Future<bool> addEmployeeDetails({required AddEmployeeDetailsModel addEmployeeDetailsModel}) async {
   return dataSet.addEmployeeDetails(data: addEmployeeDetailsModel.toJson());
  }

  Future<List<AddEmployeeDetailsModel>?> getEmployeeDetails() async {

    final medication = await dataSet.getEmployeeDetails();

    if(medication == null) return null;

    return medication.map((e) => AddEmployeeDetailsModel.fromJson(e)).toList();
  }

  Future<bool> deleteEmployee({required int id}) async {
    return dataSet.deleteEmployee(id: id);
  }

  Future deleteMedicineTakenList({required List<int> deleteIdList}) async {
    dataSet.deleteEmployeeList(deleteIdList: deleteIdList);
  }

  Future<bool> editEmployeeDetails({required int id,required AddEmployeeDetailsModel addEmployeeDetailsModel}) async {
    return dataSet.editEmployeeDetails(id: id,data: addEmployeeDetailsModel.toJson());
  }

  Future<bool> undoDeleteEmployeeDetails({required int deleteIndex,required AddEmployeeDetailsModel addEmployeeDetailsModel}) async {
    return dataSet.undoDeleteEmployeeDetails(deleteIndex: deleteIndex,data: addEmployeeDetailsModel.toJson());
  }

}