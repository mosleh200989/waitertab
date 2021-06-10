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
  String cgst;
  String comment;
  String discount;
  String gst;
  String igst;
  String item_discount;
  String item_tax;
  String net_unit_price;
  String product_unit_code;
  String product_unit_id;
  String product_unit_quantity;
  String serial_no;
  String sgst;
  String subtotal;
  String tax;
  String tax_rate_id;
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
    this.cgst,
    this.comment,
    this.discount,
    this.gst,
    this.igst,
    this.item_discount,
    this.item_tax,
    this.net_unit_price,
    this.product_unit_code,
    this.product_unit_id,
    this.product_unit_quantity,
    this.serial_no,
    this.sgst,
    this.subtotal,
    this.tax,
    this.tax_rate_id,
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
      this.cgst = json['cgst'];
      this.comment = json['comment'];
      this.discount = json['discount'];
      this.gst = json['gst'];
      this.igst = json['igst'];
      this.item_discount = json['item_discount'];
      this.item_tax = json['item_tax'];
      this.net_unit_price = json['net_unit_price'];
      this.product_unit_code = json['product_unit_code'];
      this.product_unit_id = json['product_unit_id'];
      this.product_unit_quantity = json['product_unit_quantity'];
      this.serial_no = json['serial_no'];
      this.sgst = json['sgst'];
      this.subtotal = json['subtotal'];
      this.tax = json['tax'];
      this.tax_rate_id = json['tax_rate_id'];

  }

  // Map<String, dynamic> toJson() => {'id':id,};
  Map toMap() {
    var map = new Map<String, dynamic>();
    // map['id'] = id;
    // map['product_id'] = product_id;
    // map['quantity'] = quantity;
    // map['product_base_quantity'] = product_base_quantity;
    // map['product_unit'] = product_unit;
    // map['product_type'] = product_type;
    // map['product_code'] = product_code;
    // map['product_name'] = product_name;
    // map['product_option'] = product_option;
    // map['product_discount'] = product_discount;
    // map['product_tax'] = product_tax;
    // map['net_price'] = net_price;
    // map['unit_price'] = unit_price;
    // map['real_unit_price'] = real_unit_price;
    // map['product_comment'] = product_comment;
    // map['serial'] = serial;
    // map['isOrder'] = isOrder;
    // map['product'] = product;
    // map['notes'] = notes;
    // map['textEditContNotes'] = textEditContNotes;
    // map['isNotes'] = isNotes;
    // map['cgst'] = cgst;
    // map['comment'] = comment;
    // map['discount'] = discount;
    // map['gst'] = gst;
    // map['igst'] = igst;
    // map['item_discount'] = item_discount;
    // map['item_tax'] = item_tax;
    // map['net_unit_price'] = net_unit_price;
    // map['product_unit_code'] = product_unit_code;
    // map['product_unit_id'] = product_unit_id;
    // map['product_unit_quantity'] = product_unit_quantity;
    // map['serial_no'] = serial_no;
    // map['sgst'] = sgst;
    // map['subtotal'] = subtotal;
    // map['tax'] = tax;
    // map['tax_rate_id'] = tax_rate_id;
    map['product_id'] = product_id;
    map['quantity'] = quantity;
    map['product_base_quantity'] = product_base_quantity;
    map['product_unit'] = product_unit;
    map['product_type'] = product_type;
    map['product_code'] = product_code;
    map['product_name'] = product_name;
    map['product_option'] = product_option;
    map['product_discount'] = product_discount;
    map['product_tax'] = product_tax;
    map['net_price'] = net_price;
    map['unit_price'] = unit_price;
    map['real_unit_price'] = real_unit_price;
    map['product_comment'] = product_comment;
    map['serial'] = serial;
    return map;
  }
  List<Map<String, dynamic>> toMapList(List<Basket> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (Basket data in objectList) {
        if (data != null) {
          mapList.add(data.toMap());
        }
      }
    }
    return mapList;
  }
}
