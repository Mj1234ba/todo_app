import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/fire_base_utils.dart';
import 'package:todo_app/tabs/tasks/task_item.dart';
import 'package:todo_app/tabs/tasks/task_provider.dart';

class TasksTap extends StatelessWidget {
  const TasksTap({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider=Provider.of<UserProvider>(context).currentUser!.id;
    final taskProvider = Provider.of<TaskProvider>(context)..getTasks(userProvider);
    
    //taskProvider.getTasks();
    return Column(
      children: [
        TimelineCalendar(
          dateTime: CalendarDateTime(
              year: taskProvider.selectDate.year,
              month: taskProvider.selectDate.month,
              day: taskProvider.selectDate.day),
          calendarType: CalendarType.GREGORIAN,
          calendarLanguage: "en",
          calendarOptions: CalendarOptions(
            viewType: ViewType.DAILY,
            toggleViewType: true,
            headerMonthElevation: 10,
            headerMonthShadowColor: Colors.black26,
            headerMonthBackColor: Colors.transparent,
          ),
          dayOptions: DayOptions(
              compactMode: true,
              weekDaySelectedColor: Theme.of(context).primaryColor,
              selectedBackgroundColor: Theme.of(context).primaryColor,
              disableDaysBeforeNow: true),
          headerOptions: HeaderOptions(
              weekDayStringType: WeekDayStringTypes.SHORT,
              monthStringType: MonthStringTypes.FULL,
              backgroundColor: Theme.of(context).primaryColor,
              headerTextColor: Colors.black),
          onChangeDateTime: (datetime) {
            taskProvider.changeSelectedDate(datetime.toDateTime(),userProvider);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: taskProvider.taskes.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  taskModel: taskProvider.taskes[index],
                );
              }),
        ),
      ],
    );
  }
}
