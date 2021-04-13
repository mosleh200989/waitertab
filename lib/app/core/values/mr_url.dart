
import 'package:waiter/app/core/values/mr_config.dart';

class MrUrl {
  MrUrl._();

  ///
  /// APIs Url
  ///
  static const String ps_delivery_boy_order_history_list_url ='${MrConfig.ps_app_url_node}rest/transactionheaders/deliveryboyorderhistory_get/api_key/${MrConfig.ps_api_key}/';
  static const String ps_delivery_boy_order_get_list_url ='${MrConfig.ps_app_url_node}rest/transactionheaders/deliveryboyorder_get/api_key/${MrConfig.ps_api_key}/';
  static const String ps_unassigned_orders_get_list_url ='${MrConfig.ps_app_url_node}rest/transactionheaders/unassignedorders_get/api_key/${MrConfig.ps_api_key}/';
  static const String ps_chat_image_upload_url ='${MrConfig.ps_app_chat_image_url}uploadchattingphotos/api_key/${MrConfig.ps_api_key}';
  static const String ps_order_offer_post_url ='${MrConfig.ps_app_url_node}rest/add_order_offer';
  static const String ps_update_order_offer_post_url ='${MrConfig.ps_app_url_node}rest/edit_order_offer';
  static const String ps_contact_us_url ='${MrConfig.ps_app_url}rest/contacts/add/api_key/${MrConfig.ps_api_key}';
}
