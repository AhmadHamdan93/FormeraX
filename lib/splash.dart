
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import 'login.dart';
import 'mainform.dart';
import 'permission_activity.dart';



class FormeraSplash extends StatefulWidget {

  bool isLogin = false;
  String username;
  String password;
  String domain;

  @override
  _FormeraSplashState createState() => _FormeraSplashState();
}

class _FormeraSplashState extends State<FormeraSplash> {
  double value = 0.0;
  bool isVisible = false;
  bool checkPermissions = true;

  @override
  void initState() {
    super.initState();
    beginApp();
  }

  void beginApp(){
    readSharedPreferenceData();
    checkPermission();
    Future.delayed(const Duration(seconds: 2),(){
      if((widget.isLogin)){

        if(checkPermissions){

          showProgressBar();
        }else{
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Scaffold(body: CustomePermission())));
        }

      }else{
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Scaffold(body: Login())));
      }
    });
  }

  void showProgressBar(){

    new Timer.periodic(Duration(milliseconds: 30), (Timer t){
      setState(() {
        this.isVisible = true;
        this.value += 0.01;
        if(this.value >= 1.0){
          this.isVisible = false;
          t.cancel();
          // move to next activity main form
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) =>  Scaffold(body: MainForm(),) ));
        }
      });
    });

  }

  void checkPermission() async{
    final cameraPermission = await Permission.camera.status;
    if(!cameraPermission.isGranted){
      checkPermissions = false;
      return;
    }
    final storagePermission = await Permission.storage.status;
    if(!storagePermission.isGranted){
      checkPermissions = false;
      return;
    }
    final microphonePermission = await Permission.microphone.status;
    if(!microphonePermission.isGranted){
      checkPermissions = false;
      return;
    }
    final locationPermission = await Permission.location.status;
    if(!locationPermission.isGranted){
      checkPermissions = false;
      return;
    }
  }

  void readSharedPreferenceData() async{
    SharedPreferences data = await SharedPreferences.getInstance();
    widget.isLogin = data.getBool('login') ?? false;
    widget.username = data.getString("username") ?? '';
    widget.password = data.getString('password') ?? '';
    widget.domain = data.getString('domain') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FormeraX"),
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child:Center(
              child: Image.asset("images/splash_logo.png"),
              ),
          ),
          CustomProgress(visible: isVisible , progress_value: value),
      ],)

    );
  }

}

class CustomProgress extends StatelessWidget{
  final double progress_value;
  final bool visible;
  CustomProgress({this.visible, this.progress_value});

  @override
  Widget build(BuildContext context) {
    return visible ? Container(
      padding: EdgeInsets.only(left: 40.1,right: 40.1,bottom: 20.0),
      child:
      LinearProgressIndicator(
        backgroundColor: Colors.grey,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue,),
        value: progress_value,
      ),
    ) :
    Opacity(opacity: 0.0,
      child :Container(
        padding: EdgeInsets.only(left: 40.1,right: 40.1,bottom: 20.0),
        child:
        LinearProgressIndicator(
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue,),
          value: progress_value,
        ),
      )
    );
  }

}