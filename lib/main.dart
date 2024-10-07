import 'package:flutter/material.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(hintText: 'Enter task name'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tasks.add(Task(_taskController.text, false));
                      _taskController.clear(); // Clear the input field
                    });
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Checkbox to mark task as completed/incomplete
                      Checkbox(
                        value: tasks[index].isCompleted,
                        onChanged: (value) {
                          setState(() {
                            tasks[index].isCompleted = value!;
                          });
                        },
                      ),
                      // Delete button to remove task from the list
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            tasks.removeAt(index); // Remove task from the list
                          });
                        },
                      ),
                    ],
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
