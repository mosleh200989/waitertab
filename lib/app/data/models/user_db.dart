
List<UserDb> userDbFromJson(dynamic str) => List<UserDb>.from((str as List<dynamic>).map((x) => UserDb.fromJSON(x)));
class UserDb {
  String username;
  String email;
  String id;
  String password;
  String active;
  String last_login;
  String last_ip_address;
  String avatar;
  String gender;
  String group_id;
  String warehouse_id;
  String biller_id;
  String company_id;
  String view_right;
  String edit_right;
  String allow_discount;
  String show_cost;
  String show_price;
  String identity;
  String apiKey;
// used for indicate if client logged in or not
  bool auth;
  UserDb();

  UserDb.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      username = jsonMap['username'] !=null ? jsonMap['username'] : '';
      email = jsonMap['email'] !=null ? jsonMap['email'] : '';
      id = jsonMap['id'] !=null ? jsonMap['id'] : '';
      password = jsonMap['password'] !=null ? jsonMap['password'] : '';
      active = jsonMap['active'] !=null ? jsonMap['active'] : '';
      last_login = jsonMap['last_login'] !=null ? jsonMap['last_login'] : '';
      last_ip_address = jsonMap['last_ip_address'] !=null ? jsonMap['last_ip_address'] : '';
      avatar = jsonMap['avatar'] !=null ? jsonMap['avatar'] : '';
      gender = jsonMap['gender'] !=null ? jsonMap['gender'] : '';
      group_id = jsonMap['group_id'] !=null ? jsonMap['group_id'] : '';
      warehouse_id = jsonMap['warehouse_id'] !=null ? jsonMap['warehouse_id'] : '';
      biller_id = jsonMap['biller_id'] !=null ? jsonMap['biller_id'] : '';
      company_id = jsonMap['company_id'] !=null ? jsonMap['company_id'] : '';
      view_right = jsonMap['view_right'] !=null ? jsonMap['view_right'] : '';
      edit_right = jsonMap['edit_right'] !=null ? jsonMap['edit_right'] : '';
      allow_discount = jsonMap['allow_discount'] !=null ? jsonMap['allow_discount'] : '';
      show_cost = jsonMap['show_cost'] !=null ? jsonMap['show_cost'] : '';
      show_price = jsonMap['show_price'] !=null ? jsonMap['show_price'] : '';

    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["email"] = email;
    map["id"] = id;
    map["password"] = password;
    map["active"] = active;
    map["last_login"] = last_login;
    map["last_ip_address"] = last_ip_address;
    map["avatar"] = avatar;
    map["gender"] = gender;
    map["group_id"] = group_id;
    map["warehouse_id"] = warehouse_id;
    map["biller_id"] = biller_id;
    map["company_id"] = company_id;
    map["view_right"] = view_right;
    map["edit_right"] = edit_right;
    map["allow_discount"] = allow_discount;
    map["show_cost"] = show_cost;
    map["show_price"] = show_price;
    map["identity"] = identity;
    map["api-key"] = apiKey;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
