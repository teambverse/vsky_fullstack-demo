import 'package:flutter_app/data/api_provider/api_constant.dart';
import 'package:flutter_app/data/api_provider/api_provider.dart';
import 'package:flutter_app/data/injector.dart';
import 'package:flutter_app/data/models/restaurant_model.dart';
import 'package:flutter_app/data/shared/page_response.dart';

class RestaurantProvider {
  late ApiProvider _apiProvider;

  RestaurantProvider() {
    _apiProvider = Injector().apiProvider();
  }

  Future<PageResponse<RestaurantModel?>> fetchRestaurants() async {
    return await _apiProvider.request(
      endpoint: ApiConstant.restaurants,
      method: "GET",
      fromJson: (json) => RestaurantModel.fromJson(json),
      parseResponse: (data) {
        if (data is List) {
          // When backend returns just a list
          final restaurants = data
              .map(
                (json) =>
                    RestaurantModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();

          return PageResponse<RestaurantModel>(
            isSuccess: true,
            totalRecords: restaurants.length,
            items: restaurants,
          );
        }

        // Normal case (if backend returns proper PageResponse)
        return PageResponse<RestaurantModel>.fromJson(
          data,
          (json) => RestaurantModel.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }
}
