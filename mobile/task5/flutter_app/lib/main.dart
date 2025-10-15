import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/data/injector.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_local.dart';
import 'package:flutter_app/utils/route/route_generator.dart';
import 'package:flutter_app/utils/route/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:loader_overlay/loader_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeFirebase();
  await initializeApp();
  String initialRoute = await findInitialRoute();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(MyApp(initialRoute)));
}


Future<void> initializeApp() async {
  try {
    HttpOverrides.global = MyHttpOverrides();
    // await StorageHelper.init();

    debugPrint("App initialization completed");
  } catch (e) {
    debugPrint("Error during app initialization: $e");
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  late String initialRoute;

  MyApp(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ScreenUtilInit(
          designSize: Size(constraints.maxWidth, constraints.maxHeight),
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return GetMaterialApp(
              locale: Get.deviceLocale,
              translations: AppTranslations(),
              navigatorKey: nevigatorey,
              debugShowCheckedModeBanner: false,
              builder: (BuildContext? context, Widget? child) {
                final MediaQueryData data = MediaQuery.of(context!);
                return MediaQuery(
                  data: data.copyWith(textScaler: TextScaler.linear(1.0)),
                  child: LoaderOverlay(
                    duration: Duration(milliseconds: 1000),
                    overlayColor: Colors.black.withValues(alpha: 0.5),
                    useDefaultLoading: false,
                    overlayWidgetBuilder: (_) =>
                        Center(child: InfiniteRotationImage()),
                    child: child!,
                  ),
                );
              },
              theme: ThemeData(
                fontFamily: 'Outfit',
                textTheme: ThemeData.light().textTheme.apply(
                  fontFamily: 'Outfit',
                  fontFamilyFallback: ['Roboto', 'Arial'],
                ),
                colorScheme: ColorScheme.fromSeed(seedColor: AppColor.white),
                useMaterial3: true,
              ),
              navigatorObservers: [ClearFocusOnPush()],
              initialRoute: initialRoute,
              onGenerateRoute: RoutesGenerator.generateRoute,
              onGenerateInitialRoutes: (String initialRouteName) {
                return [
                  RoutesGenerator.generateRoute(
                    RouteSettings(name: initialRoute, arguments: args),
                  ),
                ];
              },
            );
          },
        );
      },
    );
  }
}

Future<String> findInitialRoute() async {
  return Routes.restaurantsScreen;
}

var args;

class ClearFocusOnPush extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }
}

final GlobalKey<NavigatorState> nevigatorey = GlobalKey<NavigatorState>();

class InfiniteRotationImage extends StatefulWidget {
  const InfiniteRotationImage({super.key});

  @override
  State<InfiniteRotationImage> createState() => _InfiniteRotationImageState();
}

class _InfiniteRotationImageState extends State<InfiniteRotationImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsetsGeometry.all(1.r),
        decoration: BoxDecoration(
          color: AppColor.white,
          shape: BoxShape.circle,
        ),
        child: RotationTransition(
          turns: _controller,
          // child: Image.asset(Assets.iconsIcLoader, width: 70, height: 70),
        ),
      ),
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
