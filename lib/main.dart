import 'package:etiqa_test_app/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:etiqa_test_app/helper/database_helper.dart';
import 'package:etiqa_test_app/helper/custom_widget.dart';
import 'package:etiqa_test_app/helper/utils.dart';
import 'package:etiqa_test_app/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:etiqa_test_app/add_to_do_Page.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ETIQA IT',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  Utils utility = new Utils();
  List<Task> taskList;
  int count = 0;
  final homeScaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (taskList == null) {
      taskList = List<Task>();
      updateListView();
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                future: databaseHelper.getInCompleteTaskList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Text("Loading");
                  } else {
                    if (snapshot.data.length < 1) {
                      return Center(
                        child: Text(
                          'No Tasks Added',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int position) {
                          return new GestureDetector(
                              onTap: () {
                                if (snapshot.data[position].status !=
                                    "Task Completed")
                                  navigateToTask(snapshot.data[position],
                                      "Edit Task", this);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                margin: EdgeInsets.all(10.0),
                                elevation: 3.0,
                                child: CustomWidget(
                                  title: snapshot.data[position].task,
                                  sub1: snapshot.data[position].date,
                                  sub2: snapshot.data[position].date_end,
                                  status: snapshot.data[position].status,
                                  delete: snapshot.data[position].status ==
                                          "Task Completed"
                                      ? IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: null,
                                        )
                                      : Container(),
                                  trailing: Icon(
                                    Icons.edit,
                                    color: Theme.of(context).primaryColor,
                                    size: 28,
                                  ),
                                ),
                              ) //Card
                              );
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FloatingActionButton(
          onPressed: () {
            // Navigator.of(context).pushNamed(
            //   '/add_to_do',
            //   arguments: 'Hello there from second page',
            // );
            navigateToTask(Task('', '', '', ''), "Add new To-Do List", this);
          },
          tooltip: 'Add Task',
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void navigateToTask(Task task, String title, MyHomePageState obj) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new_task(task, title, obj)),
    );
    // if (result == true) {
    updateListView();
    // }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = databaseHelper.getTaskList();
      taskListFuture.then((taskList) {
        setState(() {
          this.taskList = taskList;
          this.count = taskList.length;
        });
      });
    });
  } //updateListView()

  void delete(int id) async {
    await databaseHelper.deleteTask(id);
    updateListView();
    //Navigator.pop(context);
    utility.showSnackBar(homeScaffold, 'Task Deleted Successfully');
  }
}
