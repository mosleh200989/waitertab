
import 'package:waiter/app/data/models/task_checkitem.dart';

List<Tasks> taskFromJson(dynamic str) => List<Tasks>.from((str as List<dynamic>).map((x) => Tasks.fromJSON(x)));
class Tasks {
  String id;
  String name;
  String description;
  String priority;
  String status;
  String statusValue;
  String user_id;
  String apiKey;
  String startdate;
  String duedate;
  String dateadded;
  List<TaskCheckItemModel> checklist_items=[];
  Tasks({
    this.id,
    this.name,
    this.description,
    this.priority,
    this.status,
    this.statusValue,
    this.user_id,
    this.apiKey,
    this.startdate,
    this.duedate,
    this.dateadded,
    this.checklist_items,
});
  Tasks.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] !=null ? jsonMap['id'] : '';
      name = jsonMap['name'] !=null ? jsonMap['name'] : '';
      description = jsonMap['description'] !=null ? jsonMap['description'] : '';
      priority = jsonMap['priority'] !=null ? jsonMap['priority'] : '';
      status = jsonMap['status'] !=null ? jsonMap['status'] : '';
      startdate = jsonMap['startdate'] !=null ? jsonMap['startdate'] : '';
      duedate = jsonMap['duedate'] !=null ? jsonMap['duedate'] : '';
      dateadded = jsonMap['dateadded'] !=null ? jsonMap['dateadded'] : '';
      checklist_items = jsonMap['checklist_items'] != null ? List.from(jsonMap['checklist_items']).map((element) => TaskCheckItemModel.fromJSON(element)).toList() : [];

    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["description"] = description;
    map["status_id"] = status;
    map["user_id"] = status;
    map["api-key"] = apiKey;
    map["startdate"] = startdate;
    map["duedate"] = duedate;
    map["dateadded"] = dateadded;
    map["priority"] = priority;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }
}
