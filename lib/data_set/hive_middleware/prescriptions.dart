import 'package:hive_flutter/hive_flutter.dart';
import '../../networking/model/request/add_employee_details/req_add_employee_details.dart';
import '../interface/prescriptions.dart';
import '../models/prescriptions/add_employee_details.dart';

class HivePrescriptions extends IEmployeeInterface {


  @override
  Future<bool> addEmployeeDetails({required Map<String, dynamic> data}) async {
    // TODO: implement addEmployeeDetails
    final employeeData = AddEmployeeDetailsDataSet.fromJson(data);

    final box = await Hive.openBox("employeeTable");

    employeeData.dateTime = DateTime.now();
    employeeData.id = box.values.toList().length;

    await box.add(employeeData.toJson());

    return true;
  }

  @override
  Future<List<Map<String, dynamic>>?> getEmployeeDetails() async {
    // TODO: implement getEmployeeDetails
    final box = await Hive.openBox("employeeTable");

    final values = box.values;

    return values.map((e) =>  Map<String, dynamic>.from(e)).toList();
  }



  @override
  Future<bool> deleteEmployee({required int id}) async {
    // TODO: implement deleteEmployee
    final box = await Hive.openBox("employeeTable");

    final listCount = box.values.toList().length;
    for(int i=0;i<listCount;i++){
      final index = box.values.toList().indexWhere((element) {
        return element["id"] == id;
      },);
      if(index >= 0) {
        await box.deleteAt(index);
        return true;
      }
    }
    return true;
  }

  @override
  Future deleteEmployeeList({required List<int> deleteIdList}) async {
    // TODO: implement deleteEmployeeList
    final box = await Hive.openBox("employeeTable");

    final listCount = box.values.toList().length;
    for(int i=0;i<deleteIdList.length;i++) {
      for (int j = 0; j < listCount; j++) {
        final index = box.values.toList().indexWhere((element) {
          return element["id"] == deleteIdList[i];
        },);
        if (index >= 0) {
          await box.deleteAt(index);
        }
      }
    }
  }

  @override
  Future<bool> editEmployeeDetails({required int id,required Map<String, dynamic> data}) async {
// TODO: implement editEmployeeDetails
    final employeeData = AddEmployeeDetailsModel.fromJson(data);

    final box = await Hive.openBox("employeeTable");

    final index = box.values.toList().indexWhere((element) => element["id"] == id);

    final value = await box.getAt(index);

    final employeeDataObj = AddEmployeeDetailsModel.fromJson(Map<String, dynamic>.from(value));
    employeeDataObj.id = employeeData.id;
    employeeDataObj.employeeName = employeeData.employeeName;
    employeeDataObj.roleType = employeeData.roleType;
    employeeDataObj.fromDate = employeeData.fromDate;
    employeeDataObj.endDate = employeeData.endDate;
    employeeDataObj.isEndDate = employeeData.isEndDate;
    employeeDataObj.dateTime = employeeData.dateTime;

    Hive.box('employeeTable').putAt(id, employeeData.toJson());
    Hive.box('employeeTable').close();
    return true;
  }

}

