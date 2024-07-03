import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String title;
  String description;
  String id;
  DateTime dateTime;
  bool isdone;
  TaskModel(
      {required this.title,
      required this.dateTime,
      required this.description,
       this.id='',
       this.isdone=false});

  TaskModel.formjson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['title'],
            description: json['description'],
            dateTime:( json['dateTime'] as Timestamp ).toDate(),
            isdone: json['isdone']);

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isdone': isdone,
      'dateTime': Timestamp.fromDate(dateTime),
    };
  }
}
