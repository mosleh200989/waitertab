
//
// List<Categories> categoriesFromJson(dynamic str) =>
//     List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));
 List<CreatedBy> createdByFromJson(dynamic str) => List<CreatedBy>.from((str as List<dynamic>).map((x) => CreatedBy.fromJson(x)));

// String categoriesToJson(List<Categories> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CreatedBy {
  String avatar_url;
  String email;
  String first_name;
  String gender;
  String id;
  String last_name;
  String username;
  CreatedBy({
    this.avatar_url,
    this.email,
    this.first_name,
    this.gender,
    this.id,
    this.last_name,
    this.username,
  });

  CreatedBy.fromJson(Map<String, dynamic> json){
  try{
  avatar_url= json['avatar_url'] != null ? json['avatar_url'] : null;
  email= json['email'] != null ? json['email'] : null;
  first_name= json['first_name'] != null ? json['first_name'] : null;
  gender= json['gender'] != null ? json['gender'] : null;
  id= json['id'] != null ? json['id'] : null;
  last_name= json['last_name'] != null ? json['last_name'] : null;
  username= json['username'] != null ? json['username'] : null;
  }catch(e){
    print(e);
  }
  }

  Map<String, dynamic> toJson() => {
    'id':id,

  };
}