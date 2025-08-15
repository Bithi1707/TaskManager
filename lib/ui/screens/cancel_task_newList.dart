import 'package:flutter/material.dart';
import '../widgets/taskCard.dart';
class CanceledTaskNewList extends StatefulWidget {
  const CanceledTaskNewList({super.key});

  @override
  State<CanceledTaskNewList> createState() => _CanceledTaskNewListState();
}

class _CanceledTaskNewListState extends State<CanceledTaskNewList> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: 10, // You can define item count here
        itemBuilder: (BuildContext context, int index) {
          // return TaskCard(
          //   statusLabel: 'Canceled',
          //   statusColor: Colors.orange,
          // );
        },
      ),
    );
  }
}
