import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/pages/components/appbar.dart';

import '../utils/models/todo.dart';

final mockData = [
  Todo(
    done: true,
    title: "hello world!",
    contents: "work hard play hard",
    createDate: DateTime.now(),
    lastModifiedDate: DateTime.now(),
  ),
  Todo(
    done: false,
    title: "hello world!",
    contents: "work hard play hard",
    createDate: DateTime.now(),
    lastModifiedDate: DateTime.now(),
  )
];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "TODO LIST"),
      body: Column(
        children: [
          Expanded(
            flex: 95,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              itemCount: mockData.length,
              itemBuilder: (context, index) => todoTextElement(context, index),
            ),
          ),
        ],
      ),
      floatingActionButton: todoAddButton(null),
    );
  }

  Widget todoTextElement(context, index) {
    Todo todo = mockData[index];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Checkbox(
              value: todo.done,
              onChanged: (done) => setState(() {
                    todo.done = done!;
                  })),
          TextButton(
            onPressed: () => todoDialog(todo),
            child: Text(todo.title),
          )
        ],
      ),
    );
  }

  void todoDialog(Todo? data) {
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
          OutlinedButton(
            onPressed: () {
              // Check validation
              // Validations are in each TextFormField
              if (!todoKey.currentState!.validate()) {
                return;
              }
              todoKey.currentState!.save();
              // Submit API

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

  Widget todoAddButton(Todo? data) {
    // Clear Submit form buffer
    userData.clear();
    return FloatingActionButton(
      onPressed: () => todoDialog(data),
      tooltip: 'Add',
      child: const Icon(Icons.add),
    );
  }
}
