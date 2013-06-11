library TABroker.Providers;
import 'package:xml/xml.dart';
import 'dart:async';
import 'dart:html';
import '../tabroker.dart';
import '../IProvider.dart';
import '../LocconnectHelper.dart';
import 'dart:json';
import 'dart:core';



class Tilde extends IProvider {
  

  String processFile(String jobid,String text) {
    if(text==null||text=="")return text;
    LocconnectHelper.setFeedback(jobid, "sending file for external processing").then((HttpRequest responce)=>print(responce.responseText));
     if(text.startsWith("<content>")){
       text=text.replaceFirst("<content>", "");
       text=text.substring(0,text.lastIndexOf("</content>"));
     }
     print(text);
//     var xml = XML.parse(text);    
     TAMain app = new TAMain();
     var url = "http://taws.tilde.com/api/xliff";
     HttpRequest request = new HttpRequest();
     request.open("POST", url, async: false);
     request.send(text);
     LocconnectHelper.setFeedback(jobid, "external processing complete").then((HttpRequest responce)=>print(responce.responseText));
     return request.responseText;
  }
  
}