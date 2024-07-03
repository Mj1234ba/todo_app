import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/fire_base_utils.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/tasks/task_provider.dart';
import 'package:todo_app/theme.dart';

class TaskItem extends StatefulWidget {
  final TaskModel taskModel;
  const TaskItem({required this.taskModel, super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
          color: AppTheme.white, borderRadius: BorderRadius.circular(15)),
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          //  dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: deleteTasks,
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(15),
            ),
            // SlidableAction(
            //   onPressed: doNothing,
            //   backgroundColor: Color(0xFF21B7CA),
            //   foregroundColor: Colors.white,
            //   icon: Icons.share,
            //   label: 'Share',
            // ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: AppTheme.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 62,
                color: Theme.of(context).primaryColor,
                margin: const EdgeInsetsDirectional.only(end: 20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.taskModel.title,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.taskModel.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 69,
                height: 34,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteTasks(BuildContext ctx) {
    final userId=Provider.of<UserProvider>(context).currentUser!.id;
    FirebaseUtils.deletetaskFromFireStore(widget.taskModel.id,userId)
        .timeout(const Duration(milliseconds: 400), onTimeout: () {
      Provider.of<TaskProvider>(context, listen: false).getTasks(userId);

      Fluttertoast.showToast(
          msg: "Delete Task", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);

    
    }).catchError((error) {
    
      Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16.0);
    });
  }
}
