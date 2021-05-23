import 'package:waiter/app/data/models/options.dart';
import 'package:waiter/app/data/models/tax_rate.dart';
import 'package:waiter/app/data/models/unit.dart';

List<Product> productFromJson(dynamic str) => List<Product>.from((str as List<dynamic>).map((x) => Product.fromJson(x)));
class Product {
  String code;
  String id;
  String image_url;
  String name;
  String net_price;
  String option;
  bool options;
  String optiontext;
  String price;
  String slug;
  String tax_method;
  String type;
  String unit_price;
  TaxRate tax_rate;
  UnitModel unit;
  List<OptionModel> optionsList;
  int counter=1;
  double totalPrice;

  Product({
    this.code,
    this.id,
    this.image_url,
    this.name,
    this.net_price,
    this.option,
    this.options,
    this.optiontext,
    this.price,
    this.slug,
    this.tax_method,
    this.type,
    this.unit_price,
    this.tax_rate,
    this.unit,
    this.optionsList,
    this.counter,
  });

  Product.fromJson(Map<String, dynamic> json){
      this.code = json['code'] != null ? json['code'] : null;
      this.id = json['id'] != null ? json['id'] : null;
      this.image_url = json['image_url'] != null ? json['image_url'] : null;
      this.name = json['name'] != null ? json['name'] : null;
      this.net_price = json['net_price'] != null ? json['net_price'] : null;

      this.options = json['options'] != null ? json['options'] : null;
      this.optiontext = json['optiontext'] != null ? json['optiontext'] : null;
      this.price = json['price'] != null ? json['price'] : null;
      this.slug = json['slug'] != null ? json['slug'] : null;
      this.tax_method = json['tax_method'] != null ? json['tax_method'] : null;
      this.type = json['type'] != null ? json['type'] : null;
      this.unit_price = json['unit_price'] != null ? json['unit_price'] : null;
      this.tax_rate = json['tax_rate'] != null ? TaxRate.fromJson(json['tax_rate']) : null;
      this.unit = json['unit'] != null ? UnitModel.fromJson(json['unit']) : null;
      if(json['options']==false){
        this.option = json['option'] != null ? json['option'] : null;
      }else{
        this.optionsList = json['options'] != null && (json['options'] as List).length > 0
            ? List.from(json['options']).map((element) => OptionModel.fromJson(element)).toList()
            : [];
      }

  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'name':name };
}