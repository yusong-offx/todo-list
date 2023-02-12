import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/pages/components/appbar.dart';

import '../utils/models/todo.dart';

enum SubmitAPI {
  update,
  post,
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Submit Form and buffer
  final GlobalKey<FormState> todoKey = GlobalKey<FormState>();
  Map<String, dynamic> userData = {};
  List<Todo> todos = [];

  // Fetch data init state
  // Todo list order by not done, newest of lastmodified_date
  @override
  void initState() {
    singleton.apiService.getTodos().then((value) {
      todos.clear();
      todos.addAll(value);
      setState(() {});
    });
    super.initState();
  }

  // Refresh function
  Future<void> refreshTodos() async {
    singleton.apiService.getTodos().then((value) {
      todos = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "TODO LIST"),
      body: RefreshIndicator(
        onRefresh: refreshTodos,
        child: Column(
          children: [
            Expanded(
              flex: 95,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                itemCount: todos.length,
                itemBuilder: (context, index) =>
                    todoTextElement(context, index),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: todoAddButton(),
    );
  }

  // Update done/not done
  void onDoneCheckAPI(Todo todo) {
    singleton.apiService.putDoneCheck({
      "done": todo.done,
      "id": todo.id,
      "user_id": todo.userID,
    });
  }

  // Todo elements (Row)
  Widget todoTextElement(context, index) {
    Todo todo = todos[index];
    DateTime modifiedTime = todo.lastModifiedDate;
    String date =
        "${modifiedTime.year}/${modifiedTime.month}/${modifiedTime.day}-${modifiedTime.hour}:${modifiedTime.minute}:${modifiedTime.second}";
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                  value: todo.done,
                  onChanged: (done) => setState(() {
                        todo.done = done!;
                        onDoneCheckAPI(todo);
                      })),
              TextButton(
                onPressed: () => todoDialog(todo),
                child: Text(todo.title),
              )
            ],
          ),
          Text(date),
        ],
      ),
    );
  }

  // Add, Update Button
  void todoDialog(Todo? data) {
    // Add, Update determin api
    var submitApi = data == null ? SubmitAPI.post : SubmitAPI.update;
    Widget openDialog(BuildContext context) {
      List<Widget> items = [
        Text(
          "What to do?",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        TextFormField(
          initialValue: data?.title,
          onSaved: (newValue) => (userData["title"] = newValue),
          validator: (value) => value == "" ? "What to do?" : null,
          decoration: const InputDecoration(
            label: Text("What to.."),
          ),
        ),
        TextFormField(
          initialValue: data?.contents,
          onSaved: (newValue) => (userData["contents"] = newValue),
          maxLines: 4,
          maxLength: 1000,
          decoration: const InputDecoration(
            label: Text("Do.."),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          // Delete button only for todo element
          if (data != null)
            OutlinedButton(
              child: const Text("delete"),
              onPressed: () {
                singleton.apiService.deleteTodo(data.id);
                Navigator.pop(context);
              },
            ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: () async {
              // Check validation
              // Validations are in each TextFormField
              if (!todoKey.currentState!.validate()) {
                return;
              }
              todoKey.currentState!.save();
              // Submit API
              if (submitApi == SubmitAPI.update) {
                userData["id"] = data!.id;
                singleton.apiService.putTodo(userData);
              } else {
                singleton.apiService.postTodo(userData);
              }
              // Reset and pop
              todoKey.currentState!.reset();
              Navigator.of(context).pop();
            },
            child: const Text("Submit"),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: () {
              todoKey.currentState!.reset();
              Navigator.of(context).pop();
            },
            child: const Text("Close"),
          ),
        ]),
      ];

      return AlertDialog(
        content: Form(
          key: todoKey,
          child: SizedBox(
            width: singleton.getDeviceSize(context).width,
            height: singleton.getDeviceSize(context).height / 3,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: items.length,
              itemBuilder: (context, index) => items[index],
            ),
          ),
        ),
      );
    }

    showDialog(context: context, builder: openDialog);
  }

  Widget todoAddButton() {
    // Clear Submit form buffer
    userData.clear();
    return FloatingActionButton(
      onPressed: () => todoDialog(null),
      tooltip: 'Add',
      child: const Icon(Icons.add),
    );
  }
}
