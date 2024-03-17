import 'package:flutter/material.dart';

class TaskList {
  String name;
  bool isPublic;
  List<Task> tasks;

  TaskList({required this.name, required this.isPublic, required this.tasks});
}

class Task {
  String name;
  String description;
  bool isImportant;
  bool isCompleted;
  DateTime lastModified;
  DateTime createdAt;

  Task(
      {required this.name,
      required this.description,
      this.isImportant = false,
      this.isCompleted = false,
      required this.lastModified,
      required this.createdAt});
}

class MyApp extends StatelessWidget {
  final List<TaskList> taskLists = [
    TaskList(
      name: "Домашние дела",
      isPublic: true,
      tasks: [
        Task(
          name: "Почистить квартиру",
          description: "Вымыть полы, вынести мусор",
          isImportant: true,
          isCompleted: false,
          lastModified: DateTime.now(),
          createdAt: DateTime.now(),
        ),
        Task(
          name: "Приготовить ужин",
          description: "Приготовить пасту с овощами",
          isImportant: false,
          isCompleted: true,
          lastModified: DateTime.now(),
          createdAt: DateTime.now(),
        ),
      ],
    ),
    TaskList(
      name: "Работа",
      isPublic: true,
      tasks: [
        Task(
          name: "Завершить отчет",
          description: "Доделать презентацию",
          isImportant: true,
          isCompleted: false,
          lastModified: DateTime.now(),
          createdAt: DateTime.now(),
        ),
      ],
    ),
  ];

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Списки задач'),
        ),
        body: ListView.builder(
          itemCount: taskLists.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(taskLists[index].name),
              onTap: () {
                // Перейти к просмотру задач в списке
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TaskListScreen(taskList: taskLists[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  final TaskList taskList;

  const TaskListScreen({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(taskList.name),
      ),
      body: ListView.builder(
        itemCount: taskList.tasks.length,
        itemBuilder: (context, index) {
          Task task = taskList.tasks[index];
          return ListTile(
            title: Text(
              task.name,
              style: task.isCompleted
                  ? const TextStyle(decoration: TextDecoration.lineThrough)
                  : const TextStyle(),
            ),
            subtitle: Text(task.description),
            trailing: task.isImportant ? const Icon(Icons.warning) : null,
          );
        },
      ),
    );
  }
}
