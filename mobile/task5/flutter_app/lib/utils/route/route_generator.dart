import 'package:flutter/material.dart';
import 'package:flutter_app/modules/restaurants/restaurants_controller.dart';
import 'package:flutter_app/modules/restaurants/restaurants_screen.dart';
import 'package:flutter_app/utils/route/routes.dart';
import 'package:get/get.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.restaurantsScreen:
        return GetPageRoute(
          routeName: settings.name,
          page: () => const RestaurantsScreen(),
          settings: settings,
          binding: BindingsBuilder(() {
            Get.lazyPut(() => RestaurantsController());
          }),
        );
      default:
        return GetPageRoute(
          routeName: settings.name,
          page: () => _errorRoute(),
          settings: settings,
        );
    }
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(
        child: Text('No Such screen found in route generator'),
      ),
    );
  }
}
