import 'dart:ffi';

import '../models/media.dart';

class Userdb {
  String user_id;
  int user_is_sys_admin;
  String facebook_id;
  String google_id;
  String phone_id;
  String user_name;
  String user_email;
  String user_password;
  String apiToken;
  String deviceToken;
  String user_phone;
  String address;
  String bio;
  Media image;
  String dob;
  String nationalId;
  String citizenship;
  String birthDay;
  String accountNumber;
  String carModelNumber;
  String user_about_me;
  String user_cover_photo;
  String user_profile_photo;
  String role_id;
  int is_banned;
  int added_date;
  String billing_first_name;
  String billing_last_name;
  String billing_company;
  String billing_address_1;
  String billing_address_2;
  String billing_country;
  String billing_state;
  String billing_city;
  String billing_postal_code;
  String billing_email;
  String billing_phone;
  String shipping_first_name;
  String shipping_last_name;
  String shipping_company;
  String shipping_address_1;
  String shipping_address_2;
  String shipping_country;
  String shipping_state;
  String shipping_city;
  String shipping_postal_code;
  String shipping_email;
  String shipping_phone;
  String code;
  String verify_types;
  String country_id;
  String city_id;
  String contract_type;
  Double commission;
  int is_terms_checked;
  String language_id;
  String online_status;

  // used for indicate if client logged in or not
  bool auth;

//  String role;

  Userdb();

  Userdb.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      user_id = jsonMap['user_id'].toString();
      user_name = jsonMap['user_name'] != null ? jsonMap['user_name'] : '';
      user_email = jsonMap['user_email'] != null ? jsonMap['user_email'] : '';
      role_id = jsonMap['role_id'] != null ? jsonMap['role_id'] : '';
      apiToken = jsonMap['api_token']!= null ? jsonMap['api_token'] : '';

      contract_type = jsonMap['contract_type']!= null ? jsonMap['contract_type'] : '';
      deviceToken = jsonMap['device_token'];
      phone_id = jsonMap['phone_id'];
      // online_status = jsonMap['online_status']??0;
      online_status =  jsonMap['online_status'] !=null ? jsonMap['online_status'].toString():null;

      try {
        user_phone = jsonMap['custom_fields']['user_phone']['view'];
      } catch (e) {
        user_phone = "";
      }
      try {
        address = jsonMap['custom_fields']['address']['view'];
      } catch (e) {
        address = "";
      }
      try {
        bio = jsonMap['custom_fields']['bio']['view'];
      } catch (e) {
        bio = "";
      }
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0
          ? Media.fromJSON(jsonMap['media'][0])
          : new Media();
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["user_id"] = user_id;
    map["user_email"] = user_email;
    map["user_name"] = user_name;
    map["role_id"] = role_id;
    map["user_password"] = user_password;
    map["api_token"] = apiToken;
    map["phone_id"] = phone_id;
    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    map["user_phone"] = user_phone;
    map["address"] = address;
    map["bio"] = bio;
    map["media"] = image?.toMap();
    map["dob"] = dob;
    map["nationalId"] = nationalId;
    map["citizenship"] = citizenship;
    map["birthDay"] = birthDay;
    map["accountNumber"] = accountNumber;
    map["carModelNumber"] = carModelNumber;
    map["online_status"] = online_status;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
