

class TaskCheckItemModel {

  String id;
  String taskid;
  String description;
  String finished;
  String dateadded;
  String addedfrom;
  String finished_from;
  String list_order;
  String assigned;
  String user_id;
  String apiKey;
  TaskCheckItemModel({
    this.id,
    this.taskid,
    this.description,
    this.finished,
    this.dateadded,
    this.addedfrom,
    this.finished_from,
    this.list_order,
    this.assigned,
    this.user_id,
    this.apiKey,
  });
  TaskCheckItemModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] !=null ? jsonMap['id'] : '';
      taskid = jsonMap['taskid'] !=null ? jsonMap['taskid'] : '';
      description = jsonMap['description'] !=null ? jsonMap['description'] : '';
      finished = jsonMap['finished'] !=null ? jsonMap['finished'] : '';
      dateadded = jsonMap['dateadded'] !=null ? jsonMap['dateadded'] : '';
      addedfrom = jsonMap['addedfrom'] !=null ? jsonMap['addedfrom'] : '';
      finished_from = jsonMap['finished_from'] !=null ? jsonMap['finished_from'] : '';
      list_order = jsonMap['list_order'] !=null ? jsonMap['list_order'] : '';
      assigned = jsonMap['assigned'] !=null ? jsonMap['assigned'] : '';
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["checklist_id"] = id;
    map["taskid"] = taskid;
    map["finished"] = finished;
    map["user_id"] = user_id;
    map["api-key"] = apiKey;
    return map;
  }
}