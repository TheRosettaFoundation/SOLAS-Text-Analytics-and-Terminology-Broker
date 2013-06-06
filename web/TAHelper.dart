import 'package:xml/xml.dart';
import 'dart:json';
import 'tabroker.dart';
import 'dart:async';
import 'dart:html';
import 'dart:core';
class TAHelper{
  
  void processJobs(){
    downloadJobs().then((e)=>e.forEach((i)=>processJob(i)));
    print("hi ");
  }
  
  void processJob(String str) {
    print(str);
  }
  
  Future<List> downloadJobs() {
    TAMain app = new TAMain();
//    HttpRequest.getString("${app.conf.locconnectUrl}fetch_job.php").then((jobs)=>parseJobs(jobs));
    Future<List> ret = HttpRequest.getString("${app.conf.locconnectUrl}fetch_job.php").then((jobs)=>new Future.value((parseJobs(jobs))));
   return ret;

  }
  
  List<String> parseJobs(String jobs) {
//    var xml = XML.parse(jobs);
    return new List<String>.filled(5, "test");
  }
  
  
}