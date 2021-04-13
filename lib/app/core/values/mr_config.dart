// Copyright (c) 2019, the Panacea-Soft.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Panacea-Soft license that can be found in the LICENSE file.



class MrConfig {
  MrConfig._();

  ///
  /// AppVersion
  /// For your app, you need to change according based on your app version
  ///
  static const String app_version = '1.2.3';
  static const String app_ios_version = '1.2.3';

  ///
  /// API Key
  /// If you change here, you need to update in server.
  ///
  static const String ps_api_key = 'teamalamathebest';

  ///
  /// API URL
  /// Change your backend url
  ///
  static const String ps_app_url ='https://eshtri.net/';
  static const String ps_app_url_node ='https://shop.eshtri.net/';
  static const String ps_transactionList_url ='rest/transactionheaders/get/';

  static const String ps_app_image_url ='https://eshtri.net/uploads/';
  static const String ps_app_chat_image_url ='https://eshtri.net/rest/images/';

  static const String ps_app_image_thumbs_url =
      'https://eshtri.net/uploads/thumbnail/';



  ///
  /// Animation Duration
  ///
  static const Duration animation_duration = Duration(milliseconds: 750);

  ///`
  /// Fonts Family Config
  /// Before you declare you here,
  /// 1) You need to add font under assets/fonts/
  /// 2) Declare at pubspec.yaml
  /// 3) Update your font family name at below
  ///
  static const String ps_default_font_family = 'Product Sans';
  static const String ps_default_arabic_font_family = 'Cairo';
  /// Default Language
// static const ps_default_language = 'en';

// static const ps_language_list = [Locale('en', 'US'), Locale('ar', 'DZ')];
  static const String ps_app_db_name = 'ps_db.db';

  static const String priceFormat = '###.00';

  ///
  /// iOS App No
  ///
  static const String iOSAppStoreId = '1512181978';


  ///
  /// Default Limit
  ///
  static const int DEFAULT_LOADING_LIMIT = 30;
  static const int CATEGORY_LOADING_LIMIT = 10;
  static const int COLLECTION_PRODUCT_LOADING_LIMIT = 10;
  static const int DISCOUNT_PRODUCT_LOADING_LIMIT = 10;
  static const int FEATURE_PRODUCT_LOADING_LIMIT = 10;
  static const int LATEST_PRODUCT_LOADING_LIMIT = 10;
  static const int TRENDING_PRODUCT_LOADING_LIMIT = 10;

  static const int BLOG_LOADING_LIMIT = 10;
  static const int SHOP_LOADING_LIMIT = 10;
  static const int SHOP_TAG_LOADING_LIMIT = 10;
}
