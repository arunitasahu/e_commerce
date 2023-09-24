import 'package:order/data/api/api_client.dart';
import 'package:order/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  // if using GetX State Management,
  //You have to extends GetxService to get data from internet

  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    //return apiClient.getData("http://jaridekat.com/product/list");

    return apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
