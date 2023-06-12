import '../interface/database.dart';
import 'connection.dart';

class LocalDatabase extends IDatabase {

  LocalDatabase() {
    super.connection = LocalConnection();
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