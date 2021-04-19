import 'package:get/get.dart';

import 'package:waiter/app/modules/card/bindings/card_binding.dart';
import 'package:waiter/app/modules/card/views/card_view.dart';
import 'package:waiter/app/modules/home/bindings/home_binding.dart';
import 'package:waiter/app/modules/home/views/home_view.dart';
import 'package:waiter/app/modules/language/bindings/language_binding.dart';
import 'package:waiter/app/modules/language/views/language_view.dart';
import 'package:waiter/app/modules/my_user/bindings/my_user_binding.dart';
import 'package:waiter/app/modules/my_user/views/my_user_view.dart';
import 'package:waiter/app/modules/my_user/views/profile_view.dart';
import 'package:waiter/app/modules/my_user/views/verify_screen.dart';
import 'package:waiter/app/modules/order_details/bindings/order_details_binding.dart';
import 'package:waiter/app/modules/order_details/views/order_details_view.dart';
import 'package:waiter/app/modules/order_history/bindings/order_history_binding.dart';
import 'package:waiter/app/modules/order_history/views/order_history_view.dart';
import 'package:waiter/app/modules/order_list/bindings/order_list_binding.dart';
import 'package:waiter/app/modules/order_list/views/order_list_view.dart';
import 'package:waiter/app/modules/order_list/views/order_view.dart';
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
    GetPage(
      name: _Paths.CARD,
      page: () => CardView(),
      binding: CardBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_LIST,
      page: () => OrderListView(),
      binding: OrderListBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: _Paths.MY_USER,
      page: () => MyUserView(),
      binding: MyUserBinding(),
    ),
    GetPage(name: Routes.PROFILE, page: () => ProfileView()),
    GetPage(
      name: Routes.VERIFY_VIEW,
      page: () => VerifyScreen(),
    ),
    GetPage(
      name: _Paths.ORDER_HISTORY,
      page: () => OrderHistoryView(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_VIEW,
      page: () => OrderView(),
    ),
  ];
}
