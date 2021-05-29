import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waiter/app/global_widgets/auto_size_text_widget.dart';
import 'package:waiter/app/routes/app_pages.dart';

import '../controllers/my_user_controller.dart';

class MyUserView extends StatelessWidget {


//  static final GlobalKey<FormState> loginFormKey =  GlobalKey();
final MyUserController _con = Get.find();
//   final UserController _con = Get.find();
//  final UserController _con = Get.put(UserController());



handleFocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      handleFocus(context);
    },
    child: Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: false,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 150.0, bottom: 24.0, right: 24.0),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          'lets_start_with_login'.tr,
                          style: Get.theme
                              .textTheme
                              .display3
                              .merge(TextStyle(color:  Get.theme.primaryColor, fontSize: 24.0)),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                          controller: _con.nameController,
                          decoration: InputDecoration(
                            labelStyle:
                            TextStyle(color: Get.theme.accentColor),
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'user_name'.tr,
                            hintStyle: TextStyle(
                                color:  Get.theme
                                    .focusColor
                                    .withOpacity(0.7)),
                            prefixIcon: Icon(Icons.people,
                                color:  Get.theme.accentColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Get.theme
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:  Get.theme
                                        .focusColor
                                        .withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:  Get.theme
                                        .focusColor
                                        .withOpacity(0.2))),
                          )
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller:_con.passwordController,
                        // inputFormatters: <TextInputFormatter>[
                        //   FilteringTextInputFormatter.digitsOnly,
                        //   LengthLimitingTextInputFormatter(10)
                        // ],
                        keyboardType: TextInputType.text,
                        // style:  Get.theme.textTheme.button.copyWith(),
                        // enableSuggestions: false,
                        // autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelStyle:
                          TextStyle(color:  Get.theme.accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              color:  Get.theme
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.lock,
                              color: Get.theme.accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:  Get.theme
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:  Get.theme
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Get.theme
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                        // keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextButton(
                        onPressed: _con.handleFormSubmit,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          decoration: buildFlatButtonConatinerDecoration(
                              color: Get.theme.primaryColor),
                          child: AutoSizeTextWidget(
                            text: 'login'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                _launchTermsURL();
                              },
                              style: TextButton.styleFrom(
                                primary: Get.theme.hintColor,
                              ),

                              child: Container(
                                child: Column(
                                    children: <Widget>[
                                      Text('terms_condition_lbl'.tr,
                                          style: TextStyle(fontSize: 11)),
                                      Text('terms_condition_link'.tr,
                                          style: TextStyle(color: Color(0xff0645ad), fontSize: 13)),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                _launchURL();
                              },
                              style: TextButton.styleFrom(
                                primary:  Get.theme.hintColor
                              ),
                              child: Text('i_sign_up'.tr),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    ),
  );
}

BoxDecoration buildFlatButtonConatinerDecoration({Color color}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 3.0,
        offset: Offset(0, 2),
      ),
    ],
  );
}

InputDecoration buildFormInputDecoration({String hintText, IconData icon}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
    fillColor: Colors.white70,
    filled: true,
    hintText: '$hintText',
    prefixIcon: Icon(icon),
  );
}

void _launchURL() async {
  const url = 'https://forms.gle/WEvSQCPNQf6kW8gf6';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
void _launchTermsURL() async {
  const url = 'https://eshtri.net/terms';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}
