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
                      _taskController.clear();
                      _sortTasksByPriority(); // Sort tasks by priority
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
                  title: Text('${tasks[index].name} (${tasks[index].priority})'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: tasks[index].isCompleted,
                        onChanged: (value) {
                          setState(() {
                            tasks[index].isCompleted = value!;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            tasks.removeAt(index);
                            _sortTasksByPriority(); // Re-sort after deletion
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

  // Sorting tasks by priority: High > Medium > Low
  void _sortTasksByPriority() {
    tasks.sort((a, b) {
      return _getPriorityValue(b.priority).compareTo(_getPriorityValue(a.priority));
    });
  }

  // Helper function to assign a numerical value to priorities
  int _getPriorityValue(String priority) {
    switch (priority) {
      case 'High':
        return 3;
      case 'Medium':
        return 2;
      case 'Low':
      default:
        return 1;
    }
  }
}

class Task {
  String name;
  bool isCompleted;
  String priority;

  Task(this.name, this.isCompleted, this.priority);
}
