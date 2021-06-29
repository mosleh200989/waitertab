
List<NotificationModel> notificationFromJson(dynamic str) => List<NotificationModel>.from((str as List<dynamic>).map((x) => NotificationModel.fromJSON(x)));
class NotificationModel {
   String id;
   String comment;
   String date;
   String from_date;
   String till_date;
   String scope;
   String touserid;
   String isread;
   String user_id;
  NotificationModel();

  NotificationModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] !=null ? jsonMap['id'] : '';
      comment = jsonMap['comment'] !=null ? jsonMap['comment'] : '';
      date = jsonMap['date'] !=null ? jsonMap['date'] : '';
      from_date = jsonMap['from_date'] !=null ? jsonMap['from_date'] : '';
      till_date = jsonMap['till_date'] !=null ? jsonMap['till_date'] : '';
      scope = jsonMap['scope'] !=null ? jsonMap['scope'] : '';
      touserid = jsonMap['touserid'] !=null ? jsonMap['touserid'] : '';
      isread = jsonMap['isread'] !=null ? jsonMap['isread'] : '';
      user_id = jsonMap['user_id'] !=null ? jsonMap['user_id'] : '';

    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["comment"] = comment;
    map["date"] = date;
    map["from_date"] = from_date;
    map["till_date"] = till_date;
    map["scope"] = scope;
    map["touserid"] = touserid;
    map["isread"] = isread;
    map["user_id"] = user_id;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }
}
