List<UnitModel> unitModelFromJson(dynamic str) => List<UnitModel>.from((str as List<dynamic>).map((x) => UnitModel.fromJson(x)));
class UnitModel {
  String id;
  String code;
  String name;
  String base_unit;
  String operator;
  String unit_value;
  String operation_value;
  UnitModel({
    this.id,
    this.code,
    this.name,
    this.base_unit,
    this.operator,
    this.unit_value,
    this.operation_value,
  });

  UnitModel.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.code = json['code'];
      this.name = json['name'];
      this.base_unit = json['base_unit'];
      this.operator = json['operator'];
      this.unit_value = json['unit_value'];
      this.operation_value = json['operation_value'];
  }

  Map<String, dynamic> toJson() => {'id':id, 'name':name };
}