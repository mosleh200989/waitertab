import 'package:get/get.dart';
import 'package:waiter/app/core/values/translations/langs/ar.dart';
import 'package:waiter/app/core/values/translations/langs/en.dart';


class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en':en,
    'ar':ar
  };
}
