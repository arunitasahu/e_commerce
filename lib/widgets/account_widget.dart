import 'package:flutter/material.dart';
import 'package:order/utils/Dimensions.dart';
import 'package:order/widgets/app_icon.dart';
import 'package:order/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
   AccountWidget({Key? key,required this.appIcon,required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
       padding: EdgeInsets.only(
         left: Dimensions.width20,
         top: Dimensions.width10,
         bottom: Dimensions.width10

       ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,),
          bigText,
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0,2),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),

    );
  }
}
