
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttp {
  static const BASE_DEFAULT_URL = "https://webapp.formera.xyz";
  static const LOGIN = "TokenAuth/Authenticate";
  static const HIDE_APP_CODE = "TokenAuth/HideAppSecretCode";


  Future<bool> loginApi(Map<String,String> params) async{

      Response res = await post(
          "${MyHttp.BASE_DEFAULT_URL}/api/${MyHttp.LOGIN}",
          headers: <String,String>{'Content-Type':'application/json;charset=UTF-8','X-App-Version':'18'},
          body: jsonEncode(params));

      print("Post StatusCode : "+res.statusCode.toString());
      if(res.statusCode == 200){
        print("------------success------------");
        Map allData = json.decode(res.body);
        // print(allData['success']);
        if(allData['success'] == true){

          Map result = allData['result'];
          SharedPreferences keyLoginData = await SharedPreferences.getInstance();
          keyLoginData.setString("accessToken", result['accessToken']);
          keyLoginData.setString("encryptedAccessToken", result['encryptedAccessToken']);
          keyLoginData.setInt("expireInSeconds", result['expireInSeconds']);
          keyLoginData.setInt("userId", result['userId']);

          bool checkHide = await hideAppCode();
          if(checkHide){
            return true;
          }else{
            return false;
          }

        }else{
          print('Cannot Registration with Formera Web');
          return false;
        }

        // return Post.fromJson(result);  // jsonDecode(res.body)
      }else{
        print("------------error-----------");
        return false;
      }

  }

  Future<bool> hideAppCode() async{
    SharedPreferences keyLoginData = await SharedPreferences.getInstance();
    String token = keyLoginData.getString("accessToken");
    Response res = await get(
        "${MyHttp.BASE_DEFAULT_URL}/api/${MyHttp.HIDE_APP_CODE}",
        headers: <String,String>{
          'Content-Type':'application/json;charset=UTF-8',
          'X-App-Version':'18',
          'Authorization':"Bearer "+token,
        }
    );
    print("Status code hideAppCode : "+res.statusCode.toString());
    Map allData = json.decode(res.body);

    if(res.statusCode == 200){
      print("++++++++++ success Hide App Code +++++++++");
      if(allData['success'] == true){
        var code = allData['result'];
        print("code for login : "+ code);
        keyLoginData.setString("code", code);
        return true;
      }else{
        print('Cannot Hide Code');
        return false;
      }
      // print("All data : " +allData.toString());
    }else{
      print("++++++++++ Failed Hide App Code +++++++++");
      return false;
    }
  }

}