
List<Payment> paymentFromJson(dynamic str) => List<Payment>.from((str as List<dynamic>).map((x) => Payment.fromJSON(x)));
class Payment {
  String id;
  String amount;
  String balance_amount;
  String paid_by;
  String cc_no;
  String paying_gift_card_no;
  String cc_holder;
  String cheque_no;
  String cc_month;
  String cc_year;
  String cc_type;
  String cc_cvv2;
  String payment_note;
  Payment({
    this.id,
    this.amount,
    this.balance_amount,
    this.paid_by,
    this.cc_no,
    this.paying_gift_card_no,
    this.cc_holder,
    this.cheque_no,
    this.cc_month,
    this.cc_year,
    this.cc_type,
    this.cc_cvv2,
    this.payment_note,
});

  Payment.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] !=null ? jsonMap['id'] : '';
      amount = jsonMap['amount'] !=null ? jsonMap['amount'] : '';
      balance_amount = jsonMap['balance_amount'] !=null ? jsonMap['balance_amount'] : '';
      paid_by = jsonMap['paid_by'] !=null ? jsonMap['paid_by'] : '';
      cc_no = jsonMap['cc_no'] !=null ? jsonMap['cc_no'] : '';
      paying_gift_card_no = jsonMap['paying_gift_card_no'] !=null ? jsonMap['paying_gift_card_no'] : '';
      cc_holder = jsonMap['cc_holder'] !=null ? jsonMap['cc_holder'] : '';
      cheque_no = jsonMap['cheque_no'] !=null ? jsonMap['cheque_no'] : '';
      cc_month = jsonMap['cc_month'] !=null ? jsonMap['cc_month'] : '';
      cc_year = jsonMap['cc_year'] !=null ? jsonMap['cc_year'] : '';
      cc_type = jsonMap['cc_type'] !=null ? jsonMap['cc_type'] : '';
      cc_cvv2 = jsonMap['cc_cvv2'] !=null ? jsonMap['cc_cvv2'] : '';
      payment_note = jsonMap['payment_note'] !=null ? jsonMap['payment_note'] : '';

    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['amount'] = amount;
    map['balance_amount'] = balance_amount;
    map['paid_by'] = paid_by;
    map['cc_no'] = cc_no;
    map['paying_gift_card_no'] = paying_gift_card_no;
    map['cc_holder'] = cc_holder;
    map['cheque_no'] = cheque_no;
    map['cc_month'] = cc_month;
    map['cc_year'] = cc_year;
    map['cc_type'] = cc_type;
    map['cc_cvv2'] = cc_cvv2;
    map['payment_note'] = payment_note;
    return map;
  }
  List<Map<String, dynamic>> toMapList(List<Payment> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (Payment data in objectList) {
        if (data != null) {
          mapList.add(data.toMap());
        }
      }
    }
    return mapList;
  }
  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }
}
