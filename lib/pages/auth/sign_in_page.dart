import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:order/base/custom_loader.dart';
import 'package:order/base/show_custom_snackbar.dart';
import 'package:order/controllers/auth_controller.dart';
import 'package:order/pages/auth/sign_up_page.dart';
import 'package:order/routes/route_helper.dart';
import 'package:order/utils/Dimensions.dart';
import 'package:order/utils/colors.dart';
import 'package:order/widgets/app_text_field.dart';
import 'package:order/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var passwordController = TextEditingController();
    var emailController = TextEditingController();
    void _login(AuthController authController){

      String email = emailController.text.trim();
      String  password = passwordController.text.trim();

      if (email.isEmpty){
        showCustomSnackBar("Type in your email",title: "Email address");

      }else if (!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address",title: "Valid email address");

      }else if (password.isEmpty){
        showCustomSnackBar("Type in your password",title: "Password");

      }else if (password.length<8){
        showCustomSnackBar("Password can not be less than eight characters",title: "Password");

      }else{
        authController.login(email,password).then((status){
          if(status.isSuccess){
            print("Success registration");
            // Get.toNamed(RouteHelper.getInitial());
            Get.toNamed(RouteHelper.getCartPage());
          }else{
            showCustomSnackBar(status.message);
          }
        });

      }
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController){
          return !authController.isLoading? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Dimensions.screenHeight*0.05,),
                //app logo
                Container(
                  height:Dimensions.screenHeight*0.25,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor:Colors.white,
                      radius: 80,
                      backgroundImage: AssetImage(
                          "assets/image/logo part 1.png"
                      ),
                    ),
                  ),
                ),

                //welcome
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                            fontSize: Dimensions.font20*3+Dimensions.font20/2,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      Text(
                        "Sign into your account",
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20,),
                //your email
                AppTextField(textController: emailController, hintText: "Email", icon:Icons.email),
                SizedBox(height: Dimensions.height20,),
                //your password
                AppTextField(textController: passwordController, hintText: "Password", icon:Icons.password_sharp,isObscure: true,),
                SizedBox(height: Dimensions.height20,),


                // SizedBox(height: Dimensions.height10,),
                //tag line
                Row(
                  children: [
                    Expanded(child: Container()),
                    RichText(text: TextSpan(
                      // recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                        text: "Sign into your account",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20
                        )
                    )),
                    SizedBox(width:Dimensions.width20),
                  ],
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                //sign in
                GestureDetector(
                  onTap:(){
                    _login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenHeight/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.mainColor
                    ),
                    child: Center(
                      child: BigText(text: "Sign in",
                        size: Dimensions.font20+Dimensions.font20/2,
                        color: Colors.white,
                      ),
                    ),

                  ),
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                //sign up option
                RichText(text: TextSpan(
                    text: "Don\'t an account?",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    ),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                          text: " Create",
                          style: TextStyle(
                              fontWeight:FontWeight.bold,
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20
                          ) ),
                    ]
                )
                ),


              ],
            ),
          ):CustomLoader();
        },)
    );
  }
}
