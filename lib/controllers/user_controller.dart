import 'package:order/data/repository/auth_repo.dart';
import 'package:order/data/repository/user_repo.dart';
import 'package:order/models/response_model.dart';
import 'package:order/models/signup_body_model.dart';
import 'package:order/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo
  });
  bool _isLoading = false;
  late UserModel _userModel;
  bool get isLoading => _isLoading;
  UserModel get userModel =>_userModel;

  Future<ResponseModel>getUserInfo() async {
    Response response=await userRepo.getUserInfo();
    late ResponseModel responseModel;
    print("test"+response.body.toString());
    if(response.statusCode==200){
      _userModel =UserModel.fromJson(response.body);
      _isLoading=true;
      responseModel = ResponseModel(true, "successfully");

    }else{
      print("did not get");
      responseModel = ResponseModel(false, response.statusText!);
      print(response.statusText);
    }

    update();
    return responseModel;
  }
}