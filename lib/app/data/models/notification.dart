
List<NotificationModel> notificationFromJson(dynamic str) => List<NotificationModel>.from((str as List<dynamic>).map((x) => NotificationModel.fromJSON(x)));
class NotificationModel {
   String id;
   String title;
   String comment;
   String date;
   // String time;
   String from_date;
   String till_date;
   String scope;
   String touserid;
   String isread;
   String user_id;
   String is_notified;
   String apiKey;
  NotificationModel();

  NotificationModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] !=null ? jsonMap['id'] : '';
      title = jsonMap['title'] !=null ? jsonMap['title'] : '';
      comment = jsonMap['comment'] !=null ? jsonMap['comment'] : '';
      // date = jsonMap['date'] !=null ? jsonMap['date'] : '';
      String dateValue = jsonMap["date"];
      var adddate=jsonMap["date"] != null ? dateValue.substring(0, 10):null;
      // time = jsonMap["date"] != null ? dateValue.substring(11, 19) :null;
      date =adddate;
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
    map["notify_id"] = id;
    // map["comment"] = comment;
    // map["date"] = date;
    // map["from_date"] = from_date;
    // map["till_date"] = till_date;
    // map["scope"] = scope;
    // map["touserid"] = touserid;
    // map["isread"] = isread;
    map["user_id"] = user_id;
    map["is_notified"] = is_notified;
    map["api-key"] = apiKey;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }
}
