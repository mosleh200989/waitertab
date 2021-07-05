
List<NotificationsAlert> notificationAlertFromJson(dynamic str) => List<NotificationsAlert>.from((str as List<dynamic>).map((x) => NotificationsAlert.fromJSON(x)));
class NotificationsAlert {
   String id;
   String notify_id;
   String user_id;
   String is_notified;
   String is_read;
   NotificationsAlert();

   NotificationsAlert.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] !=null ? jsonMap['id'] : '';
      notify_id = jsonMap['notify_id'] !=null ? jsonMap['notify_id'] : '';
      user_id = jsonMap['user_id'] !=null ? jsonMap['user_id'] : '';
      is_notified = jsonMap['is_notified'] !=null ? jsonMap['is_notified'] : '';
      is_read = jsonMap['is_read'] !=null ? jsonMap['is_read'] : '';

    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["notify_id"] = id;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }
}
