import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:get/get.dart';

ProgressDialog pr;
dynamic loadingDialog(BuildContext context) {
  pr = ProgressDialog(context);
  pr = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
  //show with percentage

  pr.style(
      message: 'loading_dialog__loading'.tr,
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: Container(padding: const EdgeInsets.all(10.0), child: const CircularProgressIndicator()),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600));

  return pr;
}
