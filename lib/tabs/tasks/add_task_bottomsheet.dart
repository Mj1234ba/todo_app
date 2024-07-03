import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/fire_base_utils.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/tasks/default_elevated_button.dart';
import 'package:todo_app/tabs/tasks/default_form_field.dart';
import 'package:todo_app/tabs/tasks/task_provider.dart';
import 'package:todo_app/theme.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var selectDate = DateTime.now();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return LayoutBuilder(builder: (context, con) {
      print('from main is ${con.maxWidth}');
      return Container(
        height: MediaQuery.of(context).size.height * .5,
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  'Add New Task',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
                DefaultTextFtromField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'title can not be empty';
                    }
                    return null;
                  },
                  hintText: 'Enter Task Title ',
                  textEditingController: titleController,
                ),
                const SizedBox(
                  height: 16,
                ),
                DefaultTextFtromField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description can not be empty';
                    }
                    return null;
                  },
                  textEditingController: descriptionController,
                  hintText: 'Enter Task Description ',
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Selected Date',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                InkWell(
                    onTap: () async {
                      final dateTime = await showDatePicker(
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDate: selectDate,
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)));
                      if (dateTime != null) {
                        selectDate = dateTime;
                        setState(() {});
                      }
                    },
                    child: Text(dateFormat.format(selectDate),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black))),
                const SizedBox(
                  height: 8,
                ),
                DefaultElevtedButton(
                    child: Text(
                      "ADD",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppTheme.white),
                    ),
                    onpress: () {
                      addTask();
                    })
              ],
            ),
          ),
        ),
      );
    });
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      FirebaseUtils.addTaskToFireStore(
        TaskModel(
          title: titleController.text,
          dateTime: selectDate,
          description: descriptionController.text,
        ),
        Provider.of<UserProvider>(context, listen: false).currentUser!.id,
      ).then((value) {Provider.of<TaskProvider>(context, listen: false).getTasks(
            Provider.of<UserProvider>(context, listen: false).currentUser!.id);
        Navigator.of(context).pop();

        Fluttertoast.showToast(
            msg: "This is Center Short Toast",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16.0);

        print('success &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');}).catchError((error) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "This is Center Short Toast",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16.0);
      });
    }
  }
}
