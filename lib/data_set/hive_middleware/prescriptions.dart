import 'package:hive_flutter/hive_flutter.dart';
import '../../networking/model/request/add_employee_details/req_add_employee_details.dart';
import '../interface/prescriptions.dart';
import '../models/prescriptions/add_employee_details.dart';

class HivePrescriptions extends IEmployeeInterface {


  @override
  Future<bool> addEmployeeDetails({required Map<String, dynamic> data}) async {
    // TODO: implement addMedication
    final employeeData = AddEmployeeDetailsDataSet.fromJson(data);

    // bloodPressure.dateTime = DateTime.now();

    final box = await Hive.openBox("employeeTable");

    employeeData.dateTime = DateTime.now();
    employeeData.id = box.values.toList().length;

    await box.add(employeeData.toJson());

    // box.close();
    return true;
  }

  @override
  Future<List<Map<String, dynamic>>?> getEmployeeDetails() async {
    // TODO: implement getMedication
    final box = await Hive.openBox("employeeTable");

    final values = box.values;
    // box.close();
    return values.map((e) =>  Map<String, dynamic>.from(e)).toList();
  }



  @override
  Future<bool> deleteEmployee({required int id}) async {
    // TODO: implement deleteReOrderReminder
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
    // TODO: implement deleteReOrderReminder
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

  // @override
  // Future<bool> editEmployeeDetails({required int id,required AddEmployeeDetailsModel addEmployeeDetailsModel}) async{
  //   // TODO: implement deleteReminder
  //   Map<dynamic,dynamic> record= Hive.box('employeeTable').getAt(id);
  //   record["employeeName"] = addEmployeeDetailsModel.employeeName;
  //   record["roleType"] = addEmployeeDetailsModel.roleType;
  //   record["fromDate"] = addEmployeeDetailsModel.fromDate;
  //   record["endDate"] = addEmployeeDetailsModel.endDate;
  //   record["isEndDate"] = addEmployeeDetailsModel.isEndDate;
  //   record["dateTime"] = addEmployeeDetailsModel.dateTime;
  //   Hive.box('employeeTable').putAt(id,record);
  //   return true;
  // }


  @override
  Future<bool> editEmployeeDetails({required int id,required Map<String, dynamic> data}) async {

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

  @override
  Future<bool> undoDeleteEmployeeDetails({required int deleteIndex,required Map<String, dynamic> data}) async {
    final employeeData = AddEmployeeDetailsModel.fromJson(data);
    // Hive.box('employeeTable').putAt(deleteIndex, employeeData.toJson());
    Hive.box('employeeTable').add(employeeData.toJson());
    Hive.box('employeeTable').close();
    return true;
  }
}

