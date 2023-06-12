abstract class IEmployeeInterface {
  Future<bool> addEmployeeDetails({required Map<String,dynamic> data});
  Future<List<Map<String,dynamic>>?> getEmployeeDetails();
  Future<bool> deleteEmployee({required int id});
  deleteEmployeeList({required List<int> deleteIdList});
  Future<bool> editEmployeeDetails({required int id,required Map<String, dynamic> data});
}