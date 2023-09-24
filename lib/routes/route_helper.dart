import 'package:order/pages/address/add_address_page.dart';
import 'package:order/pages/auth/sign_in_page.dart';
import 'package:order/pages/cart/cart_page.dart';
import 'package:order/pages/food/popular_food_detail.dart';
import 'package:order/pages/food/recommended_food_details.dart';
import 'package:order/pages/home/home_page.dart';
import 'package:order/pages/home/main_food_page.dart';
import 'package:order/pages/splash/splash_page.dart';
import 'package:get/get.dart';


class RouteHelper {
  static const String splashPage = '/splash-page';
  static const String initial = '/';
  static const String popularFoodDetail = '/popular-food';
  static const String recommendedFoodDetail = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String signIn = '/sign_in';
  static const String addAddress = '/add_address';



  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getRecommendedFoodDetail(int pageId, String page) => '$recommendedFoodDetail?pageId=$pageId&page=$page';
  static String getPopularFoodDetail(int pageId, String page) => '$popularFoodDetail?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  static String getAddressPage() => '$addAddress';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () {  return HomePage();}),

    GetPage(
        name: signIn,
        page: () {
          return SignInPage();
        },
        transition: Transition.fadeIn),

    GetPage(
      name: recommendedFoodDetail,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];

        return RecommendedFoodDetails(pageId: int.parse(pageId!),page: page!,);
      },
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: popularFoodDetail,
      page: () {
        print("popular Food page ");
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!),page: page!);

      },
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
GetPage(name: addAddress, page: (){
  return AddAddressPage();
}),
  ];
}
