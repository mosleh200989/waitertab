import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter/app/data/models/user_db.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/routes/app_pages.dart';

class AuthController extends GetxController {
final _currentUser=UserDb().obs;
UserDb get currentUser=>_currentUser.value;

  @override
  void onInit()async {
    super.onInit();
    await getCurrentUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<UserDb> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('current_user')) {
      _currentUser.value = UserDb.fromJSON(json.decode(await prefs.get('current_user')));
      _currentUser.value.auth = true;
      // _currentUser.value=currentUser.value;
    } else {
      _currentUser.value.auth = false;
    }
    return _currentUser.value;
  }
void signOutUser() async {
  try {
    // await _authService.signOutUser();
    _currentUser.value = new UserDb();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
    // setdbUser(new Userdb());
    Get.offAllNamed(Routes.SPLASH);
  } catch (e) {
    print(e);
    Helpers.showSnackbar(title: 'error'.tr, message: e.message);
  }
}
Future<bool> checkInternetConnectivity() async {
  final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.mobile) {
    // print('Mobile');
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // print('Wifi');
    return true;
  } else if (connectivityResult == ConnectivityResult.none) {
    print('No Connection');
    return false;
  } else {
    return false;
  }
}
}
