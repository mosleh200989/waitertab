List<TaxRate> taxRateFromJson(dynamic str) => List<TaxRate>.from((str as List<dynamic>).map((x) => TaxRate.fromJson(x)));
class TaxRate {
  String id;
  String name;
  String code;
  String rate;
  String type;

  TaxRate({
    this.id,
    this.name,
    this.code,
    this.rate,
    this.type,
  });

  TaxRate.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.name = json['name'];
      this.code = json['code'];
      this.rate = json['rate'];
      this.type = json['type'];
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'name':name };
}