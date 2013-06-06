import 'package:xml/xml.dart';
import 'dart:json';
import 'tabroker.dart';
import 'dart:async';
import 'dart:html';
import 'dart:core';
class TAHelper{
  
  void processJobs(){
    downloadJobs().then((e)=>e.forEach((i)=>processJob(i)));
  }
  
  void processJob(String jobid) {
    downloadJob(jobid);
  }
  
  downloadJob(String jobid)=>print(jobid);
  
  Future<List> downloadJobs() {
    TAMain app = new TAMain();
//    HttpRequest.getString("${app.conf.locconnectUrl}fetch_job.php").then((jobs)=>parseJobs(jobs));
    Future<List> ret = HttpRequest.getString("${app.conf.urls.locconnect}fetch_job.php/?com=${app.conf.app.comName}").then((jobs)=>new Future.value((parseJobs(jobs))));
   return ret;

  }
  
  List<String> parseJobs(String jobs) {
    List ret = new List();
    try{
      var xml = XML.parse(jobs);
      XmlCollection jobNodes =xml.queryAll("job");
      
      jobNodes.forEach((XmlElement e)=> ret.add(e.text));
    }catch(e){}
    return ret;
  }
  
  
}