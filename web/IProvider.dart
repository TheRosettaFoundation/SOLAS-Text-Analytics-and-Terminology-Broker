 library TABroker;


abstract class IProvider{
  bool enabled =true;
  String processFile(String jobid,String text) => text;
}