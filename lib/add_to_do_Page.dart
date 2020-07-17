import 'package:flutter/material.dart';
import 'package:etiqa_test_app/helper/database_helper.dart';
import 'package:etiqa_test_app/models/task.dart';
import 'package:etiqa_test_app/main.dart';
import 'package:etiqa_test_app/helper/utils.dart';

var globalDate = "Pick Date";

class new_task extends StatefulWidget {
  final String appBarTitle;
  final Task task;
  MyHomePageState todoState;
  new_task(this.task, this.appBarTitle, this.todoState);
  bool _isEditable = false;

  @override
  State<StatefulWidget> createState() {
    return task_state(this.task, this.appBarTitle, this.todoState);
  }
}

class task_state extends State<new_task> {
  MyHomePageState todoState;
  String appBarTitle;
  Task task;
  List<Widget> icons;
  task_state(this.task, this.appBarTitle, this.todoState);

  bool marked = false;

  // TextStyle titleStyle = new TextStyle(
  //   fontSize: 18,
  //   fontFamily: "Lato",
  // );

  // TextStyle buttonStyle =
  //     new TextStyle(fontSize: 18, fontFamily: "Lato", color: Colors.white);

  final scaffoldkey = GlobalKey<ScaffoldState>();

  DatabaseHelper helper = DatabaseHelper();
  Utils utility = new Utils();
  TextEditingController taskController = new TextEditingController();

  var formattedDate = "Start Date";
  var formattedDateEnd = "Estimate End Date";
  var _minPadding = 10.0;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay();

  @override
  Widget build(BuildContext context) {
    taskController.text = task.task;
    return Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          leading: new GestureDetector(
            child: Icon(Icons.chevron_left, size: 30),
            onTap: () {
              Navigator.pop(context);
              todoState.updateListView();
            },
          ),
          title: Text(appBarTitle),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(_minPadding),
            child: TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: "To-Do Title",
                hintText: "Please key in your to-do title here",
              ), //Input Decoration
              onChanged: (value) {
                updateTask();
              },
            ), //TextField
          ), //Padding

          ListTile(
            title: task.date.isEmpty
                ? Text(
                    "Start Date",
                  )
                : Text(task.date),
            subtitle: Text(""),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              var pickedDate = await utility.selectDate(context, task.date);
              if (pickedDate != null && !pickedDate.isEmpty)
                setState(() {
                  this.formattedDate = pickedDate.toString();
                  task.date = formattedDate;
                });
            },
          ), //DateListTile

          ListTile(
            title: task.date_end.isEmpty
                ? Text(
                    "Estimate End Date",
                  )
                : Text(task.date_end),
            subtitle: Text(""),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              var pickedDate = await utility.selectDate(context, task.date_end);
              if (pickedDate != null && !pickedDate.isEmpty)
                setState(() {
                  this.formattedDateEnd = pickedDate.toString();
                  task.date_end = formattedDateEnd;
                });
            },
          ), //TimeListTile

          Padding(
            padding: EdgeInsets.all(_minPadding),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              padding: EdgeInsets.all(_minPadding / 2),
              color: Colors.black,
              textColor: Colors.white,
              elevation: 5.0,
              child: Text(
                "Create Now",
                textAlign: TextAlign.center,
                textScaleFactor: 1.2,
              ),
              onPressed: () {
                setState(() {
                  _save();
                });
              },
            ), //RaisedButton
          ), //Padding

          Padding(
            padding: EdgeInsets.all(_minPadding),
            child: _isEditable()
                ? RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    padding: EdgeInsets.all(_minPadding / 2),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    elevation: 5.0,
                    child: Text(
                      "Delete",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.2,
                    ),
                    onPressed: () {
                      setState(() {
                        _delete();
                      });
                    },
                  ) //RaisedButton
                : Container(),
          ) //Padding
        ]) //ListView

        ); //Scaffold
  } //build()

  void markedDone() {}

  bool _isEditable() {
    if (this.appBarTitle == "Add new To-Do List")
      return false;
    else {
      return true;
    }
  }

  void updateTask() {
    task.task = taskController.text;
  }

  //InputConstraints
  bool _checkNotNull() {
    bool res;
    if (taskController.text.isEmpty) {
      utility.showSnackBar(scaffoldkey, 'Task cannot be empty');
      res = false;
    } else if (task.date.isEmpty) {
      utility.showSnackBar(scaffoldkey, 'Please select the Date');
      res = false;
    } else if (task.date_end.isEmpty) {
      utility.showSnackBar(scaffoldkey, 'Please select the Estimate End Date');
      res = false;
    } else {
      res = true;
    }
    return res;
  }

  //Save data
  void _save() async {
    int result;
    if (_isEditable()) {
      if (marked) {
        task.status = "Task Completed";
      } else
        task.status = "";
    }
    //task.task = taskController.text;
    //task.date = formattedDate;

    if (_checkNotNull() == true) {
      if (task.id != null) {
        //Update Operation
        result = await helper.updateTask(task);
      } else {
        //Insert Operation
        result = await helper.insertTask(task);
      }

      todoState.updateListView();

      Navigator.pop(context);

      if (result != 0) {
        utility.showAlertDialog(context, 'Status', 'Task saved successfully.');
      } else {
        utility.showAlertDialog(context, 'Status', 'Problem saving task.');
      }
    }
  } //_save()

  void _delete() {
    int result;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure, you want to delete this task?"),
            actions: <Widget>[
              RawMaterialButton(
                onPressed: () async {
                  await helper.deleteTask(task.id);
                  todoState.updateListView();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  utility.showSnackBar(
                      scaffoldkey, 'Task Deleted Successfully.');
                },
                child: Text("Yes"),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"),
              )
            ],
          );
        });
  }
} //class task_state
