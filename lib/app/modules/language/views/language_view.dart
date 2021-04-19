import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/data/models/language.dart';
import 'package:waiter/app/global_widgets/DrawerWidget.dart';

import '../controllers/language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'languages'.tr,
          // style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        /* actions: <Widget>[
              new ShoppingCartButtonWidget(iconColor: Colors.white, labelColor: Theme.of(context).accentColor),
            ],*/

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.translate,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'app_language'.tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
                // subtitle: Text('select_your_preferred_languages'.tr),
              ),
            ),
            SizedBox(height: 10),
           ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: controller.languagesList.languages.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  Language _language = controller.languagesList.languages.elementAt(index);
                  controller.getDefaultLanguage('en').then((_langCode) {
                    if (_langCode == _language.code) {
                      _language.selected = true;
                    }
                  });
                  return InkWell(
                    onTap: () async {

                      var _lang = _language.code.split("_");
                      if (_lang.length > 1) {
                        // settingRepo.setting.value.mobileLanguage.value = Locale(_lang.elementAt(0), _lang.elementAt(1));
                        Get.updateLocale(new Locale(_lang.elementAt(0), _lang.elementAt(1)));
                      }else {
                        // settingRepo.setting.value.mobileLanguage.value = Locale(_lang.elementAt(0));
                        Get.updateLocale(new Locale(_lang.elementAt(0)));
                      }
                      // settingRepo.setting.notifyListeners();
                      controller.languagesList.languages.forEach((_l) {
                        _l.selected = false;
                      });
                      _language.selected = !_language.selected;
                      // settingRepo.setDefaultLanguage(_language.code);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor.withOpacity(0.30),
                        boxShadow: [
                          BoxShadow(color: Get.theme.focusColor.withOpacity(0.10), blurRadius: 5, offset: Offset(0, 2)),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                  image: DecorationImage(image: AssetImage(_language.flag), fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                height: _language.selected ? 40 : 0,
                                width: _language.selected ? 40 : 0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                  color: Get.theme.accentColor.withOpacity(_language.selected ? 0.85 : 0),
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: _language.selected ? 24 : 0,
                                  color: Get.theme.accentColor.withOpacity(_language.selected ? 0.85 : 0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _language.englishName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style:Get.theme.textTheme.subtitle1,
                                ),
                                Text(
                                  _language.localName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  // style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),

          ],
        ),
      ),
    );
  }
}
