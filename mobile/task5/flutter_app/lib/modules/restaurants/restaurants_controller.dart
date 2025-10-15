import 'package:flutter_app/data/models/restaurant_model.dart';
import 'package:flutter_app/data/providers/restaurant_provider.dart';
import 'package:get/get.dart';

class RestaurantsController extends GetxController {
  var isFetchingRestaurants = false.obs;
  RxList<RestaurantModel?> restaurants = RxList([]);
  final restaurantProvider = RestaurantProvider();

  Future<void> fetchRestaurants() async {
    isFetchingRestaurants.value = true;
    final response = await restaurantProvider.fetchRestaurants();
    isFetchingRestaurants.value = false;
    // res
    restaurants.value = response.items ?? [];
    print("Items are : ${response.items?.length}");
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchRestaurants();
  }
}
