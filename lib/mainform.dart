
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'company_about.dart';
import 'login.dart';

class MainForm extends StatefulWidget {
  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  String title = "FormeraX";
  final taps = [Center(child: Text('Forms'),),
              Center(child: Text('LocalData'),),
              Center(child: Text('Sync'),),
              Center(child: Text('Profile'),),
              MyButton()];
  final myTitle=[Text('FormeraX'),
    Text('LocalData'),
    Text('Sync Data'),
    Text('Profile'),
    Text('Logout'),];
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: myTitle[_currentIndex],
        actions: [
          _currentIndex == 0 ? InkWell(child: SizedBox(width: 40.0,child: IconButton(color: Colors.white,icon:Icon( Icons.language), onPressed: () { Scaffold.of(context).showSnackBar(new SnackBar(content: Text("just Language English "))); },),),) : Container(),
          _currentIndex == 0 ? InkWell(child: SizedBox(width: 40.0,child: IconButton(color: Colors.white,icon:Icon( Icons.info_outline), onPressed: _moveToAbout,),),) : Container(),
        ],
      ),
      body: taps[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            title: Text("Forms"),
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.desktop_mac),
              title: Text("LocalData"),
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.sync),
              title: Text("Sync"),
              backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              backgroundColor: Colors.deepOrange
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.power_settings_new),
              title: Text("Logout"),
              backgroundColor: Colors.black45
          ),

        ],
      onTap: (value){
          setState(() {
            _currentIndex = value;
          });

      },
      ),
    );
  }

  void _moveToAbout () {
    Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Scaffold(body: About())));
  }
}
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: RaisedButton(
      onPressed: () async {
        SharedPreferences preferenceData = await SharedPreferences.getInstance();
        preferenceData.setBool('login', false);
        preferenceData.setString('username', '');
        preferenceData.setString('password', '');
        preferenceData.setString('domain', '');
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(BuildContext context) => Scaffold(body: Login())));
      },
      child: Text("Logout"),),);
  }
}

