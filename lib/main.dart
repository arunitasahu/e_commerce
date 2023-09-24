import 'package:flutter/material.dart';
import 'package:order/controllers/cart_controller.dart';
import 'package:order/controllers/popular_product_controller.dart';
import 'package:order/controllers/recommended_product_controller.dart';
import 'package:order/pages/auth/sign_in_page.dart';
import 'package:order/pages/food/popular_food_detail.dart';
import 'package:order/pages/food/recommended_food_details.dart';
import 'package:order/pages/home/food_page_body.dart';
import 'package:order/pages/home/main_food_page.dart';
import 'package:order/pages/splash/splash_page.dart';
import 'package:order/routes/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // make sure all dependencies are loaded completely
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Get.find<CartController>().getCartData();

    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
         initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });


  }
}
