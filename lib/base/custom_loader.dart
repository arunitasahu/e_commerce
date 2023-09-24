import 'package:flutter/material.dart';
import 'package:order/controllers/auth_controller.dart';
import 'package:order/utils/Dimensions.dart';
import 'package:order/utils/colors.dart';
import 'package:get/get.dart';



class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("I am  printing loading state "+Get.find<AuthController>().isLoading.toString());
    return Center(
      child: Container(
        height:Dimensions.height20*5,
        width: Dimensions.height20*5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.height20*5/2),
            color: AppColors.mainColor
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
