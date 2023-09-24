import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:order/pages/home/food_page_body.dart';
import 'package:order/utils/colors.dart';
import 'package:order/utils/dimensions.dart';
import 'package:order/widgets/big_text.dart';
import 'package:order/widgets/small_text.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: Column(
      // Header, Body, and Footer
      children: [
        //Header
        Container(
          child: Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20), // left 20, right 20
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Header Bar
                children: [
                  Column(
                    // Country and City
                    children: [
                      BigText(text: "India", color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(text: "Bangalore", color: Colors.black54),
                          const Icon(Icons.arrow_drop_down_rounded)
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      // Search Button
                      width: Dimensions.width45, // 45
                      height: Dimensions.height45, // 45
                      child: Icon(Icons.search,
                          color: Colors.white, size: Dimensions.iconSize24),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Dimensions.height15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //Body
        Expanded(
          child: SingleChildScrollView(
            child: FoodPageBody(),
          ),
        ),

        //Footer
      ],
    ), onRefresh: _loadResource);
  }
}
