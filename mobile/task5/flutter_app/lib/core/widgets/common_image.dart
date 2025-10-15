import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/Assets.dart';
import 'package:shimmer/shimmer.dart';

enum AppImageType { networkImage, fileImage, assetImage }

// ignore: must_be_immutable
class CommonImageView extends StatelessWidget {
  final dynamic height;
  final dynamic width;
  final String? imagePath;
  final BoxShape shape;
  final dynamic borderRadius;
  final dynamic topLeft;
  final dynamic topRight;
  final dynamic bottomLeft;
  final dynamic bottomRight;
  final Color? borderColor;
  final dynamic borderWidth;
  final ColorFilter? colorFilter;
  final BoxFit? boxFit;
  final Color? bgColor;
  final dynamic loaderSize;
  final Widget? errorWidget;
  AppImageType? imageType;

  CommonImageView({
    super.key,
    required this.height,
    required this.width,
    required this.imagePath,
    required this.shape,
    this.imageType,
    this.borderRadius,
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
    this.borderColor,
    this.borderWidth,
    this.colorFilter,
    this.boxFit,
    this.bgColor,
    this.loaderSize,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    // Placeholder if imagePath is null or empty
    if (imagePath == null || imagePath!.isEmpty) {
      return _buildPlaceholder();
    }

    if (imagePath!.contains("http")) {
      imageType = AppImageType.networkImage;
    } else if (imagePath!.startsWith("assets")) {
      imageType = AppImageType.assetImage;
    } else {
      imageType = AppImageType.fileImage;
    }

    if (imageType == AppImageType.networkImage) {
      return _cachedNetworkImage();
    } else if (imageType == AppImageType.assetImage) {
      return _assetImage();
    } else {
      return _fileImage();
    }
  }

  Widget _fileImage() {
    try {
      return shape == BoxShape.rectangle
          ? Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                shape: shape,
                color: bgColor ?? Colors.transparent,
                border: Border.all(
                  width: 1,
                  color: borderColor ?? Colors.transparent,
                ),
                borderRadius: topLeft == null
                    ? BorderRadius.all(Radius.circular(borderRadius ?? 17.0))
                    : BorderRadius.only(
                        topLeft: Radius.circular(topLeft ?? 0),
                        topRight: Radius.circular(topRight ?? 0),
                        bottomLeft: Radius.circular(bottomLeft ?? 0),
                        bottomRight: Radius.circular(bottomRight ?? 0),
                      ),
                image: DecorationImage(
                  image: FileImage(File(imagePath!)),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                shape: shape,
                color: bgColor ?? Colors.transparent,
                image: DecorationImage(
                  image: FileImage(File(imagePath!)),
                  fit: BoxFit.cover,
                ),
              ),
            );
    } catch (e) {
      return _buildPlaceholder();
    }
  }

  Widget _assetImage() {
    return shape == BoxShape.rectangle
        ? Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath!),
                fit: boxFit ?? BoxFit.fill,
                colorFilter: colorFilter,
              ),
              shape: shape,
              color: bgColor ?? Colors.transparent,
              border: Border.all(
                width: 1,
                color: borderColor ?? Colors.transparent,
              ),
              borderRadius: topLeft == null
                  ? BorderRadius.all(Radius.circular(borderRadius ?? 17.0))
                  : BorderRadius.only(
                      topLeft: Radius.circular(topLeft ?? 0),
                      topRight: Radius.circular(topRight ?? 0),
                      bottomLeft: Radius.circular(bottomLeft ?? 0),
                      bottomRight: Radius.circular(bottomRight ?? 0),
                    ),
            ),
          )
        : Container(
            height: height,
            width: width,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath!),
                fit: boxFit ?? BoxFit.fill,
              ),
            ),
          );
  }

  Widget _cachedNetworkImage() {
    return CachedNetworkImage(
      imageUrl: imagePath!,
      fit: BoxFit.fill,
      maxHeightDiskCache: 300,
      maxWidthDiskCache: 300,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
          color: bgColor ?? Colors.transparent,
          borderRadius: shape == BoxShape.rectangle
              ? (topLeft == null
                    ? BorderRadius.all(Radius.circular(borderRadius ?? 7))
                    : BorderRadius.only(
                        topLeft: Radius.circular(topLeft ?? 0),
                        topRight: Radius.circular(topRight ?? 0),
                        bottomLeft: Radius.circular(bottomLeft ?? 0),
                        bottomRight: Radius.circular(bottomRight ?? 0),
                      ))
              : null,
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit ?? BoxFit.cover,
            colorFilter: colorFilter,
          ),
        ),
      ),
      placeholder: (context, url) => _buildShimmer(),
      errorWidget: (context, url, error) => _buildPlaceholder(),
    );
  }

  /// Shimmer placeholder
  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: topLeft == null
              ? BorderRadius.all(Radius.circular(borderRadius ?? 7))
              : BorderRadius.only(
                  topLeft: Radius.circular(topLeft ?? 0),
                  topRight: Radius.circular(topRight ?? 0),
                  bottomLeft: Radius.circular(bottomLeft ?? 0),
                  bottomRight: Radius.circular(bottomRight ?? 0),
                ),
        ),
      ),
    );
  }

  /// Default placeholder for empty or failed images
  Widget _buildPlaceholder() {
    return SizedBox(
      height: height,
      width: width,
      // decoration: BoxDecoration(
      //   shape: shape,
      //   color: bgColor ?? Colors.grey.shade200,
      //   borderRadius: shape == BoxShape.rectangle
      //       ? (topLeft == null
      //       ? BorderRadius.all(Radius.circular(borderRadius ?? 7))
      //       : BorderRadius.only(
      //       topLeft: Radius.circular(topLeft ?? 0),
      //       topRight: Radius.circular(topRight ?? 0),
      //       bottomLeft: Radius.circular(bottomLeft ?? 0),
      //       bottomRight: Radius.circular(bottomRight ?? 0)))
      //       : null,
      // ),
      child: Image.asset(Assets.imageRestaurant),
    );
  }
}
