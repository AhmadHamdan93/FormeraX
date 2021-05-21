import 'package:flutter/material.dart';
import 'package:formerax/splash.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomePermission extends StatefulWidget {
  @override
  _CustomePermissionState createState() => _CustomePermissionState();
}

class _CustomePermissionState extends State<CustomePermission> {

  String msg = "Allow application access to your camera,record audio,device storage and location."
      "These permissions are needed in the forms or assessments for capturing photos, select media from gallery.";

  void checkPermission() async{
    int count = 0;
    final cameraPermission = await Permission.camera.status;
    if(!cameraPermission.isGranted){
      final status = await Permission.camera.request();
      if (status.isGranted){
        count += 1;
      }
    }else{
      count += 1;
    }
    final storagePermission = await Permission.storage.status;
    if(!storagePermission.isGranted){
      final status = await Permission.storage.request();
      if (status.isGranted){
        count += 1;
      }
    }else{
      count += 1;
    }
    final microphonePermission = await Permission.microphone.status;
    if(!microphonePermission.isGranted){
      final status = await Permission.microphone.request();
      if (status.isGranted){
        count += 1;
      }
    }else{
      count += 1;
    }
    final locationPermission = await Permission.location.status;
    if(!locationPermission.isGranted){
      final status = await Permission.location.request();
      if (status.isGranted){
        count += 1;
      }
    }else{
      count += 1;
    }

    if(count == 4){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Scaffold(body: FormeraSplash(),)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("FormeraX"),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
          Container(child: Text(msg,style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),margin: EdgeInsets.all(20.0),),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: checkPermission,
              child: Text("TRUN ON ACCESS",style: TextStyle(color: Colors.white),),color: Colors.blue,),),
        ],)
        ,),

    );
  }
}
