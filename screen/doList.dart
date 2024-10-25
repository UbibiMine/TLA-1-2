import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/task_provider.dart';

class doList extends ConsumerWidget {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskProvider);
    final taskNotifier = ref.read(taskProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Add New Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      taskNotifier.addTask(_taskController.text);
                      _taskController.clear();
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskState.tasks.length,
              itemBuilder: (context, index) {
                final task = taskState.tasks[index];
                return ListTile(
                  title: Text(task.name),
                  trailing: Checkbox(
                    value: task.isDone,
                    onChanged: (bool? value) {
                      taskNotifier.moveToDone(task);
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
