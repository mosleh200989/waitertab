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
import 'package:waiter/app/modules/notification_details/bindings/notification_details_binding.dart';
import 'package:waiter/app/modules/notification_details/views/notification_details_view.dart';
import 'package:waiter/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:waiter/app/modules/notifications/views/notifications_view.dart';
import 'package:waiter/app/modules/order_history/bindings/order_history_binding.dart';
import 'package:waiter/app/modules/order_history/views/order_history_view.dart';
import 'package:waiter/app/modules/order_list/bindings/order_list_binding.dart';
import 'package:waiter/app/modules/order_list/views/order_list_view.dart';
import 'package:waiter/app/modules/order_list/views/order_view.dart';
import 'package:waiter/app/modules/product_list/bindings/product_list_binding.dart';
import 'package:waiter/app/modules/product_list/views/product_list_view.dart';
import 'package:waiter/app/modules/splash/bindings/splash_binding.dart';
import 'package:waiter/app/modules/splash/views/splash_view.dart';
import 'package:waiter/app/modules/task_details/bindings/task_details_binding.dart';
import 'package:waiter/app/modules/task_details/views/task_details_view.dart';
import 'package:waiter/app/modules/tasks/bindings/tasks_binding.dart';
import 'package:waiter/app/modules/tasks/views/tasks_view.dart';

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
      binding: OrderListBinding(),
      fullscreenDialog: true,
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: _Paths.TASKS,
      page: () => TasksView(),
      binding: TasksBinding(),
    ),
    GetPage(
      name: _Paths.TASK_DETAILS,
      page: () => TaskDetailsView(),
      binding: TaskDetailsBinding(),
      fullscreenDialog: true,
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: _Paths.PRODUCT_LIST,
      page: () => ProductListView(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_DETAILS,
      page: () => NotificationDetailsView(),
      binding: NotificationDetailsBinding(),
      fullscreenDialog: true,
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 300),
    ),
  ];
}
