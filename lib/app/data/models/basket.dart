import 'package:flutter/material.dart';
import 'package:waiter/app/data/models/product.dart';

class Basket {
  String id;
  String product_id;
  String quantity;
  String product_base_quantity;
  String product_unit;
  String product_type;
  String product_code;
  String product_name;
  String product_option;
  String product_discount;
  String product_tax;
  String net_price;
  String unit_price;
  String real_unit_price;
  String product_comment;
  String serial;
  bool isOrder;
  Product product;
  String notes;
  TextEditingController textEditContNotes;
  bool isNotes=false;

  Basket({
    this.id,
    this.product_id,
    this.quantity,
    this.product_base_quantity,
    this.product_unit,
    this.product_type,
    this.product_code,
    this.product_name,
    this.product_option,
    this.product_discount,
    this.product_tax,
    this.net_price,
    this.unit_price,
    this.real_unit_price,
    this.product_comment,
    this.serial,
    this.isOrder,
    this.product,
    this.notes,
    this.textEditContNotes,
    this.isNotes,
  });

  Basket.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.product_id = json['product_id'];
      this.quantity = json['quantity'];
      this.product_base_quantity = json['product_base_quantity'];
      this.product_unit = json['product_unit'];
      this.product_type = json['product_type'];
      this.product_code = json['product_code'];
      this.product_name = json['product_name'];
      this.product_option = json['product_option'];
      this.product_discount = json['product_discount'];
      this.product_tax = json['product_tax'];
      this.net_price = json['net_price'];
      this.unit_price = json['unit_price'];
      this.real_unit_price = json['real_unit_price'];
      this.product_comment = json['product_comment'];
      this.serial = json['serial'];
  }

  Map<String, dynamic> toJson() => {'id':id,};
}