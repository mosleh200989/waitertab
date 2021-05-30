

List<OptionModel> optionFromJson(dynamic str) => List<OptionModel>.from((str as List<dynamic>).map((x) => OptionModel.fromJson(x)));
class OptionModel {
  String id;
  String name;
  String price;
  String total_quantity;
  String quantity;

  OptionModel({
    this.id,
    this.name,
    this.price,
    this.total_quantity,
    this.quantity,
  });

  OptionModel.fromJson(Map<String, dynamic> json){
      this.id = json['id'] != null ? json['id'] : null;
      this.name = json['name'] != null ? json['name'] : null;
      this.price = json['price'] != null ? json['price'] : null;
      this.total_quantity = json['total_quantity'] != null ? json['total_quantity'] : null;
      this.quantity = json['quantity'] != null ? json['quantity'] : null;
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'name':name };
}