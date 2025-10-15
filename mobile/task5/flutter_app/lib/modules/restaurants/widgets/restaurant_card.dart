import 'package:flutter/material.dart';
import 'package:flutter_app/core/Assets.dart';
import 'package:flutter_app/core/widgets/app_text.dart';
import 'package:flutter_app/core/widgets/common_image.dart';
import 'package:flutter_app/data/models/restaurant_model.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, this.model});
  final RestaurantModel? model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColor.whiteF7FBFD,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.25),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        spacing: 12.r,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10.r),
            child: CommonImageView(
              height: 50.h,
              width: 50.w,
              imagePath: "",
              shape: BoxShape.rectangle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.r,
              children: [
                AppText(
                  text: model?.name ?? "",
                  fontWeight: FontWeight.bold,
                  textSize: 16,
                  maxLines: 1,
                ),
                AppText(text: model?.address ?? "", textSize: 12, maxLines: 2),
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        text: "\$${model?.menuItemsCount?.round()}",
                        textSize: 14,
                        fontWeight: FontWeight.w800,
                        maxLines: 2,
                        color: AppColor.orange,
                      ),
                    ),
                    Container(
                      decoration: ShapeDecoration(
                        shape: const StadiumBorder(),
                        color: AppColor.whiteF6F5FF,
                        shadows: [
                          BoxShadow(
                            color: AppColor.black.withValues(alpha: 0.06),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      padding: EdgeInsetsGeometry.all(4.r),
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 15),
                          AppText(text: "${model?.rating ?? ""}", textSize: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 15.r).paddingOnly(top: 12.r);
  }
}
