import 'package:flutter/material.dart';
import 'package:todo_app/tabs/settings/setting_tabs.dart';
import 'package:todo_app/tabs/tasks/add_task_bottomsheet.dart';
import 'package:todo_app/tabs/tasks/task_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [
    TasksTap(),
    SettingTabs(),
  ];

  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<String> appBarTitle = [
      AppLocalizations.of(context)!.todoList,
      AppLocalizations.of(context)!.setting
    ];
    return Scaffold(
      appBar: AppBar(
        title: Padding(
            padding:const  EdgeInsetsDirectional.only(
              start: 20,
            ),
            child: Text(appBarTitle[selectIndex])),
      ),
      body: tabs[selectIndex],
      bottomNavigationBar: BottomAppBar(
      clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: EdgeInsets.zero,
       shape:const  CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 0,
        /////
        // surfaceTintColor: Colors.white,
        ////
        child: BottomNavigationBar(
            currentIndex: selectIndex,
            // selectedIconTheme: IconThemeData(color: Colors.green),
            onTap: (value) {
              setState(() {
                selectIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined), label: '')
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddTaskBottomSheet();
              });
        },
        child: Icon(
          Icons.add,
          size: 32,
          // color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
