import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/cancel_task_newList.dart';
import 'package:task_manager_project/ui/screens/completed_task_newList.dart';
import 'package:task_manager_project/ui/screens/progress_task_newList.dart';
import '../widgets/taskManagerAppBar.dart';
import 'new_task_list_screen.dart';

class MainNavBarHolder extends StatefulWidget {
  const MainNavBarHolder({super.key});
  static const String name = '/main-nav-bar-holder';
  @override
  State<MainNavBarHolder> createState() => _MainNavBarHolderState();
}

class _MainNavBarHolderState extends State<MainNavBarHolder> {
  List<Widget> _screens=[
    NewTaskListScreen(),
    ProgressTaskListScreen(),
    CompletedTaskNewList(),
    CanceledTaskNewList()
  ];
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
          onDestinationSelected: (int index){
          setState(() {
            _selectedIndex = index;
          });
          },
          destinations: [
            NavigationDestination(icon: (Icon(Icons.new_label_outlined)), label: 'New'),
            NavigationDestination(icon: (Icon(Icons.arrow_circle_right_outlined)), label: 'Progess'),
            NavigationDestination(icon: (Icon(Icons.done)), label: 'Completed'),
            NavigationDestination(icon: (Icon(Icons.close_sharp)), label: 'Canceled'),

          ]
      ),
    );
  }

}

