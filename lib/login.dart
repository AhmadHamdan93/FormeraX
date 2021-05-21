import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'apix/api_manager.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  ProgressDialog progressDialog;
  final myController = TextEditingController();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  void _loginData() async{
    SharedPreferences preferenceData = await SharedPreferences.getInstance();
    String username = myController.text;
    String password = myController1.text;
    String domain = myController2.text;
    if (username.trim().isEmpty){
      final snackBar = SnackBar(content: Text("username is empty , must fill it "),);
      Scaffold.of(context).showSnackBar(snackBar);
      return;
    }
    if (password.trim().isEmpty){
      final snackBar = SnackBar(content: Text("password is empty , must fill it "),);
      Scaffold.of(context).showSnackBar(snackBar);
      return;
    }
    if (domain.trim().isEmpty){
      final snackBar = SnackBar(content: Text("domain is empty , must fill it "),);
      Scaffold.of(context).showSnackBar(snackBar);
      return;
    }

    progressDialog.show();

    Map<String,String> params = {
      'userNameOrEmailAddress':username,
      'password':password,
      'tenancy':domain,
    };
    
    MyHttp myHttp = MyHttp();
    bool result = await myHttp.loginApi(params);
    if (result){
      preferenceData.setBool('login', true);
      preferenceData.setString('username', username);
      preferenceData.setString('password', password);
      preferenceData.setString('domain', domain);
      progressDialog.hide();

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => FormeraSplash()));
    }else{
      progressDialog.hide();
      final snackBar = SnackBar(content: Text("an Error exist in password , username or domain"),);
      Scaffold.of(context).showSnackBar(snackBar);
    }

  }

  @override
  void dispose() {
    myController.dispose();
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,type: ProgressDialogType.Download);
    progressDialog.update(message: "Login ....");
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body:SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(top: 30.0,bottom: 30.0,),
            alignment: Alignment.center,
            child: Image.asset("images/splash_logo.png",width: 100.0,height: 100.0,),
          ),
          new Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(left: 30.0,right: 30.0),
            alignment: Alignment.center,
            child: TextFormField(
              controller: myController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.blue,
                  ),
                  labelText: "UserName"
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(left: 30.0,right: 30.0),
            alignment: Alignment.center,
            child:
              TextFormField(
              controller: myController1,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.visibility,
                    color: Colors.blue,
                  ),
                  labelText: "Password"
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(left: 30.0,right: 30.0),
            alignment: Alignment.center,
            child: TextFormField(
              controller: myController2,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.domain,
                    color: Colors.blue,
                  ),
                  labelText: "Domain"
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(top: 35.0,bottom: 35.0,),
            alignment: Alignment.center,
            child: RaisedButton(
              color: Colors.blue,
              onPressed: (){

               _loginData();

              },
              child: Text("Login",style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),) ,

    );
  }
}

