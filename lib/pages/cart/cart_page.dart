import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:order/base/no_data_page.dart';
import 'package:order/controllers/cart_controller.dart';
import 'package:order/controllers/popular_product_controller.dart';
import 'package:order/controllers/recommended_product_controller.dart';
import 'package:order/routes/route_helper.dart';
import 'package:order/utils/app_constants.dart';
import 'package:order/utils/colors.dart';
import 'package:order/utils/dimensions.dart';
import 'package:order/widgets/app_icon.dart';
import 'package:order/widgets/big_text.dart';
import 'package:order/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:order/base/no_data_page.dart';

import '../../controllers/auth_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height60,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                SizedBox(width: Dimensions.width100),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(
            builder: (_cartController) {
              return _cartController.getItems.length>0?Positioned(
                top: Dimensions.height100,
                right: Dimensions.width20,
                left: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height10,
                  ),
                  //color: Colors.redAccent,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (CartController) {
                        var _cartList =_cartController.getItems;
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index) {
                              return Container(
                                height: Dimensions.height100,
                                width: double.maxFinite,
                                // color: AppColors.mainColor,
                                margin: EdgeInsets.only(
                                  bottom: Dimensions.height10,
                                ),
                                child: Row(
                                  children: [
                                    // Food Picture
                                    GestureDetector(
                                      onTap: () {
                                        var _popularIndex =
                                        Get.find<PopularProductController>()
                                            .popularProductList
                                            .indexOf(_cartList[index].product!);

                                        if (_popularIndex >= 0) {
                                          // product is from Popular Product List
                                          Get.toNamed(
                                              RouteHelper.getPopularFoodDetail(
                                                  _popularIndex, "cartpage"));
                                        } else {
                                          // product is from Recommended Product List
                                          var _recommendedIndex = Get.find<
                                              RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(_cartList[index].product!);
                                          if(_recommendedIndex<0){
                                            Get.snackbar(
                                              "History product",
                                              "Product review not available!",
                                              backgroundColor: AppColors.mainColor,
                                              colorText: Colors.white,
                                            );
                                          }
                                          else
                                          {
                                            Get.toNamed(
                                                RouteHelper.getRecommendedFoodDetail(
                                                    _recommendedIndex, "cartpage"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: Dimensions.height100,
                                        width: Dimensions.width100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: AppColors.mainBlackColor,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.IMAGE_UPLOADS_URL +
                                                    _cartList[index].img!),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    /** All Component besides Food Picture **/
                                    // Using Expanded to maximize horizontally because the parent is Row
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(
                                              text: _cartList[index].name!,
                                              color: Colors.black54,
                                            ),
                                            SmallText(
                                              text: "Spicy",
                                              color: Colors.grey,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                BigText(
                                                    text:
                                                    "\$${_cartList[index].price}",
                                                    color: Colors.red),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: Dimensions.height15,
                                                    bottom: Dimensions.height15,
                                                    left: Dimensions.width20,
                                                    right: Dimensions.width20,
                                                  ),
                                                  // height: Dimensions.height1 * 200,
                                                  // width: Dimensions.width1 * 120,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          CartController.addItem(
                                                              _cartList[index]
                                                                  .product!,
                                                              -1);
                                                        },
                                                        child: Icon(Icons.remove,
                                                            color: AppColors
                                                                .signColor),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                          Dimensions.width10),
                                                      BigText(
                                                        text: _cartList[index]
                                                            .quantity
                                                            .toString(),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                          Dimensions.width10),
                                                      GestureDetector(
                                                        onTap: () {
                                                          CartController.addItem(
                                                              _cartList[index]
                                                                  .product!,
                                                              1);
                                                        },
                                                        child: Icon(Icons.add,
                                                            color: AppColors
                                                                .signColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }
                    ),
                  ),
                ),
              ):NoDataPage(text: "empty cart");
            },
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: Dimensions.bottomHeightBar * 0.78,
          width: double.maxFinite,
          padding: EdgeInsets.only(
            top: Dimensions.height20,
            bottom: Dimensions.height20,
            left: Dimensions.width20,
            right: Dimensions.width20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20 * 2),
              topRight: Radius.circular(Dimensions.radius20 * 2),
            ),
            color: AppColors.buttonBackgroundColor,
          ),
          child: cartController.getItems.length>0 ?
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Minus, Plus and Counting of Food
            Container(
              padding: EdgeInsets.only(
                top: Dimensions.height15,
                bottom: Dimensions.height15,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              // height: Dimensions.height1 * 200,
              // width: Dimensions.width1 * 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: Dimensions.width10),
                  BigText(
                      text: "\$ " + cartController.totalAmount.toString()),
                  SizedBox(width: Dimensions.width10),
                ],
              ),
            ),

            GestureDetector(
            onTap: () {
            //popularProduct.addItem
            if(Get.find<AuthController>().userLoggedIn()){
            print('tapped');
            cartController.addToHistory();
            }else{
            // Get.toNamed(RouteHelper.getInitial());
            Get.toNamed(RouteHelper.getSignInPage());
            }

            },
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  bottom: Dimensions.height15,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                // height: Dimensions.height1 * 200,
                // width: Dimensions.width1 * 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),

                child: BigText(
                  text: " CHECK OUT",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ):Container(),
        );
      }),
    );
  }
}
