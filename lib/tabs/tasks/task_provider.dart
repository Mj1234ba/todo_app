import 'package:flutter/material.dart';
import 'package:todo_app/fire_base_utils.dart';
import 'package:todo_app/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> taskes = [];
  DateTime selectDate = DateTime.now();
  Future<void> getTasks(String userId) async {
    final allTaskes =
        await FirebaseUtils.getAllTasksFromFireStore(userId).catchError((e) {});
    taskes = allTaskes
        .where((task) =>
            task.dateTime.day == selectDate.day &&
            task.dateTime.month == selectDate.month &&
            task.dateTime.year == selectDate.year)
        .toList();
    taskes
        .sort((task, newxtTask) => task.dateTime.compareTo(newxtTask.dateTime));

    notifyListeners();
  }

  void changeSelectedDate(DateTime dateTime, String userId) {
    selectDate = dateTime;
    getTasks(userId);
  }
}
