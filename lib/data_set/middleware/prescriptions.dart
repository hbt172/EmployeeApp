import '../../networking/model/request/add_employee_details/req_add_employee_details.dart';
import '../hive_middleware/data.dart';
import '../interface/prescriptions.dart';
import '../models/prescriptions/add_employee_details.dart';

class LocalPrescriptions extends IEmployeeInterface {


  @override
  Future<bool> addEmployeeDetails({required Map<String, dynamic> data}) async{
    // TODO: implement addEmployeeDetails
    final employeeData = AddEmployeeDetailsDataSet.fromJson(data);
    employeeData.dateTime = DateTime.now();
    employeeData.id = Data.employeeTaken.length;
    Data.employeeTaken.add(employeeData);
    return true;
  }

  @override
  Future<List<Map<String, dynamic>>?> getEmployeeDetails() async {
    // TODO: implement getEmployeeDetails
    if(Data.employeeTaken.isEmpty) return null;

    // Sort by date
    // Data.bloodPressure.sort(
    //       (a, b) {
    //     return (a.dateTime?.millisecondsSinceEpoch ?? 0) > (b.dateTime?.millisecondsSinceEpoch ?? 0) ? 1 : 0;
    //   },
    // );

    return Data.employeeTaken.map((e) => e.toJson()).toList();
  }

  @override
  Future<bool> deleteEmployee({required int id}) async {
    // TODO: implement deleteEmployee
    Data.employeeTaken.removeWhere((item) => item.id == id);
    return true;
  }

  @override
  Future deleteEmployeeList({required List<int> deleteIdList}) async {
    // TODO: implement deleteEmployeeList
    for(int i=0;i<deleteIdList.length;i++){
      Data.employeeTaken.removeWhere((item) => item.id == deleteIdList[i]);
    }
  }

  @override
  Future<bool> editEmployeeDetails({required int id,required Map<String, dynamic> data}) async{
    // TODO: implement updateEmployeeDetails
    Data.employeeTaken.removeWhere((element) => element.id == id);
    return true;
  }


   @override
   Future<bool> undoDeleteEmployeeDetails({required int deleteIndex,required Map<String, dynamic> data}) async{
    // TODO: implement updateEmployeeDetails
     final employeeData = AddEmployeeDetailsDataSet.fromJson(data);
     Data.employeeTaken.insert(deleteIndex, employeeData);
     return true;
  }



}