import 'dart:convert';
//
// List<Categories> categoriesFromJson(dynamic str) =>
//     List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));
 List<Categories> categoriesFromJson(dynamic str) => List<Categories>.from((str as List<dynamic>).map((x) => Categories.fromJson(x)));

// String categoriesToJson(List<Categories> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  String id;
  String code;
  String name;
  String name_alt;
  String image;
  String parent_id;
  String slug;
  String description;
  Categories({
    this.id,
    this.code,
    this.name,
    this.name_alt,
    this.image,
    this.parent_id,
    this.slug,
    this.description,
  });

  Categories.fromJson(Map<String, dynamic> json){
  try{
    this.id = json['id'] != null ? json['id'] : null;
    this.code = json['code'] != null ? json['code'] : null;
    this.name = json['name'] != null ? json['name'] : null;
    this.name_alt = json['name_alt'] != null ? json['name_alt'] : null;
    this.image = json['image'] != null ? json['image'] : null;
    this.parent_id = json['parent_id'] != null ? json['parent_id'] : null;
    this.slug = json['slug'] != null ? json['slug'] : null;
    this.description = json['description'] != null ? json['description'] : null;
  }catch(e){
    print(e);
  }
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'code':code,
    'name':name,
    'name_alt':name_alt,
    'image':image,
    'parent_id':parent_id,
    'slug':slug,
    'description':description,
  };
}