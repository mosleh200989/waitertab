import 'dart:ffi';

import 'package:waiter/app/data/models/basket.dart';

import '../models/media.dart';
List<BillerDetails> billerDetailsFromJson(dynamic str) => List<BillerDetails>.from((str as List<dynamic>).map((x) => BillerDetails.fromJSON(x)));
class BillerDetails {
  String id;
  String group_id;
  String group_name;
  String customer_group_id;
  String customer_group_name;
  String name;
  String company;
  String vat_no;
  String address;
  String city;
  String state;
  String postal_code;
  String country;
  String phone;
  String email;
  String cf1;
  String cf2;
  String cf3;
  String cf4;
  String cf5;
  String cf6;
  String invoice_footer;
  String payment_term;
  String logo;
  String award_points;
  String deposit_amount;
  String price_group_id;
  String price_group_name;
  String gst_no;
  BillerDetails({
    this.id,
    this.group_id,
    this.group_name,
    this.customer_group_id,
    this.customer_group_name,
    this.name,
    this.company,
    this.vat_no,
    this.address,
    this.city,
    this.state,
    this.postal_code,
    this.country,
    this.phone,
    this.email,
    this.cf1,
    this.cf2,
    this.cf3,
    this.cf4,
    this.cf5,
    this.cf6,
    this.invoice_footer,
    this.payment_term,
    this.logo,
    this.award_points,
    this.deposit_amount,
    this.price_group_id,
    this.price_group_name,
    this.gst_no,
});

  BillerDetails.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id=jsonMap['id'] !=null ? jsonMap['id'] : '';
      group_id=jsonMap['group_id'] !=null ? jsonMap['group_id'] : '';
      group_name=jsonMap['group_name'] !=null ? jsonMap['group_name'] : '';
      customer_group_id=jsonMap['customer_group_id'] !=null ? jsonMap['customer_group_id'] : '';
      customer_group_name=jsonMap['customer_group_name'] !=null ? jsonMap['customer_group_name'] : '';
      name=jsonMap['name'] !=null ? jsonMap['name'] : '';
      company=jsonMap['company'] !=null ? jsonMap['company'] : '';
      vat_no=jsonMap['vat_no'] !=null ? jsonMap['vat_no'] : '';
      address=jsonMap['address'] !=null ? jsonMap['address'] : '';
      city=jsonMap['city'] !=null ? jsonMap['city'] : '';
      state=jsonMap['state'] !=null ? jsonMap['state'] : '';
      postal_code=jsonMap['postal_code'] !=null ? jsonMap['postal_code'] : '';
      country=jsonMap['country'] !=null ? jsonMap['country'] : '';
      phone=jsonMap['phone'] !=null ? jsonMap['phone'] : '';
      email=jsonMap['email'] !=null ? jsonMap['email'] : '';
      cf1=jsonMap['cf1'] !=null ? jsonMap['cf1'] : '';
      cf2=jsonMap['cf2'] !=null ? jsonMap['cf2'] : '';
      cf3=jsonMap['cf3'] !=null ? jsonMap['cf3'] : '';
      cf4=jsonMap['cf4'] !=null ? jsonMap['cf4'] : '';
      cf5=jsonMap['cf5'] !=null ? jsonMap['cf5'] : '';
      cf6=jsonMap['cf6'] !=null ? jsonMap['cf6'] : '';
      invoice_footer=jsonMap['invoice_footer'] !=null ? jsonMap['invoice_footer'] : '';
      payment_term=jsonMap['payment_term'] !=null ? jsonMap['payment_term'] : '';
      logo=jsonMap['logo'] !=null ? jsonMap['logo'] : '';
      award_points=jsonMap['award_points'] !=null ? jsonMap['award_points'] : '';
      deposit_amount=jsonMap['deposit_amount'] !=null ? jsonMap['deposit_amount'] : '';
      price_group_id=jsonMap['price_group_id'] !=null ? jsonMap['price_group_id'] : '';
      price_group_name=jsonMap['price_group_name'] !=null ? jsonMap['price_group_name'] : '';
      gst_no=jsonMap['gst_no'] !=null ? jsonMap['gst_no'] : '';

    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['group_id'] = group_id;
    map['group_name'] = group_name;
    map['customer_group_id'] = customer_group_id;
    map['customer_group_name'] = customer_group_name;
    map['name'] = name;
    map['company'] = company;
    map['vat_no'] = vat_no;
    map['address'] = address;
    map['city'] = city;
    map['state'] = state;
    map['postal_code'] = postal_code;
    map['country'] = country;
    map['phone'] = phone;
    map['email'] = email;
    map['cf1'] = cf1;
    map['cf2'] = cf2;
    map['cf3'] = cf3;
    map['cf4'] = cf4;
    map['cf5'] = cf5;
    map['cf6'] = cf6;
    map['invoice_footer'] = invoice_footer;
    map['payment_term'] = payment_term;
    map['logo'] = logo;
    map['award_points'] = award_points;
    map['deposit_amount'] = deposit_amount;
    map['price_group_id'] = price_group_id;
    map['price_group_name'] = price_group_name;
    map['gst_no'] = gst_no;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }
}
