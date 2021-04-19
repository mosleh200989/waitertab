import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter/app/data/models/language.dart';

class LanguageController extends GetxController {
  LanguagesList languagesList;
  final count = 0.obs;
  @override
  void onInit() {
    languagesList=LanguagesList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  Future<String> getDefaultLanguage(String defaultLanguage) async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('language')) {
      defaultLanguage = await prefs.get('language');
    }
    return defaultLanguage;
  }
}
