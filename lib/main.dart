import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waiter/app/core/theme/app_theme.dart';
import 'package:waiter/app/core/theme/theme_service.dart';
import 'package:waiter/app/core/values/translations/app_translation.dart';
import 'package:waiter/app/global_bindings.dart';
import 'package:waiter/app/modules/unknown/views/unknown_view.dart';
import 'package:device_preview/device_preview.dart';
import 'app/routes/app_pages.dart';

void main()async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  print(GetPlatform.isAndroid);
  print(GetPlatform.isDesktop);
  print(GetPlatform.isIOS);
  print(GetPlatform.isDesktop);
  print('GetPlatform.isAndroid');
  runApp(
    //   DevicePreview(
    //   // enabled: !kReleaseMode,
    //   builder: (context) => MyApp(), // Wrap your app
    // ),
    MyApp(),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      unknownRoute: GetPage(name: Routes.UNKNOWN, page: () => UnknownView()),
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialBinding: GlobalBindings(),
      title: "Waiter",
      defaultTransition : Transition .fade,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // translationsKeys: AppTranslation.translations,
      // locale: Locale('ar','SA'),
      // fallbackLocale: Locale('ar','SA'),
      locale: Locale('ar'),
      translations: AppTranslation(),
      fallbackLocale: Locale('ar'),
      darkTheme: AppThemes.dark,
      theme: AppThemes.light,
      themeMode: ThemeService().theme,
      popGesture: Get.isPopGestureEnable,
      defaultGlobalState:true,

    );


  }
}

