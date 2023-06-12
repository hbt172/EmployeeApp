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

    collection = await BoxCollection.open(
      'employee', // Name of your database
      boxNames, // Names of your boxes
      path: "${directory.path}/home",
    );

  }

  @override
  Future init() async {
    // initialise
  }

  @override
  Future dataSetup() async {
  }

  @override
  Future delete() async {
    await collection?.deleteFromDisk();
  }
}