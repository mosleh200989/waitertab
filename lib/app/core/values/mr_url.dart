
import 'package:waiter/app/core/values/mr_config.dart';

class MrUrl {
  MrUrl._();

  ///
  /// APIs Url
  ///
  // static const String ps_delivery_boy_order_history_list_url ='${MrConfig.ps_app_url_node}rest/transactionheaders/deliveryboyorderhistory_get/api_key/${MrConfig.mr_api_key}/';
  // static const String ps_delivery_boy_order_get_list_url ='${MrConfig.ps_app_url_node}rest/transactionheaders/deliveryboyorder_get/api_key/${MrConfig.mr_api_key}/';
  // static const String ps_unassigned_orders_get_list_url ='${MrConfig.ps_app_url_node}rest/transactionheaders/unassignedorders_get/api_key/${MrConfig.mr_api_key}/';
  // static const String ps_chat_image_upload_url ='${MrConfig.ps_app_chat_image_url}uploadchattingphotos/api_key/${MrConfig.mr_api_key}';
  // static const String ps_order_offer_post_url ='${MrConfig.ps_app_url_node}rest/add_order_offer';
  // static const String ps_update_order_offer_post_url ='${MrConfig.ps_app_url_node}rest/edit_order_offer';
  // static const String ps_contact_us_url ='${MrConfig.base_app_url}rest/contacts/add/api_key/${MrConfig.base_app_url}';
  static const String get_categories_list_url ='${MrConfig.base_app_url}resturant_bukhari/api/v1/system_settings/';
  static const String get_no_image_url ='${MrConfig.base_app_url}resturant_bukhari/assets/uploads/thumbs/no_image.png';
  static const String get_table_list_url ='${MrConfig.base_app_url}resturant_bukhari/api/v1/system_settings/restauranttables?api-key=${MrConfig.mr_api_key}';
  static const String get_product_list_url ='${MrConfig.base_app_url}resturant_bukhari/api/v1/';
}
