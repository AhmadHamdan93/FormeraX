import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){Navigator.of(context).pop();},),
        title: Text("About"),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(margin: EdgeInsets.all(5.0),child: Image.asset("images/splash_logo.png"),),
          Container(margin: EdgeInsets.all(5.0),child: Text("2020 FormEra Mobile App",style: TextStyle(fontSize: 24.0),),),
          Container(margin: EdgeInsets.all(5.0),child: Text("Version 1.0.0",style: TextStyle(fontSize: 24.0),),),
          Container(margin: EdgeInsets.all(5.0),child: Text("Powered By Ugarit L.L.C",style: TextStyle(fontSize: 24.0),),),
      ],),)
    );
  }
}
