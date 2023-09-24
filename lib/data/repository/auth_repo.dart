import 'package:order/data/api/api_client.dart';
import 'package:order/models/signup_body_model.dart';
import 'package:order/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,

});
  Future<Response>registration(SignupBody signupBody) async {
     return await apiClient.postData(AppConstants.REGISTRATION_URI, signupBody.toJson());
  }
  bool userLoggedIn() {
    return  sharedPreferences.containsKey(AppConstants.TOKEN);
  }
  Future<String> getUserToken() async {
    return  sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }
  Future<Response>login(String email,String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI,
        {"email":email,"password":password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token=token;
    apiClient.updateHeader(token);
    return  await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void>saveUserNumberAndPassword(String number,String password ,String email) async {
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.EMAIL, email);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }

  bool clearSharedData(){
        sharedPreferences.remove(AppConstants.TOKEN);
        sharedPreferences.remove(AppConstants.PASSWORD);
        sharedPreferences.remove(AppConstants.PHONE);
        sharedPreferences.remove(AppConstants.EMAIL);
        apiClient.token='';
        apiClient.updateHeader('');
       return true;
  }










}