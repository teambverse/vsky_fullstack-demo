// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app/core/widgets/app_text.dart';
import 'package:flutter_app/core/widgets/shimmer_container.dart';
import 'package:flutter_app/modules/restaurants/restaurants_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/modules/restaurants/widgets/restaurant_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RestaurantsScreen extends GetView<RestaurantsController> {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [header(), restaurants()],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        spacing: 5.r,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AppText(text: "You’re welcome,", fontWeight: FontWeight.w500),
          AppText(
            text: "Good Morning !",
            textSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ],
      ).paddingSymmetric(horizontal: 15.r, vertical: 10.r),
    );
  }

  Widget restaurants() {
    return Obx(
      () => Expanded(
        child: ListView.builder(
          physics: controller.isFetchingRestaurants.value
              ? NeverScrollableScrollPhysics()
              : BouncingScrollPhysics(),
          itemCount: controller.isFetchingRestaurants.value
              ? 10
              : controller.restaurants.length,
          itemBuilder: (context, index) =>
              controller.isFetchingRestaurants.value
              ? shimmer()
              : RestaurantCard(model: controller.restaurants[index]),
        ),
      ),
    );
  }

  Widget shimmer() {
    return ShimmerContainer(
      width: double.infinity,
      height: 100.h,
    ).paddingOnly(top: 12.h).paddingSymmetric(horizontal: 15.r);
  }
}
