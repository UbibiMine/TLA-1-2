import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/task_provider.dart';

class doneList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskProvider);
    final taskNotifier = ref.read(taskProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Done List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: taskState.doneTasks.length,
        itemBuilder: (context, index) {
          final task = taskState.doneTasks[index];
          return ListTile(
            title: Text(task.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                taskNotifier.deleteTask(task);
              },
            ),
          );
        },
      ),
    );
  }
}
