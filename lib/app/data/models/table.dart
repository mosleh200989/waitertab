
//
// List<Categories> categoriesFromJson(dynamic str) =>
//     List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));
 List<TableModel> tableModelFromJson(dynamic str) => List<TableModel>.from((str as List<dynamic>).map((x) => TableModel.fromJson(x)));

// String categoriesToJson(List<Categories> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableModel {
  String id;
  String name;
  String capacity;
  String floor;
  TableModel({
    this.id,
    this.name,
    this.capacity,
    this.floor,
  });

  TableModel.fromJson(Map<String, dynamic> json){
  try{
    this.id = json['id'] != null ? json['id'] : null;
    this.name = json['name'] != null ? json['name'] : null;
    this.capacity = json['capacity'] != null ? json['capacity'] : null;
    this.floor = json['floor'] != null ? json['floor'] : null;
  }catch(e){
    print(e);
  }
  }


  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["capacity"] = capacity;
    map["floor"] = floor;
    return map;
  }
}