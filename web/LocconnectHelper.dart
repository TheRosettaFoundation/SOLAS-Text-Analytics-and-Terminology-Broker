import 'package:xml/xml.dart';
import 'dart:async';
import 'dart:html';
import 'tabroker.dart';



class LocconnectHelper{
  
  static Future<String> downloadJobs() {
    TAMain app = new TAMain();
    Future<String> ret = HttpRequest.getString("${app.conf.urls.locconnect}fetch_job.php/?com=${app.conf.app.comName}");
   return ret;

  }
  
  static Future<String> downloadJob(String jobid) {
    TAMain app = new TAMain();
    Future<String> ret = HttpRequest.getString("${app.conf.urls.locconnect}get_job.php/?com=${app.conf.app.comName}&id=$jobid");
   return ret;

  }
  
  static Future<String> setStatus(String jobid,String progressEnum) {
    TAMain app = new TAMain();
    Future<String> ret = HttpRequest.getString("${app.conf.urls.locconnect}set_status.php/?com=${app.conf.app.comName}&id=$jobid&msg=$progressEnum");
   return ret;

  }
  
  static Future<String> getResource(String jobid) {
    TAMain app = new TAMain();
    Future<String> ret = HttpRequest.getString("${app.conf.urls.locconnect}get_resource.php/?type=${app.conf.app.comName}&id=$jobid");
    return ret;

  }
  
  static Future<String> setFeedback(String jobid,String feedback) {
    TAMain app = new TAMain();
    Future<String> ret = HttpRequest.getString("${app.conf.urls.locconnect}send_feedback.php/?com=${app.conf.app.comName}&id=$jobid&msg=$feedback");
   return ret;

  }
  
  static Future<String> sendOutput(String jobid,String output) {
    TAMain app = new TAMain();
    HttpRequest request = new HttpRequest();
    request.open("post", "${app.conf.urls.locconnect}send_output.php",true);
    request.send("{'com'='${app.conf.app.comName}','id':'$jobid', data:'$output'}");
    
    Future<String> ret = HttpRequest.getString("${app.conf.urls.locconnect}send_output.php/?com=${app.conf.app.comName}&id=$jobid&data=$output");
   return ret;

  }
  
  
}