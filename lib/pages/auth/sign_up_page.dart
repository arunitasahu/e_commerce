import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:order/base/custom_loader.dart';
import 'package:order/base/show_custom_snackbar.dart';
import 'package:order/controllers/auth_controller.dart';
import 'package:order/models/signup_body_model.dart';
import 'package:order/routes/route_helper.dart';
import 'package:order/utils/Dimensions.dart';
import 'package:order/utils/colors.dart';
import 'package:order/widgets/app_text_field.dart';
import 'package:order/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages =[
      "t.png",
      "f.png",
      "g.png"
    ];

    void _registration(AuthController authController){
      // var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String  password = passwordController.text.trim();

      if(name.isEmpty){
         showCustomSnackBar("Type in your name",title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone Number",title: "Phone Number");

      }else if (email.isEmpty){
        showCustomSnackBar("Type in your email",title: "Email address");

      }else if (!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address",title: "Valid email address");

      }else if (password.isEmpty){
        showCustomSnackBar("Type in your password",title: "Password");

      }else if (password.length<8){
        showCustomSnackBar("Password can not be less than eight characters",title: "Password");

      }else{
        showCustomSnackBar("All went well....",title: "AWESOME!");
        SignupBody signupBody =SignupBody(name: name,
            phone: phone,
            email: email,
            password: password);
        print(signupBody.toString());
        authController.registration(signupBody).then((status){
          if(status.isSuccess){
            print("Success registration");
            Get.offNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });

      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHight*0.05,),
              //app logo
              Container(
                height:Dimensions.screenHight*0.25,
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
              //your email
              AppTextField(textController: emailController, hintText: "Email", icon:Icons.email),
              SizedBox(height: Dimensions.height20,),
              //your password
              AppTextField(textController: passwordController, hintText: "Password", icon:Icons.password_sharp,isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              //your name
              AppTextField(textController: nameController, hintText: "Name", icon:Icons.person),
              SizedBox(height: Dimensions.height20,),
              // your phone
              AppTextField(textController: phoneController, hintText: "Phone", icon:Icons.phone),
              SizedBox(height: Dimensions.height20,),
              // signup botton
              GestureDetector(
                onTap:(){
                  _registration(_authController);
                },
                child: Container(
                  width: Dimensions.screenHight/4,
                  height: Dimensions.screenHight/14,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),
                  child: Center(
                    child: BigText(text: "Sign up",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),

                ),
              ),
              SizedBox(height: Dimensions.height10,),
              //tag line
              RichText(text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Have an account already?",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20
                  )
              )),
              SizedBox(height: Dimensions.screenHight*0.05,),
              //sign up option
              RichText(text: TextSpan(
                  text: "Sign up using one of the following methods.",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16
                  )
              )),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage:AssetImage(
                        "assets/image/"+signUpImages[index]
                    ),
                  ),
                )),
              )

            ],
          ),
        ): const CustomLoader();
      //      CircularProgressIndicator();
      }),
    );



  }
}
