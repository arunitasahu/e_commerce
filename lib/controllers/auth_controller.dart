import 'package:order/data/repository/auth_repo.dart';
import 'package:order/models/response_model.dart';
import 'package:order/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
     final AuthRepo authRepo;
     AuthController({
       required this.authRepo
});
      bool _isLoading = false;
     bool get isLoading => _isLoading;

   Future<ResponseModel>registration(SignupBody signupBody) async {
       _isLoading=true;
       update();
      Response response=await authRepo.registration(signupBody);
      late ResponseModel responseModel;
      if(response.statusCode==200){
          authRepo.saveUserToken(response.body["token"]);
          print("my token is :"+response.body["token"]);
          responseModel = ResponseModel(true, response.body["token"]);

      }else{
        responseModel = ResponseModel(false, response.statusText!);
      }
       _isLoading=false;
      update();
      return responseModel;
     }
     Future<ResponseModel>login(String email,String password) async {

     print(authRepo.getUserToken().toString());
       _isLoading=true;
       update();
       Response response=await authRepo.login(email,password);
       late ResponseModel responseModel;
       if(response.statusCode==200){


          authRepo.saveUserToken(response.body["token"]);
          print(response.body["token"].toString());
         responseModel = ResponseModel(true, response.body["token"]);
       }else{
         responseModel = ResponseModel(false, response.statusText!);
         // print("Backend error");
       }
       _isLoading=false;
       update();
       return responseModel;
     }
     void saveUserNumberAndPassword(String number,String password,String email)  {
     authRepo.saveUserNumberAndPassword(number,password,email);

     }
     bool userLoggedIn() {
       return authRepo.userLoggedIn();
     }
     bool clearSharedData(){
     return authRepo.clearSharedData();
     }
}