import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_color.dart';

enum AppTextStyle { bold, medium, regular, semibold, light }

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? underlineColor;
  final AppTextStyle? style;
  final bool underline;
  final bool strikeThrough;
  final double? textSize;
  final bool capitalise;
  final int? maxLines;
  final TextAlign? textAlign;
  final String? fontFamily;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? lineHeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? decorationThickness;

  const AppText({
    super.key,
    required this.text,
    this.color,
    this.style,
    this.maxLines,
    this.textAlign,
    this.underline = false,
    this.strikeThrough = false,
    this.textSize,
    this.fontFamily,
    this.fontWeight,
    this.lineHeight,
    this.fontStyle,
    this.underlineColor,
    this.capitalise = false,
    this.letterSpacing,
    this.decorationThickness,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Text(
      capitalise ? text.toUpperCase() : text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow:
          overflow ??
          (maxLines == 1 ? TextOverflow.ellipsis : TextOverflow.visible),
      style: getStyle(
        color ?? AppColor.primary,
        textSize ?? getTextSize(screenWidth),
      ),
    );
  }

  double getTextSize(double screenWidth) {
    switch (style) {
      case AppTextStyle.bold:
        return screenWidth * 0.08;
      case AppTextStyle.medium:
        return screenWidth * 0.06;
      case AppTextStyle.semibold:
        return screenWidth * 0.05;
      default:
        return screenWidth * 0.04;
    }
  }

  TextStyle getStyle(Color color, double textSize) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight ?? getWeight(),
      fontSize: textSize,
      fontStyle: fontStyle ?? FontStyle.normal,
      height: lineHeight ?? 1.0,
      fontFamily: "Poppins",
      letterSpacing: letterSpacing,
      decorationThickness: decorationThickness,
      decorationColor: underlineColor,
      decoration: strikeThrough
          ? TextDecoration.lineThrough
          : (underline ? TextDecoration.underline : TextDecoration.none),
    );
  }

  FontWeight getWeight() {
    switch (style) {
      case AppTextStyle.bold:
        return FontWeight.w700;
      case AppTextStyle.medium:
        return FontWeight.w500;
      case AppTextStyle.semibold:
        return FontWeight.w600;
      case AppTextStyle.light:
        return FontWeight.w300;
      case AppTextStyle.regular:
      default:
        return FontWeight.w400;
    }
  }
}
