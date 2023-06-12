import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../interface/connection.dart';

class HiveConnection extends IConnectionInterface {

  BoxCollection? collection;

  final boxNames = {
    "employeeTable"
  };

  @override
  Future connect() async {

    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init('${directory.path}/home');
    print("pathhhhh ==> ${directory.path}/home");
    collection = await BoxCollection.open(
      'employee', // Name of your database
      boxNames, // Names of your boxes
      path: "${directory.path}/home",
    );

  }

  @override
  Future init() async {
    // initialise
    // await Hive.initFlutter();
  }

  @override
  Future dataSetup() async {
    final reasonBox = await Hive.openBox("reasons_for_exemption");
    // if(reasonBox.isEmpty) {
    //   final list = ReasonForExemptionsDataSet.value;
    //
    //   await reasonBox.addAll(list.map((e) => e.toJson()));
    // }
  }

  @override
  Future delete() async {
    await collection?.deleteFromDisk();
  }
}