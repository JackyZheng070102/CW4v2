import 'package:flutter/material.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // List to store tasks
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Column(
        children: [
          // Task input and add button will be added here
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].name),
                  trailing: Checkbox(
                    value: tasks[index].isCompleted,
                    onChanged: (value) {
                      setState(() {
                        tasks[index].isCompleted = value!;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Basic Task Model
class Task {
  String name;
  bool isCompleted;

  Task(this.name, this.isCompleted);
}
