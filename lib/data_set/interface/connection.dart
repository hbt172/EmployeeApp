abstract class IConnectionInterface {

  Future connect();

  Future init();

  Future dataSetup();

  Future delete();

}