
List<Task> taskFromJson(dynamic str) => List<Task>.from((str as List<dynamic>).map((x) => Task.fromJSON(x)));
class Task {
  String id;
  String name;
  String description;
  String priority;
  String status;
  String statusValue;
  String user_id;
  String apiKey;
  Task();
  Task.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] !=null ? jsonMap['id'] : '';
      name = jsonMap['name'] !=null ? jsonMap['name'] : '';
      description = jsonMap['description'] !=null ? jsonMap['description'] : '';
      priority = jsonMap['priority'] !=null ? jsonMap['priority'] : '';
      status = jsonMap['status'] !=null ? jsonMap['status'] : '';

    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["status_id"] = status;
    map["user_id"] = status;
    map["api-key"] = apiKey;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }
}
