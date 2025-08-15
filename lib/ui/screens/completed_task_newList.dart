import 'package:flutter/material.dart';

import '../widgets/taskCard.dart';
class CompletedTaskNewList extends StatefulWidget {
  const CompletedTaskNewList({super.key});

  @override
  State<CompletedTaskNewList> createState() => _CompletedTaskNewListState();
}

class _CompletedTaskNewListState extends State<CompletedTaskNewList> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: 10, // You can define item count here
        itemBuilder: (BuildContext context, int index) {
          // return TaskCard(
          //   taskType: TaskType.completed,
          //   taskModel: task,
          //   onStatusUpdate: _getCompletedTaskList,
          // );
        },
      ),
    );
  }
}
