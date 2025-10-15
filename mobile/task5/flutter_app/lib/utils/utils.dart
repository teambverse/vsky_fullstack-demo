// import 'dart:ui';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:mime/mime.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'app_color.dart';
// import 'app_string.dart';

// class Utils {
//   static log(String tag, dynamic message) {
//     if (kDebugMode) {
//       print("TAG $tag : Message $message");
//     }
//   }

//   static showLoader() {
//     Get.context!.loaderOverlay.show();
//   }

//   static Future hideLoader() async {
//     Get.context?.loaderOverlay.hide();
//   }

//   static showSnackBar(String? message, {bool? isSuccess = false}) {
//     if (message == null) {
//       return;
//     }
//     Get.closeAllSnackbars();
//     Get.rawSnackbar(
//       message: _extractText(message),
//       padding: const EdgeInsets.only(left: 15, bottom: 13, top: 18, right: 15),
//       margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//       backgroundColor: AppColor.gradientRightACC3F3,
//       borderRadius: 5,
//       borderWidth: 1,
//       borderColor: AppColor.primary.withOpacity(0.15),
//       snackPosition: SnackPosition.TOP,
//       animationDuration: Duration(milliseconds: 450),
//       messageText: Text(
//         _extractText(message),
//         maxLines: 3,
//         softWrap: false,
//         textAlign: TextAlign.start,
//         style: TextStyle(
//           overflow: TextOverflow.ellipsis,
//           color: AppColor.black,
//           fontWeight: FontWeight.w500,
//           fontSize: 14.sp,
//           height: 1.4,
//         ),
//       ),
//     );
//   }

//   static String _extractText(String? message) {
//     if (message == null) {
//       return "";
//     }
//     if (message.length > 200) {
//       return message.substring(0, 199);
//     } else {
//       return message;
//     }
//   }

//   static Future<bool> hasNetwork() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult.first == ConnectivityResult.none) {
//       Utils.showSnackBar(AppString.noInternet);
//       return false;
//     } else {
//       return true;
//     }
//   }

//   static hideKeyboard() {
//     FocusScope.of(Get.context!).requestFocus(FocusNode());
//   }

//   static void showCountryPickerDialog(
//     BuildContext context,
//     ValueChanged<Country> onSelect,
//   ) {
//     showCountryPicker(
//       context: context,
//       showPhoneCode: true,
//       onSelect: onSelect,
//       countryListTheme: CountryListThemeData(
//         flagSize: 25,
//         backgroundColor: Colors.white,
//         textStyle: const TextStyle(fontSize: 16, color: Colors.black),
//         bottomSheetHeight: 500, // Adjust bottom sheet height
//         searchTextStyle: const TextStyle(color: Colors.black),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20.0),
//           topRight: Radius.circular(20.0),
//         ),
//         inputDecoration: InputDecoration(
//           labelText: 'Search',
//           hintText: 'Start typing to search',
//           prefixIcon: const Icon(Icons.search),
//           border: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }

//   void openConfirmationSheet({
//     required String title,
//     required String subtitle,
//     required String buttonTitle,
//     required VoidCallback action,
//   }) {
//     showModalBottomSheet(
//       context: Get.context!,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       barrierColor: Colors.transparent,
//       builder: (context) {
//         return Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             // 🔹 Blur + Blue overlay
//             BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
//               child: Container(
//                 color: Colors.black.withAlpha(10), // Optional dimming effect
//                 height: double.infinity,
//                 width: double.infinity,
//               ),
//             ).onTap(() {
//               Get.back();
//             }),

//             // 🔹 Your actual bottom sheet content
//             Container(
//               margin: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.4,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     10.pixelH,
//                     AppText(
//                       text: title,
//                       textSize: 14.sp,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                       textAlign: TextAlign.left,
//                     ),
//                     15.pixelH,
//                     AppText(
//                       text: subtitle,
//                       textSize: 10.sp,
//                       style: AppTextStyle.light,
//                       color: Colors.black,
//                       textAlign: TextAlign.left,
//                     ),
//                     SizedBox(height: 20),
//                     AppButton(text: buttonTitle, onPressed: action),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void showMilestoneDetailsBottomSheet({
//     required MilestoneModel milestone,
//     required MilestonesAndStagesController controller,
//     required VoidCallback onUpdate,
//     required ProjectStage stage,
//   }) {
//     // Initialize controller dates with milestone values
//     controller.setMilestoneDates(
//       start: milestone.startDate != null
//           ? DateTime.parse(milestone.startDate!)
//           : null,
//       end:
//           milestone.endDate != null ? DateTime.parse(milestone.endDate!) : null,
//     );

