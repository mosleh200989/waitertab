
List<Warehouse> warehouseFromJson(dynamic str) => List<Warehouse>.from((str as List<dynamic>).map((x) => Warehouse.fromJSON(x)));
class Warehouse {
  String id;
  String code;
  String name;
  String address;
  String map;
  String phone;
  String email;
  String price_group_id;
  Warehouse({
    this.id,
    this.code,
    this.name,
    this.address,
    this.map,
    this.phone,
    this.email,
    this.price_group_id,
});

  Warehouse.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] !=null ? jsonMap['id'] : '';
      code = jsonMap['code'] !=null ? jsonMap['code'] : '';
      name = jsonMap['name'] !=null ? jsonMap['name'] : '';
      address = jsonMap['address'] !=null ? jsonMap['address'] : '';
      map = jsonMap['map'] !=null ? jsonMap['map'] : '';
      phone = jsonMap['phone'] !=null ? jsonMap['phone'] : '';
      email = jsonMap['email'] !=null ? jsonMap['email'] : '';
      price_group_id = jsonMap['price_group_id'] !=null ? jsonMap['price_group_id'] : '';

    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    map['address'] = address;
    map['map'] = map;
    map['phone'] = phone;
    map['email'] = email;
    map['price_group_id'] = price_group_id;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }
}
