
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waiter/app/global_widgets/auto_size_text_widget.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:waiter/app/routes/app_pages.dart';

class VerifyScreen extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();

  final AuthController _authcon = Get.find();
  handleFormSubmit() async {
    // var phone=Get.arguments['phone'];
    // var name=Get.arguments['name'];
    // var phoneId=Get.arguments['phoneId'];
    // var deviceToken=Get.arguments['deviceToken'];
    Get.toNamed(Routes.HOME);
/*
    if (Get.arguments['phone'] == null) {
       Helpers.showSnackbar(message: 'warning_dialog__input_phone'.tr);
    }else if (Get.arguments['name'] == null) {
      Helpers.showSnackbar(message: 'warning_dialog__input_name'.tr);
    }else if (Get.arguments['phone'].length >13 || Get.arguments['phone'].length <13) {
      Helpers.showSnackbar(message: 'add_address__phone_10_digit_error'.tr);

    }else if (codeController.text.isEmpty) {
      Helpers.showSnackbar(message: 'warning_dialog__code_require'.tr);

    } else if (codeController.text.length != 6) {
      Helpers.showSnackbar(message: 'Verification_OTP_code_is_wrong'.tr);
    }else {
      final ProgressDialog progressDialog = loadingDialog(
          Get.overlayContext
      );
      progressDialog.show();
      FirebaseAuth auth = FirebaseAuth.instance;
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: phoneId, smsCode: codeController.text);
      try {
        await auth.signInWithCredential(credential)
            .then((user) async {
          if (user != null) {
            _authcon.newuserdb.user_phone=phone;
            _authcon.newuserdb.user_name=name;
            _authcon.newuserdb.deviceToken=deviceToken;
            _authcon.newuserdb.phone_id=phoneId;
            _authcon.login();
            if(_authcon.login() =="true"){
              progressDialog.hide();
            }
          }
        });
      } catch (Exception) {
        progressDialog.hide();
        Helpers.showSnackbar(message: 'Verification_OTP_code_is_wrong'.tr);
      }
    }
*/


  }

  handleFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    const Widget _dividerWidget = Divider(
      height: 2,
    );
    return GestureDetector(
      onTap: () {
        handleFocus(context);
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: false,
        appBar: AppBar(
          backgroundColor: Color(0xff15355a),
          brightness: Theme.of(context).brightness,
          iconTheme:
          Theme.of(context).iconTheme.copyWith(color: Colors.white),
          title: Text(
            'home_verify_phone'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.title.copyWith(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _dividerWidget,
                // Get?.arguments['phone']
                _HeaderTextWidget(phoneNumber:'0531534038' ),
                Container(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Form(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        TextFormField(
                          controller:codeController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6)
                          ],
                          keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.button.copyWith(color:Colors.black ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelStyle:
                            TextStyle(color: Colors.black),
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'XXXXXX',
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                          ),
                          // keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextButton(
                          onPressed: handleFormSubmit,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.0),
                            padding: EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            decoration: buildFlatButtonConatinerDecoration(
                                color: Theme.of(context).primaryColor),
                            child: AutoSizeTextWidget(
                              text: 'email_verify__submit'.tr,
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
                      ],
                    ),
                  ),
                ),
                Column(
                  children: const <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 1,
                    ),
                    SizedBox(
                      height: 32,
                    )
                  ],
                ),
                GestureDetector(
                    child: Text(
                      'phone_signin__back_login'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Color(0xff15355a)),
                    ),
                    onTap: () {
                      Get.back();
                    })
              ],
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
}

class _HeaderTextWidget extends StatelessWidget {
  const _HeaderTextWidget(
      {@required this.phoneNumber});
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      child: Stack(children: <Widget>[
        Container(
            color: Color(0xff15355a),
            padding: const EdgeInsets.only(
                left: 16, right: 16),
            height: 210,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'phone_signin__title1'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                ),
                Text(
                  (phoneNumber == null) ? '' : phoneNumber,
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                ),
              ],
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 90,
            height: 90,
            child: const CircleAvatar(
              backgroundImage:
              ExactAssetImage('assets/img/verify_email_icon.jpg'),
            ),
          ),
        )
      ]),
    );
  }
}