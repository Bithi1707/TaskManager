import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/screen_background.dart';
import 'package:task_manager_project/ui/widgets/taskManagerAppBar.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/center_circular_indicator.dart';
import '../widgets/snack_bar_message.dart';
class AddNewTaskscreen extends StatefulWidget {
  const AddNewTaskscreen({super.key});

  @override
  State<AddNewTaskscreen> createState() => _AddNewTaskscreenState();
}

class _AddNewTaskscreenState extends State<AddNewTaskscreen> {
  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  bool  _addNewTaskInProgress = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
             // spacing: 16,  sob  jagate same spaching dibe
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               SizedBox(height: 40,),
                Text("Add New Task",style: Theme.of(context).textTheme.titleLarge,),
                SizedBox(height: 16,),
                TextFormField(
                  controller: _titleController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Title'
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty??true)
                    {
                      return "Enter your title";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8,),
                TextFormField(
                  maxLines: 5,

                  controller: _descriptionController,
                  decoration: InputDecoration(
                      hintText: 'Description'
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty??true)
                    {
                      return "Enter your description";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                Visibility(
                  visible: _addNewTaskInProgress == false,
                    replacement: CenterCircularIndicator(),
                    child: ElevatedButton(onPressed: _onTabSignUpButton , child: Icon(Icons.arrow_circle_right_outlined)))


              ],
            ),
          ),
        ),
      ),
    );
  }
  void _onTabSignUpButton(){
    if(_formkey.currentState!.validate()){
      //TODO: Add new task
      _addNewTask();
    }
  }
  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});

    Map<String, String> requestBody = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New",
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createNewTaskUrl,
      body: requestBody,
    );

    _addNewTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _titleController.clear();
      _descriptionController.clear();
      showSnackBarMessage(context, 'Added new task');
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
