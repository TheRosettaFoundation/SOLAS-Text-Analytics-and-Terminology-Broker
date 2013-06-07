import 'package:xml/xml.dart';
import 'dart:async';
import 'dart:html';
import 'tabroker.dart';
import 'dart:json';



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
  
  static Future<HttpRequest> setStatus(String jobid,String progressEnum) {
    TAMain app = new TAMain();
    var data = "{'com':'${app.conf.app.comName}','id':'$jobid', msg:'$progressEnum'}";
    var url = "${app.conf.urls.locconnect}set_status.php";
    return HttpRequest.request(url, method:"POST",sendData:data);

  }
  
  static Future<String> getResource(String jobid) {
    TAMain app = new TAMain();
    Future<String> ret = HttpRequest.getString("${app.conf.urls.locconnect}get_resource.php/?type=${app.conf.app.comName}&id=$jobid");
    return ret;

  }
  
  static Future<HttpRequest> setFeedback(String jobid,String feedback) {
    TAMain app = new TAMain();
    var data = {"com":app.conf.app.comName,"id":jobid,"msg":feedback};
//    var data = "{'com':'${app.conf.app.comName}','id':'$jobid', msg:'$feedback'}";
    
    data=stringify(data);
    var url = "${app.conf.urls.locconnect}send_feedback.php";
    var req = new HttpRequest();
    req.open("POST",url,async:false);
    //req.setRequestHeader('Content-type','application/json');
    req.send(data);
    print(req.responseText);
   return HttpRequest.request(url, method:"POST",sendData:data);
  }
  
  static Future<HttpRequest> sendOutput(String jobid,String output) {
    TAMain app = new TAMain();
    var data = "{'com':'${app.conf.app.comName}','id':'$jobid', data:'$output'}";
    var url = "${app.conf.urls.locconnect}send_output.php";
   return HttpRequest.request(url, method:"POST",sendData:data);

  }
  
  
}