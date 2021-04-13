class HomeModel {

  int id;
  String name;

  HomeModel({ this.id, this.name });

  HomeModel.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.name = json['name'];
  }

  Map<String, dynamic> toJson() => {'id':id, 'name':name };
}