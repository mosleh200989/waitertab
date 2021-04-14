import 'package:get/get.dart';

import 'package:waiter/app/modules/home/bindings/home_binding.dart';
import 'package:waiter/app/modules/home/views/home_view.dart';
import 'package:waiter/app/modules/order_details/bindings/order_details_binding.dart';
import 'package:waiter/app/modules/order_details/views/order_details_view.dart';
import 'package:waiter/app/modules/splash/bindings/splash_binding.dart';
import 'package:waiter/app/modules/splash/views/splash_view.dart';
import 'package:waiter/app/modules/unknown/bindings/unknown_binding.dart';
import 'package:waiter/app/modules/unknown/views/unknown_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.UNKNOWN,
    //   page: () => UnknownView(),
    //   binding: UnknownBinding(),
    // ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS,
      page: () => OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
  ];
}
