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
  String _selectedPriority = 'Low'; // Default priority

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
                // Dropdown for selecting task priority
                DropdownButton<String>(
                  value: _selectedPriority,
                  items: ['Low', 'Medium', 'High'].map((String priority) {
                    return DropdownMenuItem<String>(
                      value: priority,
                      child: Text(priority),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPriority = newValue!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tasks.add(Task(_taskController.text, false, _selectedPriority));
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
                  // Display task name along with its priority
                  title: Text('${tasks[index].name} (${tasks[index].priority})'),
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

// Task Model with Priority
class Task {
  String name;
  bool isCompleted;
  String priority; // Task priority: Low, Medium, High

  Task(this.name, this.isCompleted, this.priority);
}