//     showModalBottomSheet(
//       context: Get.context!,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent, // 🔹 important
//       barrierColor: Colors.transparent, // 🔹 remove default dark overlay
//       builder: (context) {
//         return Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             // 🔹 Blur + Blue overlay
//             BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
//               child: Container(
//                 color: Colors.black.withAlpha(10), // Optional dimming effect
//                 height: double.infinity,
//                 width: double.infinity,
//               ),
//             ).onTap(() {
//               Get.back();
//             }),

//             // 🔹 Actual bottom sheet
//             Container(
//               margin: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.25, // sheet height
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AppText(
//                       text: stage.name ?? "N/A",
//                       textSize: 14.sp,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                     ),
//                     SizedBox(height: 4),
//                     AppText(
//                       text: milestone.name ?? '',
//                       textSize: 10.sp,
//                       style: AppTextStyle.light,
//                       color: Colors.black,
//                     ),
//                     Divider(
//                       thickness: 0.5,
//                       color: AppColor.black.withOpacity(0.15),
//                     ).paddingSymmetric(vertical: 10.h),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Start Date
//                         Expanded(
//                           child: Obx(
//                             () => GestureDetector(
//                               onTap: () async {
//                                 if (Utils.isWorkspaceAdmin) {
//                                   DateTime? picked = await showDatePicker(
//                                     context: context,
//                                     initialDate: controller.startDate.value ??
//                                         DateTime.now(),
//                                     firstDate: DateTime(2000),
//                                     lastDate: DateTime(2100),
//                                     builder: (context, child) {
//                                       return Theme(
//                                         data: buildPickerTheme(context),
//                                         child: child!,
//                                       );
//                                     },
//                                   );
//                                   if (picked != null) {
//                                     controller.startDate.value = picked;
//                                     controller.addStartDateAndEndDate(
//                                       milestone,
//                                     );
//                                   }
//                                 }
//                               },
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       AppText(
//                                         text: controller.startDate.value != null
//                                             ? controller.startDate.value!
//                                                 .toFormattedDate()
//                                             : "N/A",
//                                         textSize: 12.sp,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black,
//                                       ),
//                                       SizedBox(height: 4),
//                                       Row(
//                                         children: [
//                                           AppText(
//                                             text: "Start Date",
//                                             textSize: 10.sp,
//                                             color: Colors.grey,
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                           SizedBox(width: 4),
//                                           SvgPicture.asset(
//                                             Assets.iconsIcCalender,
//                                             height: 12,
//                                             width: 12,
//                                             color: Colors.black,
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   if (Utils.isWorkspaceAdmin)
//                                     SvgPicture.asset(Assets.iconsIcEdit),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),

//                         Container(
//                           height: 18,
//                           width: 0.5,
//                           color: AppColor.black.withOpacity(0.15),
//                         ).paddingSymmetric(horizontal: 12),

//                         // End Date
//                         Expanded(
//                           child: Obx(
//                             () => GestureDetector(
//                               onTap: () async {
//                                 if (Utils.isWorkspaceAdmin) {
//                                   DateTime? picked = await showDatePicker(
//                                     context: context,
//                                     initialDate: controller.endDate.value ??
//                                         DateTime.now(),
//                                     firstDate: DateTime(2000),
//                                     lastDate: DateTime(2100),
//                                     builder: (context, child) {
//                                       return Theme(
//                                         data: buildPickerTheme(context),
//                                         child: child!,
//                                       );
//                                     },
//                                   );
//                                   if (picked != null) {
//                                     controller.endDate.value = picked;
//                                     controller.addStartDateAndEndDate(
//                                       milestone,
//                                     );
//                                   }
//                                 }
//                               },
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       AppText(
//                                         text: controller.endDate.value != null
//                                             ? controller.endDate.value!
//                                                 .toFormattedDate()
//                                             : "N/A",
//                                         textSize: 12.sp,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black,
//                                       ),
//                                       SizedBox(height: 4),
//                                       Row(
//                                         children: [
//                                           AppText(
//                                             text: "End Date",
//                                             textSize: 10.sp,
//                                             color: Colors.grey,
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                           SizedBox(width: 4),
//                                           SvgPicture.asset(
//                                             Assets.iconsIcCalender,
//                                             height: 12,
//                                             width: 12,
//                                             color: Colors.black,
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   if (Utils.isWorkspaceAdmin)
//                                     SvgPicture.asset(Assets.iconsIcEdit),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     Divider(
//                       thickness: 0.5,
//                       color: AppColor.black.withOpacity(0.15),
//                     ).paddingSymmetric(vertical: 10.h),

//                     // AppText(
//                     //   text: stage.description ?? '',
//                     //   textSize: 12.sp,
//                     //   style: AppTextStyle.light,
//                     //   color: Colors.black,
//                     // ),
//                     SizedBox(height: 10),

//                     AppButton(
//                       text: "Complete this milestone",
//                       onPressed: onUpdate,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void showStageDetailsSheet({required ProjectStage stage}) {
//     showModalBottomSheet(
//       context: Get.context!,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent, // 🔹 important
//       barrierColor: Colors.transparent, // 🔹 remove default dark overlay
//       builder: (context) {
//         return Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             // 🔹 Blur + Blue overlay
//             BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
//               child: Container(
//                 color: Colors.black.withAlpha(10), // Optional dimming effect
//                 height: double.infinity,
//                 width: double.infinity,
//               ),
//             ).onTap(() {
//               Get.back();
//             }),

//             // 🔹 Actual bottom sheet
//             Container(
//               margin: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.25, // sheet height
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AppText(
//                       text: stage.name ?? "N/A",
//                       textSize: 14.sp,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                     ),
//                     SizedBox(height: 4),
//                     AppText(
//                       text:
//                           "${stage.projectStageMilestones?.length.toString() ?? '0'} Milestones",
//                       textSize: 10.sp,
//                       style: AppTextStyle.light,
//                       color: Colors.black,
//                     ),
//                     Divider(
//                       thickness: 0.5,
//                       color: AppColor.black.withOpacity(0.15),
//                     ).paddingSymmetric(vertical: 10.h),
//                     AppText(
//                       text: stage.description ?? '',
//                       textSize: 12.sp,
//                       style: AppTextStyle.light,
//                       color: Colors.black,
//                     ),
//                     SizedBox(height: 20),
//                     AppButton(
//                       text: "Okay",
//                       onPressed: () {
//                         Get.back();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   static EdgeInsets getSafeAreaInsets(BuildContext context) {
//     return MediaQuery.of(context).padding;
//   }

//   static (String, String) splitName(String fullName) {
//     List<String> nameParts = fullName.split(" ");

//     String firstName = nameParts[0];
//     String lastName =
//         nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";
//     return (firstName, lastName);
//   }

//   static String? getFileType(String path) {
//     final mimeType = lookupMimeType(path);
//     String? result = mimeType?.substring(0, mimeType.indexOf('/'));
//     return result;
//   }

//   static Country? getCountryFrom(String phoneCode) {
//     try {
//       final country = CountryParser.parsePhoneCode(phoneCode);
//       return country; // gives you the flag emoji 🇮🇳
//     } catch (e) {
//       return null; // return empty if invalid code
//     }
//   }

//   static String formatDate(DateTime? date) {
//     if (date == null) return "";

//     try {
//       return DateFormat("dd MMM yyyy").format(date);
//     } catch (e) {
//       return date.toString();
//     }
//   }

//   static String formatTime(DateTime? date) {
//     if (date == null) return "";
//     try {
//       return DateFormat("hh:mm a").format(date); // 03:30 PM
//     } catch (e) {
//       return date.toString();
//     }
//   }

//   static bool get canEdit {
//     final myData = StorageHelper().getProjectModel()?.members?.firstWhereOrNull(
//           (user) => user.userId == StorageHelper().getUserId(),
//         );
//     return myData?.permission == "edit";
//   }

//   static bool get isWorkspaceAdmin {
//     return StorageHelper().getUserModel()?.workspaceMembership?.role == "admin";
//   }

//   static String projectStatus(String status) {
//     switch (status) {
//       case "inProgress":
//         return "In Progress";
//       default:
//         return status.capsFirst;
//     }
//   }

//   static Future<bool> openUrl(String url) async {
//     final uri = Uri.tryParse(url);
//     if (uri == null) {
//       debugPrint("Invalid URL: $url");
//       return false;
//     }

//     try {
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//         return true;
//       } else {
//         showSnackBar("Cannot launch URL:${url.toString()}");
//         return false;
//       }
//     } catch (e) {
//       showSnackBar(e.toString());
//       return false;
//     }
//   }

//   ThemeData buildPickerTheme(BuildContext context) {
//     return Theme.of(context).copyWith(
//       colorScheme: ColorScheme.light(
//         primary: AppColor.primary, // same as TableCalendar selected color
//         onPrimary: Colors.white, // text on selected
//         onSurface: Colors.black, // default text color
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//           foregroundColor: AppColor.primary, // buttons like OK/Cancel
//         ),
//       ),
//       dialogTheme: DialogThemeData(backgroundColor: Colors.white),
//     );
//   }
// }
