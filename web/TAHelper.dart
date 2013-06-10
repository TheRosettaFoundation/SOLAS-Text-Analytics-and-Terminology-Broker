import 'package:xml/xml.dart';
import 'dart:json';
import 'tabroker.dart';
import 'LocconnectHelper.dart';
import 'dart:async';
import 'dart:html';
import 'ProgressEnum.dart';

class TAHelper{
  
  void processJobs(){
    downloadJobs().then((e)=>e.forEach((i)=>processJob(i)));
  }
  
  void processJob(String jobid) {
    LocconnectHelper.setStatus(jobid, ProgressEnum.PROCESSING).then((HttpRequest responce)=>print(responce.responseText));
    LocconnectHelper.setFeedback(jobid, "testing").then((HttpRequest responce)=>print(responce.responseText));
    downloadJob(jobid).then((e)=>print(jobid));
    LocconnectHelper.setStatus(jobid, ProgressEnum.PENDING).then((HttpRequest responce)=>print(responce.responseText));
  }
  
  downloadJob(String jobid)=>LocconnectHelper.downloadJob(jobid);
  
  Future<List> downloadJobs() {
    TAMain app = new TAMain();
    Future<List> ret = LocconnectHelper.downloadJobs().then((jobs)=>new Future.value((parseJobs(jobs))));
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