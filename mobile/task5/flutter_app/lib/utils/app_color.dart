import 'package:flutter/material.dart';

abstract class AppColor {
  ///primary and secondary colors
  static const Color primary = Color(0xff353535);
  static const Color secondary = Color(0xffF2C94C);

  ///white
  static const Color white = Color(0xffffffff);
  static const Color whiteF9F9F9 = Color(0xffF9F9F9);
  static const Color whitef4f4f4 = Color(0xfff4f4f4);
  static const Color whiteF7FBFD = Color(0xffF7FBFD);
  static const Color whiteCAE3F3 = Color(0xffCAE3F3);
  static const Color whiteF6F5FF = Color(0xffF6F5FF);
  static const Color whiteF7F7F7 = Color(0xffF7F7F7);
  static const Color whiteF4F4F4 = Color(0xffF4F4F4);
  static const Color whiteF3F3F3 = Color(0xffF3F3F3);

  ///black
  static const Color black = Color(0xff000000);
  static const Color blue = Color(0xff000000);
  static const Color red = Color(0xffD91C5C);
  static const Color backButton = Color(0xffF2F2f2);
  static const Color orange = Color(0xffF2613F);

  ///grey
  static const Color grey = Color(0xffBDBDBD);
  static const Color greyEDEDED = Color(0xffEDEDED);
  static const Color grey959595 = Color(0xff959595);
  static const Color greyDAEBF6 = Color(0xffDAEBF6);
  static const Color greyAAAAAA = Color(0xffAAAAAA);
  static const Color greyCCCCCC = Color(0xffCCCCCC);

  ///others
  static const Color gradientLeft = Color(0xff49A1D7);
  static const Color gradientRight = Color(0xff8685D3);
  static const Color blue84B9E2 = Color(0xff84B9E2);
  static const Color blueEEF5FB = Color(0xffEEF5FB);

  // Gradient 1 - Purple to Light Blue (original)
  static const Color gradientLeft1 = Color(0xFF9590FF); // rgba(149, 144, 255)
  static const Color gradientRight1 = Color(0xFF91B5FB); // rgba(145, 181, 251)

  // Gradient 2 - Peach to Light Peach
  static const Color gradientLeft2 = Color(0xFFFFB4A1); // rgba(255, 180, 161)
  static const Color gradientRight2 = Color(0xFFFFD1BE); // rgba(255, 209, 190)

  // Gradient 3 - Aqua Blue to Pale Yellow-Green
  static const Color gradientLeft3 = Color(0xFF92E0EB); // rgba(146, 224, 235)
  static const Color gradientRight3 = Color(0xFFDFE2C5); // rgba(223, 226, 197)

  // Gradient 4 - Pink to Soft Peach
  static const Color gradientLeft4 = Color(0xFFF8B7CA);
  static const Color gradientRight4 = Color(0xFFFEE3D2);

  // Gradient 5 - Soft Yellow to Light Pink
  static const Color gradientLeft5 = Color(0xFFF4EBAD); // rgba(244, 235, 173)
  static const Color gradientRight5 = Color(0xFFFEBCEF); // rgba(254, 188, 243)

  // Gradient 6 - Coral Pink to Lavender
  static const Color gradientLeft6 = Color(0xFFFBB8B5); // rgba(251, 184, 181)
  static const Color gradientRight6 = Color(0xFFBCABF9); // rgba(188, 171, 249)

  // Gradient 7 - Golden Yellow to Blue
  static const Color gradientLeft7 = Color(0xFFFED271); // rgba(254, 210, 113)
  static const Color gradientRight7 = Color(0xFF5C88E4); // rgba(92, 136, 228)

  // Gradient 8 - Light Yellow to Rose Pink
  static const Color gradientLeft8 = Color(0xFFFFEEB3); // rgba(255, 238, 179)
  static const Color gradientRight8 = Color(0xFFF87180); // rgba(248, 113, 128)

  static const Color gradientLeftADACF6 = Color(0xFFADACF6);
  static const Color gradientRightACC3F3 = Color(0xFFACC3F3);

  static const Color projectColorFF7501 = Color(0xFFFF7501);
  static const Color projectColorB78FF2 = Color(0xFFB78FF2);

  static const List<LinearGradient> cardGradients = [
    LinearGradient(
      colors: [AppColor.gradientLeft1, AppColor.gradientRight1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    LinearGradient(
      colors: [AppColor.gradientLeft2, AppColor.gradientRight2],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    LinearGradient(
      colors: [AppColor.gradientLeft3, AppColor.gradientRight3],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    LinearGradient(
      colors: [AppColor.gradientLeft4, AppColor.gradientRight4],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    LinearGradient(
      colors: [AppColor.gradientLeft5, AppColor.gradientRight5],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    LinearGradient(
      colors: [AppColor.gradientLeft6, AppColor.gradientRight6],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    LinearGradient(
      colors: [AppColor.gradientLeft7, AppColor.gradientRight7],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    LinearGradient(
      colors: [AppColor.gradientLeft8, AppColor.gradientRight8],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  ];

  static const Color blue43A6D9 = Color(0xFF43A6D9);
  static const Color blue4D9DD5 = Color(0xFF4D9DD5);
  static const Color blue2DA6F3 = Color(0xFF2DA6F3);
  static const Color purple8072C3 = Color(0xFF8072C3);
  static const Color purple7C76C4 = Color(0xFF7C76C4);
  static const Color purple7080C9 = Color(0xFF7080C9);
  static const Color grayC9C9C9 = Color(0xFFC9C9C9);
  static const LinearGradient profileDashboardGradient = LinearGradient(
    colors: [AppColor.blue43A6D9, AppColor.purple8072C3],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient progressIndicatorGradient = LinearGradient(
    colors: [AppColor.gradientLeft, AppColor.purple7C76C4],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const LinearGradient uploadPictureGradient = LinearGradient(
    colors: [AppColor.blue4D9DD5, AppColor.purple7080C9],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
