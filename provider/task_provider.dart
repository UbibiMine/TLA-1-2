import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/Model/task.dart';

class TaskState {
  final List<taskDo> tasks;
  final List<taskDo> doneTasks;

  TaskState({required this.tasks, required this.doneTasks});
}

class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier() : super(TaskState(tasks: [], doneTasks: []));

  void addTask(String taskName) {
    state = TaskState(
      tasks: [...state.tasks, taskDo(name: taskName)],
      doneTasks: state.doneTasks,
    );
  }


  void moveToDone(taskDo task) {
    state = TaskState(
      tasks: state.tasks..remove(task),
      doneTasks: [...state.doneTasks, task..isDone = true],
    );
  }

 
  void deleteTask(taskDo task) {
    state = TaskState(
      tasks: state.tasks,
      doneTasks: state.doneTasks..remove(task),
    );
  }
}


final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  return TaskNotifier();
});
