library TABroker;
import 'package:xml/xml.dart';
import 'dart:json';
import 'tabroker.dart';
import 'LocconnectHelper.dart';
import 'dart:async';
import 'dart:html';
import 'IProvider.dart';
import 'ProgressEnum.dart';
import 'providers/Tilde.dart';

class TAHelper{
  
  void processJobs(){
    downloadJobs().then((e)=>e.forEach((i)=>processJob(i)));
  }
  
  void processJob(String jobid) {
   LocconnectHelper.setStatus(jobid, ProgressEnum.PROCESSING)
   .then((HttpRequest responce){
     TAMain.ouputText(responce.responseText);
     IProvider service = new Tilde();
     LocconnectHelper.setFeedback(jobid, "the job is now being process")
     .then((HttpRequest re){
       TAMain.ouputText(re.responseText); 
         downloadJob(jobid)
         .then((e){
             LocconnectHelper.sendOutput(jobid,service.processFile(jobid,e))
             .then((e)=>LocconnectHelper.setFeedback(jobid, "processing complete"))
             .then((e)=>LocconnectHelper.setStatus(jobid, ProgressEnum.COMPLETE))
             .then((HttpRequest responce)=>TAMain.ouputText(responce.responseText));
         });
     });
     
     
     
   });
  }
  
  downloadJob(String jobid){
    LocconnectHelper.setFeedback(jobid, "downloading job file").then((HttpRequest responce)=>TAMain.ouputText(responce.responseText));
    Future<String> ret =  LocconnectHelper.downloadJob(jobid);
    ret.then((e)=>LocconnectHelper.setFeedback(jobid, "downloading complete").then((HttpRequest responce)=>TAMain.ouputText(responce.responseText)));
    return ret;
  }
  
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