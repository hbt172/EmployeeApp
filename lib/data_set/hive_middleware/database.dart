import 'package:flutter_assignment/data_set/hive_middleware/prescriptions.dart';
import '../interface/database.dart';
import 'connection.dart';

class HiveDatabase extends IDatabase {

  HiveDatabase() {
    super.connection = HiveConnection();
    super.employee = HivePrescriptions() ;
  }

  get connectionSet => super.connection;

  @override
  Future start() async {
    await connection.init();
    await connection.connect();
    await connection.dataSetup();
  }

  @override
  Future clear() async {

    await connection.delete();

  }

}