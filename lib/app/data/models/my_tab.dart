import 'package:flutter/material.dart';

class MyTabModel {
  int id;
  String title;
  Color color;

  MyTabModel({ this.id, this.title,this.color });

  MyTabModel.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.title = json['title'];
      this.color = json['color'];
  }

  Map<String, dynamic> toJson() => {'id':id, 'name':title,'color':color };
}